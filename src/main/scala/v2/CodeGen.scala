package v2

/*
trait CodeGen extends ADPParsers { this:Signature =>
  // Tree structure for recurrences generation
  sealed abstract class PTree
  case class PTerminal[T](f:(Var,Var) => (List[Cond],String)) extends PTree
  case class PAggr[T,U](h: List[T] => List[U], p: PTree) extends PTree
  case class POr(l: PTree, r: PTree) extends PTree
  case class PMap[T,U](f: T => U, p: PTree) extends PTree
  case class PFilter(f: Subword => Boolean, p: PTree) extends PTree
  case class PRule(name:String) extends PTree
  case class PConcat(l: PTree, r: PTree, indices:(Int,Int,Int,Int)) extends PTree

  // A simple variable generator that sequentially issues free variables
  class FreeVar(v0:Char) {
    private var v=v0
    def get = { var r=v; v=(v+1).toChar; Var(r,0) }
    def dup=new FreeVar(v0)
  }

  // Variables : a name and an offset
  case class Var(v:Char,d:Int) { // 'v'+d
    override def toString = if (d==0) ""+v else if (d>0) v+"+"+d else v+""+d
    def a(e:Int) = Var(v,d+e)
    def f(l:Var,u:Var) = CFor(v,l.v,d-l.d,u.v,d-u.d)
    def l(t:Var,e:Int) = CLeq(v,t.v,d-t.d+e)
    def e(t:Var,e:Int) = CEq(v,t.v,d-t.d+e)
  }

  // Conditions on fresh variables variables
  class Cond // Constraint that is put on variables
  case class CFor(v:Char,l:Char,ld:Int,u:Char,ud:Int) extends Cond // for ('l'+ld<='v'<='u'-ud)
  case class CLeq(a:Char,b:Char,delta:Int) extends Cond // 'a'+delta<='b'
  case class CEq(a:Char,b:Char,delta:Int) extends Cond // 'a'+delta=='b'

  def gen:String = {
    println("------------ rules ------------")
    for((n,p) <- rules) println( n+"[i,j] => "+emit(p.makeTree))
    println("------------- end -------------")
    "Hash maps: "+tabs.size
  }

  // 1. Assign to each node its bounds (i,j)
  // 2. Collect all the conditions from the tree and its content body
  // Given bounds [i,j] and a FreeVar generator, returns a list of conditions/loops and the body of the operator
  def gen(q:PTree,i:Var,j:Var,g:FreeVar):(List[Cond],String) = q match {
    case PTerminal(f) => f(i,j)
    case PAggr(h:Function1[List[Any],List[Any]],p) => p match {
      case POr(l,r) => gen(POr(PAggr(h,l),PAggr(h,r)),i,j,g)
      case _ => val (c,b)=gen(p,i,j,g); (c, "Aggr("+b+")")
    }
    case POr(l,r) => (Nil, emit(gen(l,i,j,g.dup))+" ++ "+emit(gen(r,i,j,g.dup)))
    case PMap(f,p) => val (c,b)=gen(p,i,j,g); (c, "Map("+b+")")
    case PFilter(f,p) => val (c,b)=gen(p,i,j,g); (c, "Filter("+b+")")
    case PRule(name) => (Nil, name+"["+i+","+j+"]")
    case PConcat(l, r, indices) =>
      def bf1(f:Int, l:Int, u:Int):List[Cond] = { val ls=List(i.l(j,f+l)); if (u>0) j.l(i,-f-u)::ls else ls }

      val (c,k):(List[Cond],Var) = indices match {
        // low=up in at least one side
        case (0,0,0,0) => val k0=g.get; (List(k0.f(i,j)), k0)
        case (iL,iU,0,0) if (iL==iU) => (List(i.l(j,iL)), i.a(iL))
        case (0,0,jL,jU) if (jL==jU) => (List(i.l(j,jL)), j.a(-jL))
        case (iL,iU,jL,jU) if (iL==iU && jL==jU) => (List(i.e(j,iL+jL)), i.a(iL))
        case (iL,iU,jL,jU) if (iL==iU) => (bf1(iL,jL,jU), i.a(iL))
        case (iL,iU,jL,jU) if (jL==jU) => (bf1(jL,iL,iU), j.a(-jL))
        // most general case
        case (iL,iU,jL,jU) =>
          val k0=g.get;
          var cs:List[Cond] = Nil
          if (jU>0) j.l(k0,-jU)
          if (iU>0) i.l(k0,iU)
          // we might want to simplify if min_k==i || max_k==j
          (CFor(k0.v,i.v,iL,j.v,jL)::cs, k0)
      }
      val (lc,lb) = gen(l,i,k,g)
      val (rc,rb) = gen(r,k,j,g)

      var cs = c ::: lc ::: rc
      // Optimizations and conditions simplifications
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
      (cs, lb+" ~ "+rb)

    case _ => (Nil,toString)
  }

  def emit(p:PTree):String = emit(gen(p,Var('i',0),Var('j',0),new FreeVar('k')))
  def emit(d:(List[Cond],String)):String = d match { case (cs,body) =>
    cs.map {
      case CFor(v,l,ld,u,0) => "for("+l+(if(ld>0)"+"+ld else "")+" <= "+v+" <= "+u+")"
      case CFor(v,l,ld,u,ud) => v+"u="+u+"-"+ud+"; for("+l+(if(ld>0)"+"+ld else "")+" <= "+v+" <= "+v+"u)"
      case CEq(a,b,d) => "if ("+a+(if(d>0)"+"+d else "")+"=="+b+")"
      case CLeq(a,b,d) => "if ("+a+(if(d>0)"+"+d else "")+"<="+b+")"
    }.map{x=>x+" { "}.mkString("")+body+cs.map{x=>" }"}.mkString("")
  }
}
*/
