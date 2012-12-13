package v4

class Dummy // empty parser match

trait Signature {
  type Alphabet // input type
  type Answer // output type

  val window = 0 // windowing size, 0=disabled
  val h:List[Answer]=>List[Answer] = l=>l // optimization function

  def max[T:Numeric]: List[T]=>List[T]
  def min[T:Numeric]: List[T]=>List[T]
  def sum[T:Numeric]: List[T]=>List[T]
  def count[T:Numeric]: List[T]=>List[T]
  def maxBy[T:Numeric](f:Answer=>T): List[Answer]=>List[Answer]
  def minBy[T:Numeric](f:Answer=>T): List[Answer]=>List[Answer]
}

trait BaseParsers { this:Signature =>
  type Input = Array[Alphabet]
  type Subword = (Int, Int)
  type Backtrack = (Int,List[Int]) // (subrule_id, indices)
  type BTItem = (Subword,Answer,Backtrack)

  val axiom:Tabulate // initial parser to be applied
  val twotracks = false // whether grammar is multi-track
  final val bt0 = (0,Nil) // default initial backtrack

  // Helpers
  case class Var(v:Char,d:Int) { // Variables: name+offset => 'v'+d
    override def toString = if (d==0) ""+v else if (d>0) v+"+"+d else v+""+d
    def add(e:Int) = Var(v,d+e)
    def loop(l:Var,u:Var) = CFor(v,l.v,d-l.d,u.v,d-u.d)
    def leq(t:Var,e:Int) = CLeq(v,t.v,d-t.d+e)
    def eq(t:Var,e:Int) = CEq(v,t.v,d-t.d+e)
  }
  final val zero = Var('0',0) // 0+0
  final val maxN = -1 // infinity for Parser.max

  sealed abstract class Cond // Constraint on variables
  case class CFor(v:Char,l:Char,ld:Int,u:Char,ud:Int) extends Cond // for ('l'+ld<='v'<='u'-ud)
  case class CLeq(a:Char,b:Char,delta:Int) extends Cond // 'a'+delta<='b'
  case class CEq(a:Char,b:Char,delta:Int) extends Cond // 'a'+delta=='b'

  sealed abstract class Parser[T] extends (Subword => List[(T,Backtrack)]) {
    def min:Int // subword minimal size
    def max:Int // subword maximal size, -1=infinity
    val alt:Int // alternative (subrule_id)
    val cat:Int // concatenation split (offset in backtrack)

    def apply(sw:Subword): List[(T,Backtrack)]
    def unapply(sw:Subword,bt:Backtrack): List[(T, List[BTItem])]
    def reapply(sw:Subword,bt:Backtrack): T

    final def ^^[U](f: T => U) = new Map(this,f)
    final def |(other: Parser[T]) = new Or(this,other)
    final def aggregate(h: List[T] => List[T]) = new Aggregate(this,h)
    final def filter (f: Subword => Boolean) = new Filter(this,f)
  }

  // Recurrence analysis, done once when grammar is complete, before the computation.
  private var analyzed=false
  def analyze:Boolean = { if (analyzed) return false; analyzed=true
    // Yield analysis
    val sz = rules.size
    for((n,t)<-rules) t.minv=3000 // very large number
    (0 until sz).foreach{ _ => for((n,t) <- rules) t.minv=t.inner.min }
    for((n,t)<-rules) t.maxv=t.minv
    for((n,t)<-rules) t.maxv=rmax(t.inner,sz)
    def rmax[T](p0:Parser[T],d:Int):Int = p0 match {
      case Terminal(_,max,_) => max
      case Filter(p,f) => rmax(p,d)
      case Aggregate(p,h) => rmax(p,d)
      case Map(p,f) => rmax(p,d)
      case Or(l,r) => val ml=rmax(l,d); if (ml==maxN) maxN else { val mr=rmax(r,d); if (mr==maxN) maxN else Math.max(ml,mr) }
      case Concat(l,r,_,_) => val ml=rmax(l,d); if (ml==maxN) maxN else { val mr=rmax(r,d); if (mr==maxN) maxN else ml+mr }
      case p:Tabulate => if (d==1) maxN else rmax(p.inner,d-1)
    }
    // Identify subrules (uniquely within the same grammar as sorted by name)
    var id=0; for((n,p) <- rules.toList.sortBy(_._1)) { p.id=id; id=id+p.inner.alt; }
    true
  }

  // Aggregate on T a (T,U) list, wrt to multiplicity and order
  def aggr[T,U](l:List[(T,U)], h: List[T] => List[T]):List[(T,U)] = {
    val a=l.toArray; var start=0;
    h(l.map(_._1)).map { b => val i=a.indexWhere({x=>x._1==b},start);
      if (i== -1) (b,l.head._2) // aggregators such as count, sum do not have matching backtrack
      else { val r=a(i); a(i)=a(start); start=start+1; r }
    }
  }

  // --------------------------------------------------------------------------
  // Memoization through tabulation
  import scala.collection.mutable.HashMap
  val rules = new HashMap[String,Tabulate]
  val tabs = new HashMap[String,HashMap[Subword,List[(Answer,Backtrack)]]]
  var reset:(()=>Unit) = () => { /*printTabs*/ }

  def tabulate(name:String, inner: => Parser[Answer]) = new Tabulate(inner,name)
  class Tabulate(in: => Parser[Answer], val name:String) extends Parser[Answer] {
    lazy val inner = in
    val (alt,cat) = (1,0)
    def min = minv; var minv = 0
    def max = maxv; var maxv = 0
    private val map = tabs.getOrElseUpdate(name,new HashMap[Subword,List[(Answer,Backtrack)]])
    reset = { val r0=reset; () => { r0(); map.clear; } }
    if (rules.contains(name)) sys.error("Duplicate tabulation name")
    rules += ((name,this))

    var id:Int = -1 // subrules base index
    private def get(sw:Subword) = { if (!twotracks) assert(sw._1<=sw._2); map.getOrElseUpdate(sw,inner(sw).map{case(c,(r,b))=>(c,(id+r,b))}) }
    def apply(sw: Subword) = get(sw) map {x=>(x._1,bt0)}
    def unapply(sw:Subword,bt:Backtrack) = get(sw) map { case (c,b) => (c,List((sw,c,b))) }
    def reapply(sw:Subword,bt:Backtrack) = map.get(sw) match { case Some(v) => v.head._1 case _ => sys.error("Failed reapply"+sw); apply(sw).head._1 }

    def backtrack(sw:Subword) = countMap(get(sw), (e:(Answer,Backtrack),n:Int)=>backtrack0(n,Nil,List((sw,e._1,e._2))).map{x=>(e._1,x)} ).flatten
    def build(bt:List[(Subword,Backtrack)]):Answer = {
      for((sw,(rule,b))<-bt) { val (t,rr)=find(rule); t.map.put(sw,List((t.inner.reapply(sw,(rr,b)),bt0))) }
      val (sw,(rule,b))=bt.last; inner.reapply(sw,(rule-id,b))
    }

    private def countMap[T,U](ls:List[T],f:((T,Int)=>U)):List[U] = ls.groupBy(x=>x).map{ case(e,l)=>f(e,l.length) }.toList
    private def backtrack0(mult:Int,tail:List[(Subword,Backtrack)],pending:List[BTItem]):List[List[(Subword,Backtrack)]] = pending match {
      case Nil => List(tail)
      case (sw,score,(rule,bt))::ps => val (t,rr) = find(rule)
        val res = t.inner.unapply(sw, (rr,bt)).filter{case(r,l)=>r==score}.map{case(r,l)=>l}.take(mult)
        countMap(res,(pl:List[BTItem],mul:Int)=>backtrack0(mul,(sw,(rule,bt))::tail, pl:::ps)).flatten
    }
    private def find(rule:Int):(Tabulate,Int) = {
      rules.find{ case (n,t)=> val rr=rule-t.id; rr >= 0 && rr < t.inner.alt} match {
        case Some((n,t)) => (t,rule-t.id)
        case None => sys.error("No tabulation for subrule #"+rule)
      }
    }
  }

  // --------------------------------------------------------------------------
  // Terminal abstraction
  abstract case class Terminal[T](min:Int,max:Int, f:(Var,Var)=>(List[Cond],String)) extends Parser[T] {
    final val (alt,cat) = (1,0)
    def unapply(sw:Subword,bt:Backtrack) = apply(sw).map{ case(t,b) => (t,Nil) }
    def reapply(sw:Subword,bt:Backtrack) = {
      if (apply(sw).isEmpty) sys.error("Empty apply"+sw+" for "+bt)
      apply(sw).map{ _._1 }.head
    }
  }

  // Aggregate combinator.
  // Takes a function which modifies the list of a parse. Usually used
  // for max or min functions (but can also be a prettyprint).
  case class Aggregate[T](inner:Parser[T], h: List[T] => List[T]) extends Parser[T] {
    def min = inner.min
    def max = inner.max
    lazy val (alt,cat) = (inner.alt,inner.cat)
    def apply(sw: Subword) = aggr(inner(sw),h)
    def unapply(sw:Subword,bt:Backtrack) = aggr(inner.unapply(sw,bt),h)
    def reapply(sw:Subword,bt:Backtrack) = inner.reapply(sw,bt)
  }

  // Filter combinator.
  // Yields an empty list if the filter does not pass.
  case class Filter[T](inner:Parser[T], pred: Subword => Boolean) extends Parser[T] {
    def min = inner.min
    def max = inner.max
    lazy val (alt,cat) = (inner.alt,inner.cat)
    def apply(sw: Subword) = if(pred(sw)) inner(sw) else Nil
    def unapply(sw:Subword,bt:Backtrack) = inner.unapply(sw,bt) // filter matched at apply
    def reapply(sw:Subword,bt:Backtrack) = inner.reapply(sw,bt) // ditto
  }

  // Mapper. Equivalent of ADP's <<< operator.
  // To separate left and right hand side of a grammar rule
  case class Map[T,U](inner:Parser[T], f: T => U) extends Parser[U] {
    def min = inner.min
    def max = inner.max
    lazy val (alt,cat) = (inner.alt,inner.cat)
    def apply(sw:Subword) = inner(sw) map { case (s,b) => (f(s),b) }
    def unapply(sw:Subword,bt:Backtrack) = inner.unapply(sw,bt).map{ case (s,b) => (f(s),b) }
    def reapply(sw:Subword,bt:Backtrack) = f(inner.reapply(sw,bt))
  }

  // Or combinator. Equivalent of ADP's ||| operator.
  // In ADP semantics we concatenate the results of the parse
  // of 'this' with the parse of 'that'
  case class Or[T](left:Parser[T], right:Parser[T]) extends Parser[T] {
    def min = Math.min(left.min,right.min)
    def max = if (left.max==maxN || right.max==maxN) maxN else Math.max(left.max,right.max)
    lazy val (alt,cat) = (left.alt+right.alt, Math.max(left.cat,right.cat))
    def apply(sw: Subword) = left(sw) ++ right(sw).map{ case (t,(r,b)) => (t,(r+left.alt,b)) }
    def unapply(sw:Subword, bt:Backtrack) = { val (r,idx)=bt; var a=left.alt-1; if (r<=a) left.unapply(sw,(r,idx)) else right.unapply(sw,(r-a,idx)) }
    def reapply(sw:Subword, bt:Backtrack) = { val (r,idx)=bt; var a=left.alt-1; if (r<=a) left.reapply(sw,(r,idx)) else right.reapply(sw,(r-a,idx)) }
  }

  // Concatenate combinator.
  // Parses a concatenation of string " left ~ right " with length(left) in [lL,lU]
  // and length(right) in [rL,rU], lU,rU=0 means unbounded (infinity).
  case class Concat[T,U](left: Parser[T], right:Parser[U], track:Int, allowEmpty:(Boolean,Boolean)=(true,true)) extends Parser[(T,U)] {
    def min = left.min+right.min
    def max = if (left.max==maxN || right.max==maxN) maxN else left.max+right.max
    lazy val (alt,cat) = (left.alt*right.alt, left.cat+(if(hasBt)1 else 0)+right.cat)
    lazy val hasBt:Boolean = (track,left.min,left.max,right.min,right.max) match {
      case (0,a,b,c,d) if ((a==b && a>=0) || (c==d && c>=0)) => false
      case (1,a,b,_,_) if (a==b && a>=0) => false
      case (2,_,_,a,b) if (a==b && a>=0) => false
      case _ => true
    }
    lazy val indices = {
      assert(analyzed==true);
      var lm = left.min; if (!allowEmpty._1 && lm==0) lm=1
      var rm = right.min; if (!allowEmpty._2 && rm==0) rm=1
      (lm,left.max,rm,right.max)
    }
    private def bt(bl:Backtrack,br:Backtrack,k:Int):Backtrack = {
      (bl._1*right.alt+br._1, bl._2:::(if (hasBt)List(k) else Nil):::br._2)
    }
    def apply(sw:Subword) = (sw,track,indices) match {
      case ((i,j),0,(lL,lU,rL,rU)) if i<j => // single track
        val min_k = if (rU==maxN) i+lL else Math.max(i+lL,j-rU)
        val max_k = if (lU==maxN) j-rL else Math.min(j-rL,i+lU)
        for(
          k <- (min_k to max_k).toList;
          (x,xb) <- left((i,k));
          (y,yb) <- right((k,j))
        ) yield(((x,y),bt(xb,yb,k)))
      case ((i,j),1,(l,u,_,_)) => // tt:concat1
        val i0 = if (u==maxN) 0 else Math.max(i-u,0)
        for(
          k <- (i0 to i-l).toList;
          (x,xb) <- left((k,i)); // in1[k..i]
          (y,yb) <- right((k,j)) // M[k,j]
        ) yield(((x,y),bt(xb,yb,k)))
      case ((i,j),2,(_,_,l,u)) => // tt:concat2
        val j0 = if (u==maxN) 0 else Math.max(j-u,0)
        for(
          k <- (j0 to j-l).toList;
          (x,xb) <- left((i,k)); // M[i,k]
          (y,yb) <- right((k,j)) // in2[k..j]
        ) yield(((x,y),bt(xb,yb,k)))
      case _ => List()
    }

    private def bt_split(bt:Backtrack):(Backtrack,Backtrack,Int) = bt match { case (r,idx) =>
      val a:Int=right.alt; val c:Int=left.cat;
      ((r/a,idx.take(c)), (r%a,idx.drop(c+(if (hasBt)1 else 0))), if (hasBt)idx(c) else -1)
    }
    private def sw_split(sw:Subword,kb:Int) = (sw,track,indices) match {
      case ((i,j),0,(lL,lU,rL,rU)) if i<j => // single track
        val k=if(kb!=maxN)kb else if (rU==maxN)i+lL else Math.max(i+lL,j-rU); ((i,k),(k,j))
      case ((i,j),1,(l,u,_,_)) => val k=if(kb!=maxN)kb else i-l; ((k,i),(k,j)) // tt:concat1
      case ((i,j),2,(_,_,l,u)) => val k=if(kb!=maxN)kb else j-l; ((i,k),(k,j)) // tt:concat2
      case _ => ((0,0),(0,0))
    }

    def unapply(sw:Subword,bt:Backtrack) = {
      val (bl,br,k)=bt_split(bt); val (swl,swr)=sw_split(sw,k)
      for ((l,lb)<-left.unapply(swl,bl); (r,rb)<-right.unapply(swr,br)) yield (((l,r), lb:::rb))
    }
    def reapply(sw:Subword,bt:Backtrack) = {
      val (bl,br,k)=bt_split(bt); val (swl,swr)=sw_split(sw,k)
      (left.reapply(swl,bl), right.reapply(swr,br))
    }
  }

  // --------------------------------------------------------------------------
  // Signature's built-in methods
  override final def max[T:Numeric] = new (List[T]=>List[T]) {
    def apply(l:List[T]) = if (l.isEmpty) Nil else List(l.max)
    override def toString = "$$max$$"
  }
  override final def min[T:Numeric] = new (List[T]=>List[T]) {
    def apply(l:List[T]) = if (l.isEmpty) Nil else List(l.min)
    override def toString = "$$min$$"
  }
  override final def sum[T:Numeric] = new (List[T]=>List[T]) {
    def apply(l:List[T]) = if (l.isEmpty) Nil else List(l.sum)
    override def toString = "$$sum$$"
  }
  override final def count[T:Numeric] = new (List[T]=>List[T]) {
    def apply(l:List[T]) = if (l.isEmpty) Nil else List(l.length.asInstanceOf[T])
    override def toString = "$$count$$"
  }
  case class MinBy[T:Numeric](f:Answer=>T) extends (List[Answer]=>List[Answer]) {
    def apply(l:List[Answer]) = if (l.isEmpty) Nil else List(l.minBy(f))
    override def toString = "$$minBy$$"
  }
  case class MaxBy[T:Numeric](f:Answer=>T) extends (List[Answer]=>List[Answer]) {
    def apply(l:List[Answer]) = if (l.isEmpty) Nil else List(l.maxBy(f))
    override def toString = "$$maxBy$$"
  }
  def maxBy[T:Numeric](f:Answer=>T) = MaxBy(f)
  def minBy[T:Numeric](f:Answer=>T) = MinBy(f)

  // --------------------------------------------------------------------------
  // Utilities for debugging and pretty-printing
  def printBT(bs:List[(Answer,List[(Subword,Backtrack)])]) = {
    println("Backtrack = {")
    for(b<-bs) { print("  "+b._1+"   BT =")
      for (((i,j),(r,bt)) <- b._2) { print(" ["+i+","+j+"]="+r+","+bt+" ") }; println
    }
    println("}")
  }
  def printTabs {
    for((n,t)<-tabs) { println(n+":")
      for((k,v)<-t; (c,(r,bt))<-v) printf("  %-7s -> %-60s %d, %s\n",k,c,r,bt); println
    }
  }
}
