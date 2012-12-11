package v4

trait CodeGen extends BaseParsers { this:Signature =>
  // A simple variable generator that sequentially issues free variables
  class FreeVar(v0:Char) {
    private var v=v0
    def get = { var r=v; v=(v+1).toChar; Var(r,0) }
    def dup = new FreeVar(v0)
  }

  // ------------------------------------------------------------------------------
  // Recurrence analysis, done once when grammar is complete, before the computation.
  // 1) Unique identifiers for subrules (sorted by name, ensures unique id within one grammar, done in super=BaseParsers)
  // 2) Maximal backtrack size (cuda: #define TB)
  // 3) Compute cost storage (cuda: #define TC)
  // 4) Dependency analysis (order within the pass, possibly if multiple pass are needed, check if all parsers are needed?)
  private var cdefs:String=""
  override def analyze:Boolean = { if (!super.analyze) return false;
    var bt=0; for((n,p) <- rules) bt=Math.max(bt,p.cat)
    cdefs=cdefs+"typedef struct { short rule; short pos["+bt+"]; } back_t;\n#define TB back_t\n"
    // XXX: issue, we might have multiple backtrack in different tabulations at the same position

    // XXX: 3) find the type of all involved recurrences: TypeOf[Answer]
    //type T = Array[String]
    //println("4: " + classOf[T])
    cdefs=cdefs+"typedef struct { ??? } cost_t;\n#define TC cost_t\n"

    val order=tabsOrder // dependency analysis

    println("---------- analysis -----------")
    for((n,p) <- rules) println(n+": base_id="+p.id+", alternatives="+p.alt+", concatMax="+p.cat);
    println("Order in which to process tabulations: "+order)
    println("------------- end -------------")
    true
  }

  // Dependency analysis: give the computation order between tabulations
  def tabsOrder:List[String] = {
    def deps[T](q:Parser[T]): List[String] = q match {
      case Aggregate(p,_) => deps(p) case Filter(p,_) => deps(p) case Map(p,_) => deps(p) case Or(l,r) => deps(l)++deps(r)
      case Concat(_,_,_) => Nil // always access previous element within concat
      case _ => if (q.isInstanceOf[Tabulate]) List(q.asInstanceOf[Tabulate].name) else Nil
    }
    var order = List[String]()
    val cs = rules.map{case (n,p)=>(n,deps(p.inner)) }
    while (!cs.isEmpty) { var rem=false;
      cs.foreach { case (n,ds) if (ds.isEmpty||(true/:ds.map{d=>order.contains(d)}){case(a,b)=>a&&b}) => rem=true; order=n::order; cs.remove(n); case _ => }
      if (rem==false) sys.error("Loop between tabulations, error in grammar")
    }
    order.reverse
  }

  // XXX: idea: fill the matrix with an EMPTY value, then whenever we hit this value, we ignore the result
    /*
    val tc = scala.reflect.classTag[TC].runtimeClass.toString
    val ti:(String,String) = scala.reflect.classTag[TI].runtimeClass match {
      case cl if (type_jni.contains(cl.toString)) => val cn=cl.toString;
        ("#define TI "+type_c(cn),"  for (i=0;i<size;++i) (*in)[i] = (TI)env->Get"+up1(cn)+"ArrayElement(input, i);\n")
      case cl =>
        //println(manifest[T].erasure.getConstructors.mkString(", "))
        val ts = cl.getDeclaredFields.map{x=>(x.getType.toString,x.getName)}
        val ms = ts.map{ case(t,n)=> "env->GetMethodID(cls, \""+n+"\", \"()"+type_jni(t)+"\")," }
        var es = ts.zipWithIndex.map{ case((t,n),i) => "e->"+n+" = env->Call"+up1(t)+"Method(elem, ms["+i+"]);" }
        ("typedef struct { "+ts.map{case (t,n)=>type_c(t)+" "+n+";"}.mkString(" ")+" } in_t;\n#define TI in_t",
         "  jmethodID ms[] = {\n    "+ms.mkString("\n    ")+"\n  };\n\n  for (i=0;i<size;++i) {\n"+
         "    elem = env->GetObjectArrayElement(input, i);\n    TI* e = &((*in)[i]);\n    "+es.mkString("\n    ")+"\n  }\n")
    }
    */
  // manifest to grab class infos
  // Get matrices storage type and backtracking length
/*
 * Code generation:
 * 1. Normalize rules (at hash-map insertion (?))
 * 2. Compute dependency analysis between rules => order them into a list/queue
 *    - If rule R contains another rule S unconcatenated (or concatenated with empty)
 *      then we have S -> T (S before T)
 * 3. Compute the maximal number of concatenation among each rule (field in Treeable(?))
 * 4. Break rules into subrules (at each Or, which must be at top of the rule)
 */

  // ------------------------------------------------------------------------------
  // C code generator

  def gen:String = {
    println
    println("Problem type: "+(if (twotracks) "sequence alignment" else "standard" )+(if (window>0) ", window="+window else ""));
    println("------------ defs -------------")
    print(cdefs)
    println("------------ rules ------------")
    for((n,p) <- rules) {
      println( n+"[i,j] => "+emit(p.inner))
    }
    println("------------- end -------------")
    ""
  }

  // Normalize the parser
  def norm[T](parser:Parser[T]):Parser[T] = parser match {
    case Aggregate(p0,h) => norm(p0) match {
      case Filter(p,f) => Filter(norm(Aggregate(p,h)),f)
      case Or(l,r) => Or(norm(Aggregate(l,h)),norm(Aggregate(r,h)))
      case p => Aggregate(p,h)
    }
    case Map(p0,f) => norm(p0) match {
      case Filter(p,c) => Filter(norm(Map(p,f)),c)
      case p => Map(p,f)
    }
    case Filter(p,c) => Filter(norm(p),c)
    case Or(l,r) => Or(norm(l),norm(r))
    case Concat(l,r,i) => Concat(norm(l),norm(r),i)
    case _ => parser
  }

  // 1. Assign to each node its bounds (i,j)
  // 2. Collect all the conditions from the tree and its content body
  // Given bounds [i,j] and a FreeVar generator, returns a list of conditions/loops and the body of the operator
  def gen[T](q:Parser[T],i:Var,j:Var,g:FreeVar):(List[Cond],String) = q match {
    case Terminal(_,_,f) => f(i,j)
    case Aggregate(p,h) => val (c,b)=gen(p,i,j,g);
      h.toString match {
        case "$$max$$" => (c, "max("+b+")")
        case "$$min$$" => (c, "min("+b+")")
        case "$$count$$" => (c, "count("+b+")")
        case "$$sum$$" => (c, "sum("+b+")")
        case _ => (c, "Aggr_"+h.toString+"("+b+")")
      }
    case Or(l,r) => (Nil, emit(gen(l,i,j,g.dup))+"\n       ++ "+emit(gen(r,i,j,g.dup)))
    case Map(p,f) => val (c,b)=gen(p,i,j,g); (c, "Map("+b+")")
    case Filter(p,f) => val (c,b)=gen(p,i,j,g); (c, "Filter("+b+")")
    case Concat(l,r,indices) if (twotracks==false) =>
      def bf1(f:Int, l:Int, u:Int):List[Cond] = { val ls=List(i.leq(j,f+l)); if (u>0) j.leq(i,-f-u)::ls else ls }
      val (c,k):(List[Cond],Var) = indices match {
        // low=up in at least one side
        case (0,0,0,0) => val k0=g.get; (List(k0.loop(i,j)), k0)
        case (iL,iU,0,0) if (iL==iU) => (List(i.leq(j,iL)), i.add(iL))
        case (0,0,jL,jU) if (jL==jU) => (List(i.leq(j,jL)), j.add(-jL))
        case (iL,iU,jL,jU) if (iL==iU && jL==jU) => (List(i.eq(j,iL+jL)), i.add(iL))
        case (iL,iU,jL,jU) if (iL==iU) => (bf1(iL,jL,jU), i.add(iL))
        case (iL,iU,jL,jU) if (jL==jU) => (bf1(jL,iL,iU), j.add(-jL))
        // most general case
        case (iL,iU,jL,jU) => val k0=g.get; var cs:List[Cond]=Nil;
          if (jU>0) cs = j.leq(k0,-jU) :: cs
          if (iU>0) cs = i.leq(k0,iU) :: cs
          // we might want to simplify if min_k==i || max_k==j
          (CFor(k0.v,i.v,iL,j.v,jL)::cs, k0)
      }
      val (lc,lb) = gen(l,i,k,g)
      val (rc,rb) = gen(r,k,j,g)
      (simplify(c ::: lc ::: rc), lb+" ~ "+rb)

    case Concat(l,r,(a,b,track,_)) if (twotracks==true) =>
      val (c,(lc,lb),(rc,rb)) = track match {
        case 1 => val (c,k) = if (a==b && a>0) (zero.leq(i,1), i.add(-a))
                              else { val k0=g.get; (CFor(k0.v,'0',1,i.v,1), k0) }
          (List(c),gen(l,k,i,g),gen(r,k,j,g))
        case 2 => val (c,k) = if (a==b && a>0) (zero.leq(j,1), j.add(-a))
                              else { val k0=g.get; (CFor(k0.v,'0',1,j.v,1), k0) }
          (List(c),gen(l,i,k,g),gen(r,k,j,g))
      }
      (simplify(c ::: lc ::: rc), lb+" ~TT~ "+rb)
    //case Tabulate(p,name) => (Nil, name+"["+i+","+j+"]")
    case _ =>
      if (q.isInstanceOf[Tabulate]) {
        (Nil, q.asInstanceOf[Tabulate].name+"["+i+","+j+"]")
      }
      else (Nil,toString)
  }

  // Optimizations and conditions simplifications
  def simplify(conds: List[Cond]):List[Cond] = {
      var cs = conds
      // 1. filter x+0=x
      cs = cs.filter { case CEq(a,b,0) if (a==b) => false case _ => true }
      // 2. minimize the range of for loop
      cs = cs.map { case CFor(v,l,ld,u,ud) => var lm=ld; var um=ud;
          cs.foreach { case CLeq(a,b,d) =>
              if (a==l && b==v) { if (d>lm) lm=d; }
              if (a==v && b==u) { if (d>um) um=d; }
            case _ =>
          }
          CFor(v,l,lm,u,um)
        case x => x
      }
      // 3. drop useless Leq (either contained by a for or superseded by another constraint on the same pair)
      cs.foreach {
        case CLeq(a,b,x) => cs=cs.filter { case CLeq(c,d,y) if (c==a && d==b && y<x) => false case _ => true }
        case CFor(v,l,_,u,_) => cs=cs.filter { case CLeq(c,d,_) if (c==l && d==v || c==v && d==u) => false case _ => true }
        case _ =>
      }
      cs
  }

  def emit[T](p:Parser[T]):String = emit(gen(norm(p),Var('i',0),Var('j',0),new FreeVar('k')))
  def emit(d:(List[Cond],String)):String = d match { case (cs,body) =>
    cs.map {
      case CFor(v,l,ld,u,0) => "for("+l+(if(ld>0)"+"+ld else "")+" <= "+v+" <= "+u+")"
      case CFor(v,l,ld,u,ud) => v+"u="+u+"-"+ud+"; for("+l+(if(ld>0)"+"+ld else "")+" <= "+v+" <= "+v+"u)"
      case CEq(a,b,d) => "if ("+a+(if(d>0)"+"+d else "")+"=="+b+")"
      case CLeq(a,b,d) => "if ("+a+(if(d>0)"+"+d else "")+"<="+b+")"
    }.map{x=>x+" { "}.mkString("")+body+cs.map{x=>" }"}.mkString("")
  }
}
