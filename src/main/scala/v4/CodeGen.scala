package v4

trait CodeGen extends BaseParsers { this:Signature =>
  private val head = new CodeHeader(this) // User code and helpers store
  private var order:List[String]=Nil // Order of parsers evaluation

  // Dependency analysis: computation order between tabulations
  def tabsOrder:List[String] = {
    def deps[T](q:Parser[T]): List[String] = q match {
      case Aggregate(p,_) => deps(p) case Filter(p,_) => deps(p) case Map(p,_) => deps(p) case Or(l,r) => deps(l)++deps(r)
      case Concat(l,r,_) => (if (l.min==0) deps(r) else Nil) ::: (if (r.min==0) deps(l) else Nil) // access same element when other is empty
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

  // Cost matrix : cost_t = parser_name -> cost
  // Backtracking: back_t = parser_name -> (rule, positions)
  override def analyze:Boolean = { if (!super.analyze) return false; order=tabsOrder;
    head.add("typedef struct { "+order.map{n=>tpAnswer+" "+n+";"}.mkString(" ")+" } cost_t;\n#define TC cost_t")
    head.add("typedef struct {\n  "+order.map{n=>val c=rules(n).inner.cat; "struct { short rule;"+(if(c>0)" short pos["+c+"];"else"")+" } "+n+";"}.mkString("\n  ")+"\n} back_t;\n#define TB back_t")
    true
  }

  // Define the 'init' value (for max/min) and the 'empty' value for the initialization of cells (break loops)
  var (vInit,vEmpty,tpAnswer):(String,String,String)=(null,null,null)
  def setDefaults(init:Answer,empty:Answer) { tpAnswer=head.addType(head.tpOf(init)); vInit=head.getVal(init.toString); vEmpty=head.getVal(empty.toString) }

  // Parser normalization
  // Canonical : [Tabulate] > Aggregate > Or > Filter > Map > Concat > (Tabulate | Terminal)
  // C code    : [Tabulate] > Or > ForLoop+Filter > Aggregate1 > Map > (Tabulate | Terminal)
  // Invariant : Aggregate > Map > Concat (due to domain change)
  def norm[T](parser:Parser[T]):Parser[T] = parser match {
    case Or(l,r) => Or(norm(l),norm(r))
    case Filter(p0,c) => norm(p0) match {
      case Or(l,r) => Or(norm(Filter(l,c)),norm(Filter(r,c)))
      case p => Filter(p,c)
    } 
    case Aggregate(p0,h) => norm(p0) match {
      case Filter(p,f) => Filter(norm(Aggregate(p,h)),f)
      case Or(l,r) => Or(norm(Aggregate(l,h)),norm(Aggregate(r,h)))
      case p => Aggregate(p,h)
    }
    case Map(p0,f) => norm(p0) match {
      case Filter(p,c) => Filter(norm(Map(p,f)),c)
      case Or(l,r) => Or(norm(Map(l,f)),norm(Map(r,f)))
      case p => Map(p,f)
    }
    // XXX: does this preserve the alternative numbering ? make sure...
    case Concat(l0,r0,t) => (norm(l0),norm(r0)) match {
      case (Or(a,b),r) => Or(norm(Concat(a,r,t)),norm(Concat(b,r,t)))
      case (l,Or(a,b)) => Or(norm(Concat(l,a,t)),norm(Concat(l,b,t)))
      case (l,r) => Concat(l,r,t)
    }
    case _ => parser
  }



  /*
  Steps:
  1. Make all the function implement CodeFun
  2. Get all the declarations (user method, input and output types, backtrack, alphabet class)
     - convert values to C
     - convert types to C (see playground.Play)
     - convert functions ot C
  3. Generate code for the kernel
  */
  // Demo (assumes   case class Mat(rows:Int, cols:Int)   in the final class)
  /*
    val foo = new CodeFun{ // tree{ (x:Mat) => Mat(x.cols,x.rows) }
      val tpIn="Mat"
      val tpOut="Mat"
      val body="_res=(mat_t){_arg.cols,_arg.rows}"
    }
    val foo2 = new CodeFun { //(x:(Int,(Int,Int))) => x._1 * x._2._1 + x._2._2
      val tpIn="(Int,(Int,Int))"
      val tpOut="Int"
      val body="_res=_arg._1 * _arg._2._1 + _arg._2._2"
    }
    println(head.add(foo))
    println(head.add(foo2))
  */
  // XXX: idea: fill the matrix with an EMPTY value, then whenever we hit this value, we ignore the result

  // --------------------------------------------------------------------------
  // C code generator

  def gen:String = { analyze
    println("Problem type: "+(if (twotracks) "sequence alignment" else "standard" )+(if (window>0) ", window="+window else ""));
    println("---------- analysis -----------")
    order.zipWithIndex.foreach{case (n,i)=>val p=rules(n); println("Rule #"+i+" '"+n+"': base_id="+p.id+", alts="+p.inner.alt+", ccats="+p.inner.cat+" min="+p.min+", max="+p.max) }
    println("------------ defs -------------")
    print(head.flush)
    println("------------ rules ------------")
    println("back_t b = {"+order.map{n=>val c=rules(n).inner.cat;"{-1"+(if(c>0)",{"+(0 until c).map{"0"}.mkString(",")+"}"else"")+"}"}.mkString(",")+"};")
    println("cost_t c = {"+order.map{n=>vInit}.mkString(",")+"},c2;")
    order.foreach { n=> val r=rules(n);
      println("// --- "+n+"[i,j] ---")
      println(emit(r.inner)) // XXX: resolve this point
    }
    println("------------- end -------------")
    ""
  }

  // A simple variable generator that sequentially issues free variables
  class FreeVar(v0:Char) {
    private var v=v0
    def get = { var r=v; v=(v+1).toChar; Var(r,0) }
    def dup = new FreeVar(v0)
  }

  // 1. Assign to each node its bounds (i,j)
  // 2. Collect all the conditions from the tree and its content body
  // Given bounds [i,j] and a FreeVar generator, returns a list of conditions/loops and the body of the operator
  def gen[T](q:Parser[T],i:Var,j:Var,g:FreeVar):(List[Cond],String) = q match {
    case Terminal(_,_,f) => f(i,j)
    case Aggregate(p,h) => val (c,b)=gen(p,i,j,g); // XXX: missing rule_id, backtrack and tabulate's (name,id)
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
    case cc@Concat(l,r,0) =>
      def bf1(f:Int, l:Int, u:Int):List[Cond] = { val ls=List(i.leq(j,f+l)); if (u>0) j.leq(i,-f-u)::ls else ls }
      val (c,k):(List[Cond],Var) = cc.indices match {
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
    case cc@Concat(l,r,1) => val (a,b,_,_)=cc.indices
      val (c,k) = if (a==b && a>0) (zero.leq(i,1), i.add(-a))
                  else { val k0=g.get; (CFor(k0.v,'0',1,i.v,1), k0) }
      val (lc,lb) = gen(l,k,i,g)
      val (rc,rb) = gen(r,k,j,g)
      (simplify(c :: lc ::: rc), lb+" ~TT~ "+rb)
    case cc@Concat(l,r,2) => val (_,_,a,b)=cc.indices
      val (c,k) = if (a==b && a>0) (zero.leq(j,1), j.add(-a))
                  else { val k0=g.get; (CFor(k0.v,'0',1,j.v,1), k0) }
      val (lc,lb) = gen(l,i,k,g)
      val (rc,rb) = gen(r,k,j,g)
      (simplify(c :: lc ::: rc), lb+" ~TT~ "+rb)
    case t:Tabulate => (Nil, t.name+"["+i+","+j+"]")
    case _ => (Nil,toString)
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
