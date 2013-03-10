package lms2

trait Signature {
  type Alphabet // input type
  type Answer // output type

  def h(a:Answer,b:Answer):Answer // optimization function
}

/*
import lms.{MyListOps,MyListOpsExp,ScalaGenMyListOps, MyScalaCompile}
import lms.{MyRangeOps,MyRangeOpsExp,ScalaGenMyRangeOps}
import lms.{ListToGenTransform,ScalaGenGeneratorOps}

trait Package extends ArrayOps with MyListOps with NumericOps with IfThenElse
                 with LiftNumeric with Equal with BooleanOps with OrderingOps
                 with MathOps with MyRangeOps with TupleOps with MiscOps {}
// XXX: how to control manually how operations ?
*/

// XXX: if we start importing LMS traits we end-up with all Scala code (analysis, static data) being lifted
// whereas this is not necessary (and not desired, as it restricts usable functions).
// Idea: use generators to achive what we want and combine them into BaseParsers to obtain desired effect ?

//import scala.virtualization.lms.common._
trait BaseParsers /*extends Base*/ { this:Signature =>
  type Input = Array[Alphabet]
  type Backtrack = (Int,List[Int]) // (subrule_id, indices)
  type Trace = List[(Int,Int,Backtrack)]

  val axiom:Tabulate      // initial parser to be applied
  val twotracks = false   // whether grammar is multi-track
  final val bt0 = (0,List[Int]()) // default initial backtrack
  final val maxN = -1     // infinity for Parser.max

// (Rep[Int], Rep[Int]) => Generator[T]
// Generator[T:Manifest] extends (continuation:(Rep[T] => Rep[Unit]) => Rep[Unit]) <- execution

  // Abstract parser
  sealed abstract class Parser[T] extends ((Int,Int) => List[(T,Backtrack)]) {
    def min:Int // subword minimal size
    def max:Int // subword maximal size, -1=infinity
    val alt:Int // alternative (subrule_id)
    val cat:Int // concatenation split (offset in backtrack)

    // List-based vanilla Scala
    def apply(i:Int,j:Int): List[(T,Backtrack)]
    def unapply(i:Int,j:Int,bt:Backtrack): Trace
    def reapply(i:Int,j:Int,bt:Backtrack): T

    // Generator-based LMS function generators
    /*
    def genApply(implicit mT:Manifest[T]) : ((Rep[Int],Rep[Int])=>Rep[List[(T,Backtrack)]]) = (x:Rep[Int],y:Rep[Int]) => unit(List[(T,Backtrack)]())
    def genUnapply(implicit mT:Manifest[T]) : ((Rep[Int],Rep[Int],Rep[Backtrack])=>Rep[Trace]) = (x:Rep[Int],y:Rep[Int],bt:Rep[Backtrack]) => unit(List[(Int,Int,Backtrack)]())
    def genReapply(implicit mT:Manifest[T]) : ((Rep[Int],Rep[Int],Rep[Backtrack])=>Rep[T]) = (x:Rep[Int],y:Rep[Int],bt:Rep[Backtrack]) => unit(null.asInstanceOf[T])
    */

    final def ^^[U](f: T => U) = new Map(this,f)
    final def |(other: Parser[T]) = new Or(this,other)
    final def aggregate(h:(T,T)=>T) = new Aggregate(this,h)
    final def filter (f:(Int,Int)=>Boolean) = new Filter(this,f)
  }

  // Recurrence analysis, done once when grammar is complete, before the computation.
  private var analyzed=false
  def analyze:Boolean = { if (analyzed) return false; analyzed=true
    // Strip away unnecessary tabulations
    var used = Set[String](); use(axiom)
    def use[T](q:Parser[T]):Unit = q match {
      case Aggregate(p,_) => use(p) case Filter(p,_) => use(p) case Map(p,_) => use(p) case Or(l,r) => use(l); use(r) case Concat(l,r,_) => use(l); use(r)
      case t:Tabulate if (!used.contains(t.name)) => used++=Set(t.name); use(t.inner) case _ =>
    }
    for (n <- (rules.keys.toSet -- used)) rules.remove(n)
    // Yield analysis
    for((n,t)<-rules) t.minv=100000 // upper bound on minimum yields
    (0 until rules.size).foreach{ _ => for((n,t) <- rules) t.minv=t.inner.min }
    for((n,t)<-rules) t.maxv=t.minv
    for((n,t)<-rules) t.maxv=rmax(t.inner, rules.size)
    def rmax[T](p0:Parser[T],d:Int):Int = p0 match {
      case Terminal(_,max) => max
      case Filter(p,f) => rmax(p,d)
      case Aggregate(p,h) => rmax(p,d)
      case Map(p,f) => rmax(p,d)
      case Or(l,r) => val ml=rmax(l,d); if (ml==maxN) maxN else { val mr=rmax(r,d); if (mr==maxN) maxN else Math.max(ml,mr) }
      case Concat(l,r,_) => val ml=rmax(l,d); if (ml==maxN) maxN else { val mr=rmax(r,d); if (mr==maxN) maxN else ml+mr }
      case p:Tabulate => if (d==1) maxN else rmax(p.inner,d-1)
    }
    // Dependency analyis order: prevents infinite loops, also define an order for bottom up implementations (requires yield analysis)
    def deps[T](q:Parser[T]): List[String] = q match { // (A->B) <=> B(i,j) = ... | A(i,j)
      case Aggregate(p,_) => deps(p) case Filter(p,_) => deps(p) case Map(p,_) => deps(p) case Or(l,r) => deps(l)++deps(r)
      case cc@Concat(l,r,_) => val(lm,_,rm,_)=cc.indices; (if (lm==0) deps(r) else Nil) ::: (if (rm==0) deps(l) else Nil)
      case t:Tabulate => List(t.name) case _ => Nil
    }
    val cs = rules.map{case (n,p)=>(n,deps(p.inner)) }
    while (!cs.isEmpty) { var rem=false;
      cs.foreach { case (n,ds) if (ds.isEmpty||(true/:ds.map{d=>rulesOrder.contains(d)}){case(a,b)=>a&&b}) => rem=true; rulesOrder=n::rulesOrder; cs.remove(n); case _ => }
      if (rem==false) sys.error("Loop between tabulations, error in grammar")
    }
    rulesOrder = rulesOrder.reverse
    // Identify subrules (uniquely within the same grammar as sorted by name)
    var id=0; for((n,p) <- rules.toList.sortBy(_._1)) { p.id=id; id=id+p.inner.alt; }
    true
  }

  // --------------------------------------------------------------------------
  // Memoization through tabulation
  import scala.collection.mutable.HashMap
  var rulesOrder:List[String]=Nil // Order of tabulations evaluation
  val rules = new HashMap[String,Tabulate]
  def tabInit(w:Int,h:Int) = rules.foreach{ case (_,t) => t.init(w,h) }
  def tabReset = rules.foreach{ case (_,t) => t.reset }

  def tabulate(name:String, inner: => Parser[Answer], alwaysValid:Boolean=false) = new Tabulate(inner,name,alwaysValid)
  class Tabulate(in: => Parser[Answer], val name:String, val alwaysValid:Boolean=false) extends Parser[Answer] {
    lazy val inner = in
    val (alt,cat) = (1,0)
    def min = minv; var minv = 0
    def max = maxv; var maxv = 0

    // Matrix storage
    private var data:Array[(Answer,Backtrack)] = null
    private var (mW,mH) = (0,0)
    def init(w:Int,h:Int) { mW=w; mH=h; val sz=if (twotracks) w*h else { assert(w==h); h*(h+1)/2 }; data=new Array(sz); }
    def reset { data=null; mW=0; mH=0; }

    if (rules.contains(name)) sys.error("Duplicate tabulation name")
    rules += ((name,this))

    var id:Int = -1 // subrules base index

    @inline private def idx(i:Int,j:Int):Int = if (twotracks) i*mW+j else { val d=mH+1+i-j; ( mH*(mH+1) - d*(d-1) ) /2 + i }

    def apply(i:Int,j:Int) = { val v = data(idx(i,j)); if (v!=null) List((v._1,bt0)) else List() } // read-only
    def compute(i:Int,j:Int) = { val l=inner(i,j); if (!l.isEmpty) { val (c,(r,b))=l.head; data(idx(i,j))=(c,(id+r,b)); } } // write-only

    def unapply(i:Int,j:Int,bt:Backtrack) = { val v=data(idx(i,j)); if (v!=null) List((i,j,v._2)) else List() }
    def reapply(i:Int,j:Int,bt:Backtrack) = { val v=data(idx(i,j)); if (v!=null) v._1 else sys.error("Failed reapply"+(i,j)) }

    def build(bt:Trace):Answer = bt match {
      case bh::bs => val (i,j,(rule,b))=bh; val (t,rr)=findTab(rule); val a=t.inner.reapply(i,j,(rr,b)); if (bs==Nil) a else { data(idx(i,j))=(a,bt0); build(bs) }
      case Nil => sys.error("No backtrack provided")
    }

    def backtrack(i0:Int,j0:Int) = {
      val e=data(idx(i0,j0))
      var pending:Trace = List((i0,j0,e._2))
      var trace:Trace = Nil
      while (!pending.isEmpty) {
        val el = pending.head; trace=el::trace;
        val (i,j,(rule,bt))=el;
        val (t,rr) = findTab(rule)
        val res = t.inner.unapply(i,j,(rr,bt))
        pending = res:::pending.tail;
      }
      List((e._1,trace))
    } 
  }

  def findTab(rule:Int):(Tabulate,Int) = {
    rules.find{ case (n,t)=> val rr=rule-t.id; rr >= 0 && rr < t.inner.alt} match {
      case Some((n,t)) => (t,rule-t.id)
      case None => sys.error("No tabulation for subrule #"+rule)
    }
  }

  // --------------------------------------------------------------------------
  // Terminal abstraction
  abstract case class Terminal[T](min:Int,max:Int) extends Parser[T] {
    final val (alt,cat) = (1,0)
    def unapply(i:Int,j:Int,bt:Backtrack) = Nil
    def reapply(i:Int,j:Int,bt:Backtrack) = { val r=apply(i,j); if (r.isEmpty) sys.error("Empty apply"+(i,j)+" for "+bt); r.map{ _._1 }.head }
  }

  // Aggregate combinator.
  // Takes a function which modifies the list of a parse. Usually used
  // for max or min functions (but can also be a prettyprint).
  case class Aggregate[T](inner:Parser[T], h:(T,T)=>T) extends Parser[T] {
    def min = inner.min
    def max = inner.max
    lazy val (alt,cat) = (inner.alt,inner.cat)
    def apply(i:Int,j:Int) = { val l=inner(i,j); if (l.isEmpty) Nil else List(l.tail.foldLeft(l.head){(a,b)=> if (a._1==h(a._1,b._1)) a else b}) }
    def unapply(i:Int,j:Int,bt:Backtrack) = inner.unapply(i,j,bt) // we have only 1 result
    def reapply(i:Int,j:Int,bt:Backtrack) = inner.reapply(i,j,bt)
  }

  // Filter combinator.
  // Yields an empty list if the filter does not pass.
  case class Filter[T](inner:Parser[T], pred:(Int,Int)=>Boolean) extends Parser[T] {
    def min = inner.min
    def max = inner.max
    lazy val (alt,cat) = (inner.alt,inner.cat)
    def apply(i:Int,j:Int) = if(pred(i,j)) inner(i,j) else Nil
    def unapply(i:Int,j:Int,bt:Backtrack) = inner.unapply(i,j,bt) // filter matched at apply
    def reapply(i:Int,j:Int,bt:Backtrack) = inner.reapply(i,j,bt) // ditto
  }

  // Mapper. Equivalent of ADP's <<< operator.
  // To separate left and right hand side of a grammar rule
  case class Map[T,U](inner:Parser[T], f: T => U) extends Parser[U] {
    def min = inner.min
    def max = inner.max
    lazy val (alt,cat) = (inner.alt,inner.cat)
    def apply(i:Int,j:Int) = inner(i,j) map { case (s,b) => (f(s),b) }
    def unapply(i:Int,j:Int,bt:Backtrack) = inner.unapply(i,j,bt)
    def reapply(i:Int,j:Int,bt:Backtrack) = f(inner.reapply(i,j,bt))
  }

  // Or combinator. Equivalent of ADP's ||| operator.
  // In ADP semantics we concatenate the results of the parse
  // of 'this' with the parse of 'that'
  case class Or[T](left:Parser[T], right:Parser[T]) extends Parser[T] {
    def min = Math.min(left.min,right.min)
    def max = if (left.max==maxN || right.max==maxN) maxN else Math.max(left.max,right.max)
    lazy val (alt,cat) = (left.alt+right.alt, Math.max(left.cat,right.cat))
    def apply(i:Int,j:Int) = left(i,j) ++ right(i,j).map{ case (t,(r,b)) => (t,(r+left.alt,b)) }
    def unapply(i:Int,j:Int, bt:Backtrack) = { val (r,idx)=bt; var a=left.alt-1; if (r<=a) left.unapply(i,j,(r,idx)) else right.unapply(i,j,(r-a,idx)) }
    def reapply(i:Int,j:Int, bt:Backtrack) = { val (r,idx)=bt; var a=left.alt-1; if (r<=a) left.reapply(i,j,(r,idx)) else right.reapply(i,j,(r-a,idx)) }
  }

  // Concatenate combinator.
  // Parses a concatenation of string " left ~ right " with length(left) in [lL,lU]
  // and length(right) in [rL,rU], lU,rU=0 means unbounded (infinity).
  case class Concat[T,U](left: Parser[T], right:Parser[U], track:Int) extends Parser[(T,U)] {
    def min = left.min+right.min
    def max = if (left.max==maxN || right.max==maxN) maxN else left.max+right.max
    lazy val (alt,cat) = (left.alt*right.alt, left.cat+(if(hasBt)1 else 0)+right.cat)
    lazy val hasBt:Boolean = (track,left.min,left.max,right.min,right.max) match {
      case (0,a,b,c,d) if ((a==b && a>=0) || (c==d && c>=0)) => false
      case (1,a,b,_,_) if (a==b && a>=0) => false
      case (2,_,_,a,b) if (a==b && a>=0) => false
      case _ => true
    }
    lazy val indices = { assert(analyzed==true); (left.min,left.max,right.min,right.max) }
    @inline private def bt(bl:Backtrack,br:Backtrack,k:Int):Backtrack = {
      (bl._1*right.alt+br._1, bl._2:::(if (hasBt)List(k) else Nil):::br._2)
    }

    def apply(i:Int,j:Int) = {
      val (lL,lU,rL,rU) = indices
      if (track==0) {
        val min_k = if (rU==maxN || i+lL > j-rU) i+lL else j-rU
        val max_k = if (lU==maxN || j-rL < i+lU) j-rL else i+lU
        for(
          k <- (min_k to max_k).toList;
          (x,xb) <- left(i,k);
          (y,yb) <- right(k,j)
        ) yield(((x,y),bt(xb,yb,k)))
      } else if (track==1) {
        val min_k = if (lU==maxN || i-lU < 0) 0 else i-lU
        val max_k = i-lL
        for(
          k <- (min_k to max_k).toList;
          (x,xb) <- left(k,i); // in1[k..i]
          (y,yb) <- right(k,j) // M[k,j]
        ) yield(((x,y),bt(xb,yb,k)))
      } else if (track==2) {
        val min_k = if (rU==maxN || j-rU < 0) 0 else j-rU
        val max_k = j-rL
        for(
          k <- (min_k to max_k).toList;
          (x,xb) <- left(i,k); // M[i,k]
          (y,yb) <- right(k,j) // in2[k..j]
        ) yield(((x,y),bt(xb,yb,k)))
      } else Nil
    }

    private def sw_split(i:Int,j:Int,kb:Int) = (track,indices) match {
      case (0,(lL,lU,rL,rU)) if i<j => // single track
        val k=if(hasBt)kb else if (rU==maxN)i+lL else Math.max(i+lL,j-rU); (i,k, k,j)
      case (1,(l,u,_,_)) => val k=if(hasBt)kb else i-l; (k,i, k,j) // tt:concat1
      case (2,(_,_,l,u)) => val k=if(hasBt)kb else j-l; (i,k, k,j) // tt:concat2
      case _ => (0,0, 0,0)
    }

    private def bt_split(bt:Backtrack):(Backtrack,Backtrack,Int) = {
      val (r,idx)=bt; val a:Int=right.alt; val c:Int=left.cat;
      ((r/a,idx.take(c)), (r%a,idx.drop(c+(if (hasBt)1 else 0))), if (hasBt)idx(c) else -1)
    }

    def unapply(i:Int,j:Int,bt:Backtrack) = {
      val (bl,br,k)=bt_split(bt); val (li,lj,ri,rj)=sw_split(i,j,k)
      left.unapply(li,lj,bl) ::: right.unapply(ri,rj,br)
    }

    def reapply(i:Int,j:Int,bt:Backtrack) = {
      val (bl,br,k)=bt_split(bt); val (li,lj,ri,rj)=sw_split(i,j,k)
      (left.reapply(li,lj,bl), right.reapply(ri,rj,br))
    }
  }

  // --------------------------------------------------------------------------
  // Implicit conversion, to allow 'flat' arguments functions (instead of recursive pairs)
  /*
  import scala.language.implicitConversions
  trait DeTuple { val f:Any=null }
  implicit def detuple2[A,B,R](fn:Function2[A,B,R]) = new (((A,B))=>R) with DeTuple { override val f=fn
    def apply(t:(A,B)) = { val (a,b)=t; fn(a,b) } }
  implicit def detuple3[A,B,C,R](fn:Function3[A,B,C,R]) = new ((((A,B),C))=>R) with DeTuple { override val f=fn
    def apply(t:((A,B),C)) = { val ((a,b),c)=t; fn(a,b,c) } }
  implicit def detuple4[A,B,C,D,R](fn:Function4[A,B,C,D,R]) = new (((((A,B),C),D))=>R) with DeTuple { override val f=fn
    def apply(t:(((A,B),C),D)) = { val (((a,b),c),d)=t; fn(a,b,c,d) } }
  implicit def detuple5[A,B,C,D,E,R](fn:Function5[A,B,C,D,E,R]) = new ((((((A,B),C),D),E))=>R) with DeTuple { override val f=fn
    def apply(t:((((A,B),C),D),E)) = { val ((((a,b),c),d),e)=t; fn(a,b,c,d,e) } }
  implicit def detuple6[A,B,C,D,E,F,R](fn:Function6[A,B,C,D,E,F,R]) = new (((((((A,B),C),D),E),F))=>R) with DeTuple { override val f=fn
    def apply(t:(((((A,B),C),D),E),F)) = { val (((((a,b),c),d),e),f)=t; fn(a,b,c,d,e,f) } }
  implicit def detuple7[A,B,C,D,E,F,G,R](fn:Function7[A,B,C,D,E,F,G,R]) = new ((((((((A,B),C),D),E),F),G))=>R) with DeTuple { override val f=fn
    def apply(t:((((((A,B),C),D),E),F),G)) = { val ((((((a,b),c),d),e),f),g)=t; fn(a,b,c,d,e,f,g) } }
  implicit def detuple8[A,B,C,D,E,F,G,H,R](fn:Function8[A,B,C,D,E,F,G,H,R]) = new (((((((((A,B),C),D),E),F),G),H))=>R) with DeTuple { override val f=fn
    def apply(t:(((((((A,B),C),D),E),F),G),H)) = { val (((((((a,b),c),d),e),f),g),h)=t; fn(a,b,c,d,e,f,g,h) } }
  implicit def detuple9[A,B,C,D,E,F,G,H,I,R](fn:Function9[A,B,C,D,E,F,G,H,I,R]) = new ((((((((((A,B),C),D),E),F),G),H),I))=>R) with DeTuple { override val f=fn
    def apply(t:((((((((A,B),C),D),E),F),G),H),I)) = { val ((((((((a,b),c),d),e),f),g),h),i)=t; fn(a,b,c,d,e,f,g,h,i) } }
  implicit def detuple10[A,B,C,D,E,F,G,H,I,J,R](fn:Function10[A,B,C,D,E,F,G,H,I,J,R]) = new (((((((((((A,B),C),D),E),F),G),H),I),J))=>R) with DeTuple { override val f=fn
    def apply(t:(((((((((A,B),C),D),E),F),G),H),I),J)) = { val (((((((((a,b),c),d),e),f),g),h),i),j)=t; fn(a,b,c,d,e,f,g,h,i,j) } }
  implicit def detuple11[A,B,C,D,E,F,G,H,I,J,K,R](fn:Function11[A,B,C,D,E,F,G,H,I,J,K,R]) = new ((((((((((((A,B),C),D),E),F),G),H),I),J),K))=>R) with DeTuple { override val f=fn
    def apply(t:((((((((((A,B),C),D),E),F),G),H),I),J),K)) = { val ((((((((((a,b),c),d),e),f),g),h),i),j),k)=t; fn(a,b,c,d,e,f,g,h,i,j,k) } }
  implicit def detuple12[A,B,C,D,E,F,G,H,I,J,K,L,R](fn:Function12[A,B,C,D,E,F,G,H,I,J,K,L,R]) = new (((((((((((((A,B),C),D),E),F),G),H),I),J),K),L))=>R) with DeTuple { override val f=fn
    def apply(t:(((((((((((A,B),C),D),E),F),G),H),I),J),K),L)) = { val (((((((((((a,b),c),d),e),f),g),h),i),j),k),l)=t; fn(a,b,c,d,e,f,g,h,i,j,k,l) } }
  */
  // def detuple(n:Int) { def ls(c:Char='A') = (0 until n).map{x=>(c+x).toChar}.mkString(",")
  //   def lr(c:Char='A') = ("("*(n-1))+c+","+(1 until n).map{x=>(c+x).toChar}.mkString("),")+")"
  //   println("  implicit def detuple"+n+"["+ls()+",R](fn:Function"+n+"["+ls()+",R]) = new (("+lr()+")=>R) with DeTuple { override val f=fn\n"+
  //           "    def apply(t:"+lr()+") = { val "+lr('a')+"=t; fn("+ls('a')+") } }") }
}
