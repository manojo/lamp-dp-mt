package lmstemp

import scala.virtualization.lms.common._
import lms._

trait Signature {
  type Alphabet // input type
  type Answer // output type
  //def h(a:Rep[Answer],b:Rep[Answer]):Rep[Answer] // optimization function

  val mAlph: Manifest[Alphabet]
  val mAns : Manifest[Answer]
}

trait BaseParsers extends Package { this:Signature =>
  type Input = Rep[Array[Alphabet]]
  type Backtrack = (Int, List[Int])
  type Trace = List[(Int,Int,Backtrack)]

  /**
   * interface ops, private of course
   */
  def parser_filter[T:Manifest](inner: Parser[T], p: Rep[T] => Rep[Boolean]) :  Parser[T]
  def parser_map[T:Manifest, U:Manifest](inner: Parser[T], f: Rep[T] => Rep[U]) : Parser[U]
  def parser_or[T:Manifest](inner: Parser[T], that: Parser[T]): Parser[T]
  def parser_aggfold[T:Manifest](inner: Parser[T]/*, z: Rep[T]*/, f: (Rep[T],Rep[T]) => Rep[T]) : Parser[T]
  def parser_concat[T:Manifest, U:Manifest](inner: Parser[T], that: Parser[U]): Parser[(T,U)]
  def tabulate(name:String, inner: => Parser[Answer], alwaysValid:Boolean=false) : Parser[Answer]


  sealed abstract class Parser[T:Manifest] {
    //def min:Int // subword minimal size
    //def max:Int // subword maximal size, -1=infinity
    //val alt:Int // alternative (subrule_id)
    //val cat:Int // concatenation split (offset in backtrack)

    // List-based vanilla Scala
    def apply(i:Rep[Int],j:Rep[Int]): Rep[List[(T,Backtrack)]]
    //def unapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]): Rep[Trace]
    //def reapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]): Rep[T]

    final def ^^[U:Manifest](f: Rep[T] => Rep[U]) = parser_map(this, f)
    final def |(other: Parser[T]) = parser_or(this, other)
    final def aggregate(h:(Rep[T],Rep[T])=>Rep[T]) = parser_aggfold(this, h)
    final def filter (f:Rep[T]=>Rep[Boolean]) = parser_filter(this, f)
  }
}

trait BaseParsersExp extends BaseParsers with PackageExp{this: Signature =>

  // Dependency analyis order: prevents infinite loops, also define an order for bottom up implementations (requires yield analysis)
  def deps[T:Manifest](q:Parser[T]): scala.List[String] = q match { // (A->B) <=> B(i,j) = ... | A(i,j)
    case Aggregate(p,_) => deps(p)
    case Filter(p,_) => deps(p)
    case Map(p,_) => deps(p)
    case Or(l,r) => deps(l) ::: deps(r)
    case cc@Concat(l,r/*,_*/) =>
      /*val(lm,_,rm,_)=cc.indices;*/
      //deps(r) ::: deps(l)
      val ldeps : List[String] = if (/*lm*/10==0) deps(r) else Nil
      val rdeps : List[String] = if (/*rm*/10==0) deps(l) else Nil
      ldeps ::: rdeps
    case t:Tabulate => scala.List(t.name)
    case _ => Nil
  }

  /**
   * interface ops, private of course
   */
  def parser_filter[T:Manifest](inner: Parser[T], p: Rep[T] => Rep[Boolean]) = Filter(inner, p)
  def parser_map[T:Manifest, U:Manifest](inner: Parser[T], f: Rep[T] => Rep[U]) = Map(inner, f)
  def parser_or[T:Manifest](inner: Parser[T], that: Parser[T]): Parser[T] = Or(inner, that)
  def parser_aggfold[T:Manifest](inner: Parser[T], /*z: Rep[T], */ f: (Rep[T],Rep[T]) => Rep[T]) = Aggregate(inner, f)
  def parser_concat[T:Manifest, U:Manifest](inner: Parser[T], that: Parser[U]) = Concat(inner, that)
  def tabulate(name:String, inner: => Parser[Answer], alwaysValid:Boolean=false) = new Tabulate(inner,name,alwaysValid)(mAns)

  // --------------------------------------------------------------------------
  // Terminal abstraction
  abstract case class Terminal[T: Manifest](min:Int,max:Int) extends Parser[T] {
    //final val (alt,cat) = (1,0)
    //def unapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = term_unapply(this,i,j,bt)
    //def reapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = term_reapply(this,i,j,bt)
  }

  // Aggregate combinator.
  // Takes a function which modifies the list of a parse. Usually used
  // for max or min functions (but can also be a prettyprint).
  case class Aggregate[T:Manifest](inner:Parser[T], h:(Rep[T],Rep[T])=>Rep[T]) extends Parser[T] {
    //def min = inner.min
    //def max = inner.max
    //lazy val (alt,cat) = (inner.alt,inner.cat)
    def apply(i:Rep[Int],j:Rep[Int]) = {
      val l = inner(i,j)
      if (l.isEmpty) Nil
      else {
        val folded = list_fold(l.tail, l.head, {(a: Rep[(T,Backtrack)], b: Rep[(T,Backtrack)]) =>
          if(a._1 == h(a._1, b._1)) a else b
        })
        List(folded)
      }
    }
    //def unapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = inner.unapply(i,j,bt) // we have only 1 result
    //def reapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = inner.reapply(i,j,bt)
  }

  // Filter combinator.
  // Yields an empty list if the filter does not pass.
  case class Filter[T:Manifest](inner:Parser[T], p: Rep[T] => Rep[Boolean]) extends Parser[T] {
    //def min = inner.min
    //def max = inner.max
    //lazy val (alt,cat) = (inner.alt,inner.cat)
    def apply(i:Rep[Int],j:Rep[Int]) = inner(i,j) filter {x: Rep[(T,Backtrack)] =>
      p(x._1)
    }
    //def unapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = inner.unapply(i,j,bt) // filter matched at apply
    //def reapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = inner.reapply(i,j,bt) // ditto
  }

  // Mapper. Equivalent of ADP's <<< operator.
  // To separate left and right hand side of a grammar rule
  case class Map[T:Manifest,U:Manifest](inner:Parser[T], f: Rep[T] => Rep[U]) extends Parser[U] {
    //def min = inner.min
    //def max = inner.max
    //lazy val (alt,cat) = (inner.alt,inner.cat)
    def apply(i:Rep[Int],j:Rep[Int]) = inner(i,j) map {x: Rep[(T,Backtrack)] =>
      (f(x._1), x._2)
    }
    //def unapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = inner.unapply(i,j,bt)
    //def reapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = map_reapply(this,i,j,bt)
  }

  // Or combinator. Equivalent of ADP's ||| operator.
  // In ADP semantics we concatenate the results of the parse
  // of 'this' with the parse of 'that'
  case class Or[T:Manifest](left:Parser[T], right:Parser[T]) extends Parser[T] {
    //def min = Math.min(left.min,right.min)
    //def max = if (left.max==maxN || right.max==maxN) maxN else Math.max(left.max,right.max)
    //lazy val (alt,cat) = (left.alt+right.alt, Math.max(left.cat,right.cat))
    def apply(i:Rep[Int],j:Rep[Int]) = left(i,j) ++ right(i,j)
    //def unapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = or_unapply(this,i,j,bt)
    //def reapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = or_reapply(this,i,j,bt)
  }

  // Concatenate combinator.
  // Parses a concatenation of string " left ~ right " with length(left) in [lL,lU]
  // and length(right) in [rL,rU], lU,rU=0 means unbounded (infinity).
  case class Concat[T:Manifest,U:Manifest](left: Parser[T], right:Parser[U]/*, track:Int*/) extends Parser[(T,U)] {
    val lL = unit(0) //TODO, make em unit
    val lU = unit(20)
    val rL = unit(0)
    val rU = unit(20)

    //TODO: remove maxN from here
    val maxN = unit(10000)

    val rAlt = unit(2); val rCat = unit(3)
    val lAlt = unit(3); val lCat = unit(2)

    //def min = left.min+right.min
   // def max = if (left.max==maxN || right.max==maxN) maxN else left.max+right.max
    //lazy val (alt,cat) = (left.alt*right.alt, left.cat+(if(hasBt)1 else 0)+right.cat)
    /*lazy val hasBt:Boolean = (track,left.min,left.max,right.min,right.max) match {
      case (0,a,b,c,d) if ((a==b && a>=0) || (c==d && c>=0)) => false
      case (1,a,b,_,_) if (a==b && a>=0) => false
      case (2,_,_,a,b) if (a==b && a>=0) => false
      case _ => true
    }
    lazy val indices = { assert(analyzed==true); (left.min,left.max,right.min,right.max) }
    */

    def apply(i:Rep[Int],j:Rep[Int]) = {
      def bt(bl:Rep[Backtrack],br:Rep[Backtrack], k:Rep[Int]):Rep[Backtrack] =
        (bl._1 * rAlt + br._1, bl._2 ++ List(k)) //(if (p.hasBt) List(k) else List()) ++ br._2)
      //val (lL,lU,rL,rU) = p.indices
      //if (p.track==0) {
          val min_k = if (rU==maxN || i+lL > j-rU) i+lL else j-rU
          val max_k = if (lU==maxN || j-rL < i+lU) j-rL else i+lU
          for(
            k <- (min_k until max_k + unit(1)).toList;
            x <- left.apply(i,k);
            y <- right.apply(k,j)
          ) yield make_tuple2((x._1,y._1),bt(x._2,y._2,k))
      /*} else if (p.track==1) {
          val min_k = if (lU==maxN || i-lU < 0) 0 else i-lU
          val max_k = i-lL
          for(
            k <- (min_k to max_k).toList;
            (x,xb) <- p.left(k,i); // in1[k..i]
            (y,yb) <- p.right(k,j) // M[k,j]
          ) yield(((x,y),bt(xb,yb,k)))
      } else if (p.track==2) {
          val min_k = if (rU==maxN || j-rU < 0) 0 else j-rU
          val max_k = j-rL
          for(
            k <- (min_k to max_k).toList;
            (x,xb) <- p.left(i,k); // M[i,k]
            (y,yb) <- p.right(k,j) // in2[k..j]
          ) yield(((x,y),bt(xb,yb,k)))
      } else Nil*/
    }
    //def unapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = ccat_unapply(this,i,j,bt)
    //def reapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = ccat_reapply(this,i,j,bt)
  }


  class Tabulate(in: => Parser[Answer], val name:String, val alwaysValid:Boolean=false)(implicit val mAns: Manifest[Answer]) extends Parser[Answer] {
    lazy val inner = in
//    val (alt,cat) = (1,0)
//    def min = minv; var minv = 0
//    def max = maxv; var maxv = 0

//    if (rules.contains(name)) sys.error("Duplicate tabulation name")
//    rules += ((name,this))
//    var id:Int = -1 // subrules base index

    // Matrix storage
//    var data:Rep[Array[(Answer,Backtrack)]] = unit(null)
//    var mW:Rep[Int] = unit(0)
//    var mH:Rep[Int] = unit(0)
//    def init(w:Rep[Int],h:Rep[Int]) = tab_init(this,w,h)
//    def reset = tab_reset(this)
    def apply(i:Rep[Int],j:Rep[Int]) = {
      //val v = t.data(tab_idx(t,i,j))
      //if (v!=null) List((v._1,bt0)) else List()
      List[(Answer, Backtrack)]()
    }
//    def unapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = tab_unapply(this,i,j,bt)
//    def reapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = tab_reapply(this,i,j,bt)
//    def compute(i:Rep[Int],j:Rep[Int]) = tab_compute(this,i,j)
//    def build(bt:Trace) = tab_build(this,bt)
//    def backtrack(i:Rep[Int],j:Rep[Int]) = tab_backtrack(this,i,j)
  }

}