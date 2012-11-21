package reflect

import scala.reflect.runtime.{universe => u}
//import scala.reflect.runtime.universe.Expr
import scala.reflect.runtime.universe._
import scala.tools.reflect.Eval
import scala.language.reflectiveCalls

class Dummy // empty parser match
trait Signature {
  type Alphabet // input type
  type Answer   // output type

  val h:Expr[Function1[List[Answer],List[Answer]]]
  val cyclic = false // cyclic problem
  val window = 0     // windowing size, 0=disabled
}

trait CodeGen { this:Signature =>
  val twotracks = false
  type Subword = (Int, Int)
  type Input = Array[Alphabet]

  // Memoization through tabulation
  import scala.collection.mutable.HashMap
  val tabs = new HashMap[String,HashMap[Subword,List[Answer]]]
  val rules = new HashMap[String,Treeable]

  trait Treeable {
    def tree : PTree
    def makeTree = tree
  }

  // ------------------------------------------------------------------------------

  // Tree structure for recurrences generation
  sealed abstract class PTree
  case class PTerminal[T](f: (Var,Var) => (List[Cond],String)) extends PTree
  case class PAggr[T](h: Expr[Function1[List[T],List[T]]], p: PTree) extends PTree
  case class POr(l: PTree, r: PTree) extends PTree
  case class PMap[T,U](f: Expr[Function1[T,U]], p: PTree, tag:u.TypeTag[U]) extends PTree
  case class PFilter(f: Expr[Function1[Subword,Boolean]], p: PTree) extends PTree
  case class PRule(name: String) extends PTree
  case class PConcat(l: PTree, r: PTree, indices: (Int,Int,Int,Int)) extends PTree
  case class PConcatTT(l: PTree, r: PTree, track: Boolean, indices: (Int,Int)) extends PTree

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

  def gen:String = {
    println("Problem type: "+(if (twotracks) "sequence alignment" else if (cyclic) "cyclic" else "standard" )+(if (window>0) ", window="+window else ""));
    println("------------ rules ------------")
    for((n,p) <- rules) println( n+"[i,j] => "+emit(p.makeTree))
    println("----------- helpers ------------")
    for((n,e) <- helpers) e match {
      case (Expr(Function(ValDef(_,arg,tp,_)::Nil,body)),tag) =>
        // filter: => boolean
        // map: => ???
        // aggr: T => T
        println(n+"("+arg+": "+tp+"): "+tag+" = "+(u show body)+"\n")
      case x => println("ERROR WITH : "+(u showRaw x))
    }
    println("------------- end -------------")
    "Hash maps: "+tabs.size
  }

  // Store for all user-defined functions
  import scala.collection.mutable.HashMap
  val helpers = new HashMap[String,(Expr[Any],u.TypeTag[Any])] {
    private var counter:Int=0
    def add(n:String,e:Expr[Any],t:u.TypeTag[Any]):String = {
      val id=n+counter; counter=counter+1
      this += ((id,(e,t)));
      if (n=="filter") println("Added filter: "+e)
      id
    }
  }

  // 1. Assign to each node its bounds (i,j)
  // 2. Collect all the conditions from the tree and its content body
  // Given bounds [i,j] and a FreeVar generator, returns a list of conditions/loops and the body of the operator
  type map_f = Expr[Function1[List[Any],List[Any]]] @unchecked
  def gen(q:PTree,i:Var,j:Var,g:FreeVar):(List[Cond],String) = q match {
    // AST Transforms
    case PAggr(h:map_f,POr(l,r)) => gen(POr(PAggr(h,l),PAggr(h,r)),i,j,g)
    //case PMap(f:map_tp,PFilter(f2,p)) => gen(PFilter(f2,PMap(f,p)),i,j,g)

    // Application
    case PTerminal(f) => f(i,j)
    case PAggr(h,p) => val (c,b)=gen(p,i,j,g); (c, helpers.add("aggr",h,null)+"("+b+")")
    case POr(l,r) => (Nil, emit(gen(l,i,j,g.dup))+"\n       ++ "+emit(gen(r,i,j,g.dup)))
    case PMap(f,p,tag) => val (c,b)=gen(p,i,j,g); (c, helpers.add("map",f,tag)+"("+b+")")
    case PFilter(f,p) => val (c,b)=gen(p,i,j,g); (c, helpers.add("filter",f,null)+"("+b+")")
    case PRule(name) => (Nil, name+"["+i+","+j+"]")
    case PConcatTT(l,r,track,indices) =>
      val (c,k):(List[Cond],Var) = (track,indices) match {
        case (false,(a,b)) if (a==b && a>0) => (List(zero.leq(i,1)),i.add(-a))
        case (false,(a,b)) => val k0=g.get; (List(CFor(k0.v,'0',1,i.v,1)),k0)
        case (true,(a,b)) if (a==b && a>0) => (List(zero.leq(j,1)),j.add(-a))
        case (true,(a,b)) => val k0=g.get; (List(CFor(k0.v,'0',1,j.v,1)),k0)
      }
      val (lc,lb) = gen(l,i,if (track) k else j,g)
      val (rc,rb) = gen(r,if (!track) k else i,j,g)
      (simplify(c ::: lc ::: rc), lb+" ~TT~ "+rb)

    case PConcat(l, r, indices) =>
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
