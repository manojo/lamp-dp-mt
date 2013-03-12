package lms2

trait Signature {
  type Alphabet // input type
  type Answer // output type
  def h(a:Answer,b:Answer):Answer // optimization function
}

import scala.virtualization.lms.common._

trait BaseParsers extends Base { this:Signature =>
  type Input = Array[Alphabet]
  type Backtrack = (Int,List[Int]) // (subrule_id, indices)
  type Trace = List[(Int,Int,Backtrack)]

  val axiom:Tabulate      // initial parser to be applied
  val twotracks = false   // whether grammar is multi-track
  final val bt0 = (0,List[Int]()) // default initial backtrack
  final val maxN = -1     // infinity for Parser.max

  type tpApply[T] = Rep[List[(T,Backtrack)]]
  type tpUnapply[T] = Rep[Trace]
  type tpReapply[T] = Rep[T]

  // LMS nodes
  def tab_apply(t:Tabulate,i:Rep[Int],j:Rep[Int]) : tpApply[Answer]
  def tab_unapply(t:Tabulate,i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) : tpUnapply[Answer]
  def tab_reapply(t:Tabulate,i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) : tpReapply[Answer]
  def tab_compute(t:Tabulate,i:Rep[Int],j:Rep[Int]):Unit
  def tab_build(t:Tabulate,bt:Trace) : Answer
  def tab_backtrack(t:Tabulate,i:Rep[Int],j:Rep[Int]) : List[(Answer,Trace)]
  def tab_init(t:Tabulate,w:Rep[Int],h:Rep[Int]) : Unit // { mW=w; mH=h; val sz=if (twotracks) w*h else { assert(w==h); h*(h+1)/2 }; data=new Array(sz); }
  def tab_reset(t:Tabulate) : Unit // { data=unit(null); mW=unit(0); mH=unit(0); }


  // term_apply is defined at terminal level
  def term_unapply[T](p:Terminal[T],i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) : tpUnapply[T]
  def term_reapply[T](p:Terminal[T],i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) : tpReapply[T]

  def aggr_apply[T](p:Aggregate[T],i:Rep[Int],j:Rep[Int]) : tpApply[T]
  def filter_apply[T](p:Filter[T],i:Rep[Int],j:Rep[Int]) : tpApply[T]

  def map_apply[T,U](p:Map[T,U],i:Rep[Int],j:Rep[Int]) : tpApply[U]
  def map_reapply[T,U](p:Map[T,U],i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) : tpReapply[U]

  def or_apply[T](p:Or[T],i:Rep[Int],j:Rep[Int]) : tpApply[T]
  def or_unapply[T](p:Or[T],i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) : tpUnapply[T]
  def or_reapply[T](p:Or[T],i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) : tpReapply[T]

  def ccat_apply[T,U](p:Concat[T,U],i:Rep[Int],j:Rep[Int]) : tpApply[(T,U)]
  def ccat_unapply[T,U](p:Concat[T,U],i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) : tpUnapply[(T,U)]
  def ccat_reapply[T,U](p:Concat[T,U],i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) : tpReapply[(T,U)]

  // Abstract parser
  sealed abstract class Parser[T] extends ((Rep[Int],Rep[Int]) => tpApply[T]) {
    def min:Int // subword minimal size
    def max:Int // subword maximal size, -1=infinity
    val alt:Int // alternative (subrule_id)
    val cat:Int // concatenation split (offset in backtrack)

    // List-based vanilla Scala
    def apply(i:Rep[Int],j:Rep[Int]): tpApply[T]
    def unapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]): tpUnapply[T]
    def reapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]): tpReapply[T]

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
  def tabInit(w:Rep[Int],h:Rep[Int]) = rules.foreach{ case (_,t) => t.init(w,h) }
  def tabReset = rules.foreach{ case (_,t) => t.reset }

  def tabulate(name:String, inner: => Parser[Answer], alwaysValid:Boolean=false) = new Tabulate(inner,name,alwaysValid)
  class Tabulate(in: => Parser[Answer], val name:String, val alwaysValid:Boolean=false) extends Parser[Answer] {
    lazy val inner = in
    val (alt,cat) = (1,0)
    def min = minv; var minv = 0
    def max = maxv; var maxv = 0

    if (rules.contains(name)) sys.error("Duplicate tabulation name")
    rules += ((name,this))
    var id:Int = -1 // subrules base index

    // Matrix storage
    var data:Rep[Array[(Answer,Backtrack)]] = unit(null)
    var mW:Rep[Int] = unit(0)
    var mH:Rep[Int] = unit(0)
    def init(w:Rep[Int],h:Rep[Int]) = tab_init(this,w,h)
    def reset = tab_reset(this)
    def apply(i:Rep[Int],j:Rep[Int]) = tab_apply(this,i,j)
    def unapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = tab_unapply(this,i,j,bt)
    def reapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = tab_reapply(this,i,j,bt)
    def compute(i:Rep[Int],j:Rep[Int]) = tab_compute(this,i,j)
    def build(bt:Trace) = tab_build(this,bt)
    def backtrack(i:Rep[Int],j:Rep[Int]) = tab_backtrack(this,i,j)
  }

  // --------------------------------------------------------------------------
  // Terminal abstraction
  abstract case class Terminal[T](min:Int,max:Int) extends Parser[T] {
    final val (alt,cat) = (1,0)
    def unapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = term_unapply(this,i,j,bt)
    def reapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = term_reapply(this,i,j,bt)
  }

  // Aggregate combinator.
  // Takes a function which modifies the list of a parse. Usually used
  // for max or min functions (but can also be a prettyprint).
  case class Aggregate[T](inner:Parser[T], h:(T,T)=>T) extends Parser[T] {
    def min = inner.min
    def max = inner.max
    lazy val (alt,cat) = (inner.alt,inner.cat)
    def apply(i:Rep[Int],j:Rep[Int]) = aggr_apply(this,i,j)
    def unapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = inner.unapply(i,j,bt) // we have only 1 result
    def reapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = inner.reapply(i,j,bt)
  }

  // Filter combinator.
  // Yields an empty list if the filter does not pass.
  case class Filter[T](inner:Parser[T], pred:(Int,Int)=>Boolean) extends Parser[T] {
    def min = inner.min
    def max = inner.max
    lazy val (alt,cat) = (inner.alt,inner.cat)
    def apply(i:Rep[Int],j:Rep[Int]) = filter_apply(this,i,j)
    def unapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = inner.unapply(i,j,bt) // filter matched at apply
    def reapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = inner.reapply(i,j,bt) // ditto
  }

  // Mapper. Equivalent of ADP's <<< operator.
  // To separate left and right hand side of a grammar rule
  case class Map[T,U](inner:Parser[T], f: T => U) extends Parser[U] {
    def min = inner.min
    def max = inner.max
    lazy val (alt,cat) = (inner.alt,inner.cat)
    def apply(i:Rep[Int],j:Rep[Int]) = map_apply(this,i,j)
    def unapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = inner.unapply(i,j,bt)
    def reapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = map_reapply(this,i,j,bt)
  }

  // Or combinator. Equivalent of ADP's ||| operator.
  // In ADP semantics we concatenate the results of the parse
  // of 'this' with the parse of 'that'
  case class Or[T](left:Parser[T], right:Parser[T]) extends Parser[T] {
    def min = Math.min(left.min,right.min)
    def max = if (left.max==maxN || right.max==maxN) maxN else Math.max(left.max,right.max)
    lazy val (alt,cat) = (left.alt+right.alt, Math.max(left.cat,right.cat))
    def apply(i:Rep[Int],j:Rep[Int]) = or_apply(this,i,j)
    def unapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = or_unapply(this,i,j,bt)
    def reapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = or_reapply(this,i,j,bt)
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

    def apply(i:Rep[Int],j:Rep[Int]) = ccat_apply(this,i,j)
    def unapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = ccat_unapply(this,i,j,bt)
    def reapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = ccat_reapply(this,i,j,bt)
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
