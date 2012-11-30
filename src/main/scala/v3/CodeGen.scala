package v3

trait CodeGen { this:Signature =>
  val twotracks = false
  trait Treeable { val tree:PTree } // parser abstraction
  trait TreeRoot extends Treeable { // tabulation abstraction
    def makeTree:PTree
    var id:Int = -1 // subrules base index
  }

  type Tabulation <: TreeRoot
  import scala.collection.mutable.HashMap
  val rules = new HashMap[String,Tabulation]

  // Tree structure for recurrences generation
  sealed abstract class PTree {
    lazy val (alt:Int,ccat:Int) = this match {
      case PAggr(_,p) => (p.alt,p.ccat)
      case PMap(_,p) => (p.alt,p.ccat)
      case PFilter(_,p) => (p.alt,p.ccat)
      case POr(l,r) => (l.alt+r.alt, Math.max(l.ccat,r.ccat))
      case p@PConcat(l,r,_) => (l.alt*r.alt, l.ccat+(if(p.bt)1 else 0)+r.ccat)
      case _ => (1,0)
    }
  }
  case class PTerminal[T](f: (Var,Var) => (List[Cond],String)) extends PTree
  case class PAggr[T](h: List[T] => List[T], p: PTree) extends PTree
  case class POr(l: PTree, r: PTree) extends PTree
  case class PMap[T,U](f: T => U, p: PTree) extends PTree
  case class PFilter(f: ((Int,Int)) => Boolean, p: PTree) extends PTree
  case class PRule(name: String) extends PTree
  case class PConcat(l: PTree, r: PTree, indices:(Int,Int,Int,Int)) extends PTree {
    lazy val bt:Boolean = (twotracks,indices) match {
      case (false,(a,b,c,d)) if ((a==b && a>0) || (c==d && c>0)) => false
      case (true,(a,b,_,_)) if (a==b && a>0) => false
      case _ => true
    }
  }

  // A simple variable generator that sequentially issues free variables
  class FreeVar(v0:Char) {
    private var v=v0
    def get = { var r=v; v=(v+1).toChar; Var(r,0) }
    def dup = new FreeVar(v0)
  }

  // Variables : a name and an offset
  case class Var(v:Char,d:Int) { // 'v'+d
    override def toString = if (d==0) ""+v else if (d>0) v+"+"+d else v+""+d
    def add(e:Int) = Var(v,d+e)
    def loop(l:Var,u:Var) = CFor(v,l.v,d-l.d,u.v,d-u.d)
    def leq(t:Var,e:Int) = CLeq(v,t.v,d-t.d+e)
    def eq(t:Var,e:Int) = CEq(v,t.v,d-t.d+e)
  }
  val zero = Var('0',0) // 0+0

  // Conditions on fresh variables variables
  class Cond // Constraint that is put on variables
  case class CFor(v:Char,l:Char,ld:Int,u:Char,ud:Int) extends Cond // for ('l'+ld<='v'<='u'-ud)
  case class CLeq(a:Char,b:Char,delta:Int) extends Cond // 'a'+delta<='b'
  case class CEq(a:Char,b:Char,delta:Int) extends Cond // 'a'+delta=='b'

  // ------------------------------------------------------------------------------
  // Recurrence analysis, done once when grammar is complete, before the computation.
  // 1) Unique identifiers for subrules
  // 2) Maximal backtrack size (cuda: #define TB)
  // 3) Compute cost storage (cuda: #define TC)
  // 4) Dependency analysis (order within the pass, possibly if multiple pass are needed)
  private var cdefs:String=""
  private var analyzed=false;
  def analyze { if (!analyzed) { analyzed=true
    var id=0; var bt=0; for((n,p) <- rules) { p.id=id; val t=p.makeTree; id=id+t.alt; bt=Math.max(bt,t.ccat); }
    cdefs=cdefs+"typedef struct { short rule; short pos["+bt+"]; } back_t;\n#define TB back_t\n"

    // XXX: TODO 3) and 4)
    cdefs=cdefs+"typedef struct { ??? } cost_t;\n#define TC cost_t\n"
    //println("Dependency analysis => return a define + ordered list of parsers");

    println("---------- analysis -----------")
    for((n,p) <- rules) {
      val t = p.makeTree
      println(n+": base_id="+p.id+", alternatives="+p.makeTree.alt+", concatMax="+p.makeTree.ccat);
      //println(p.makeTree)
    }
    println("------------- end -------------")
  }}
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
  // XXX: prepare for the backtrack, to be called within parse, parse must take axiom as default argument
  // we use the revert if the rule is within alt+altCount
  // XXX: add a revert(rule_id,backtrack):List[(rule_id,backtrack)] function to all parsers
/*
 * Parser construction:
 * 1. Assign a "OR_id" (sub_rule_id) and "CONCAT_id" to all parsers so that we know which rule applies
 *    How to skip some indices ?
 * Scala running:
 * 2. Provide meaningful backtrack: rule_id and list of concat indices
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
    println("Problem type: "+(if (twotracks) "sequence alignment" else if (cyclic) "cyclic" else "standard" )+(if (window>0) ", window="+window else ""));
    println("------------ defs -------------")
    print(cdefs)
    println("------------ rules ------------")
    for((n,p) <- rules) {
      println( n+"[i,j] => "+emit(p.makeTree))
    }
    println("------------- end -------------")
    ""
  }

  type map_f = Function1[List[Any],List[Any]] @unchecked
  // Normalization of the parser AST
  def norm(q:PTree):PTree = q match {
    case PAggr(h:map_f,p) => norm(p) match {
      case PFilter(f,pp) => PFilter(f,norm(PAggr(h,pp)))
      case POr(l,r) => POr(norm(PAggr(h,l)),norm(PAggr(h,r)))
      case pp => PAggr(h,pp)
    }
    case PMap(f:map_f,p) => norm(p) match {
      case PFilter(f,pp) => PFilter(f,norm(PMap(f,pp)))
      case pp => PMap(f,pp)
    }
    case PFilter(f,p) => PFilter(f,norm(p))
    case POr(l,r) => POr(norm(l),norm(r))
    case PConcat(l,r,i) => PConcat(norm(l),norm(r),i)
    case _ => q
  }

  // 1. Assign to each node its bounds (i,j)
  // 2. Collect all the conditions from the tree and its content body
  // Given bounds [i,j] and a FreeVar generator, returns a list of conditions/loops and the body of the operator
  def gen(q:PTree,i:Var,j:Var,g:FreeVar):(List[Cond],String) = q match {
    case PTerminal(f) => f(i,j)
    case PAggr(h,p) => val (c,b)=gen(p,i,j,g);
      h.toString match {
        case "$$max$$" => (c, "max("+b+")")
        case "$$min$$" => (c, "min("+b+")")
        case "$$count$$" => (c, "count("+b+")")
        case "$$sum$$" => (c, "sum("+b+")")
        case _ => (c, "Aggr_"+h.toString+"("+b+")")
      }
    case POr(l,r) => (Nil, emit(gen(l,i,j,g.dup))+"\n       ++ "+emit(gen(r,i,j,g.dup)))
    case PMap(f,p) => val (c,b)=gen(p,i,j,g); (c, "Map("+b+")")
    case PFilter(f,p) => val (c,b)=gen(p,i,j,g); (c, "Filter("+b+")")
    case PRule(name) => (Nil, name+"["+i+","+j+"]")
    case PConcat(l,r,indices) if (twotracks==false) =>
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

    case PConcat(l,r,indices) if (twotracks==true) =>
      val track = indices._3;
      val (c,k):(List[Cond],Var) = indices match {
        case (a,b,1,_) if (a==b && a>0) => (List(zero.leq(i,1)),i.add(-a))
        case (a,b,1,_) => val k0=g.get; (List(CFor(k0.v,'0',1,i.v,1)),k0)
        case (a,b,2,_) if (a==b && a>0) => (List(zero.leq(j,1)),j.add(-a))
        case (a,b,2,_) => val k0=g.get; (List(CFor(k0.v,'0',1,j.v,1)),k0)
      }
      val (lc,lb) = gen(l,i,if (track==1) k else j,g)
      val (rc,rb) = gen(r,if (track==2) k else i,j,g)
      (simplify(c ::: lc ::: rc), lb+" ~TT~ "+rb)

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
      }
      cs
  }

  def emit(p:PTree):String = emit(gen(norm(p),Var('i',0),Var('j',0),new FreeVar('k')))
  def emit(d:(List[Cond],String)):String = d match { case (cs,body) =>
    cs.map {
      case CFor(v,l,ld,u,0) => "for("+l+(if(ld>0)"+"+ld else "")+" <= "+v+" <= "+u+")"
      case CFor(v,l,ld,u,ud) => v+"u="+u+"-"+ud+"; for("+l+(if(ld>0)"+"+ld else "")+" <= "+v+" <= "+v+"u)"
      case CEq(a,b,d) => "if ("+a+(if(d>0)"+"+d else "")+"=="+b+")"
      case CLeq(a,b,d) => "if ("+a+(if(d>0)"+"+d else "")+"<="+b+")"
    }.map{x=>x+" { "}.mkString("")+body+cs.map{x=>" }"}.mkString("")
  }
}
