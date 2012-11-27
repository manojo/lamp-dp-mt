package v3

class Dummy // empty parser match
trait Signature {
  type Alphabet // input type
  type Answer   // output type

  val h:List[Answer]=>List[Answer] = l=>l
  val cyclic = false // cyclic problem
  val window = 0     // windowing size, 0=disabled

  def max[T:Numeric] = new (List[T]=>List[T]) {
    def apply(l:List[T]) = if (l.isEmpty) Nil else List(l.max)
    override def toString = "$$max$$"
  }
  def min[T:Numeric] = new (List[T]=>List[T]) {
    def apply(l:List[T]) = if (l.isEmpty) Nil else List(l.min)
    override def toString = "$$min$$"
  }
  def count[T:Numeric] = new (List[T]=>List[T]) {
    def apply(l:List[T]) = if (l.isEmpty) Nil else List(l.length.asInstanceOf[T])
    override def toString = "$$count$$"
  }
  def sum[T:Numeric] = new (List[T]=>List[T]) {
    def apply(l:List[T]) = if (l.isEmpty) Nil else List(l.sum)
    override def toString = "$$sum$$"
  }
}

trait BaseParsers extends CodeGen { this:Signature =>
  var size = 0 // for cyclic problems
  type Subword = (Int, Int)
  type Backtrack = List[Int]
  type Input = Array[Alphabet]

  // Memoization through tabulation
  import scala.collection.mutable.HashMap
  val tabs = new HashMap[String,HashMap[Subword,List[(Answer,Backtrack)]]]
  def tabulate(name:String, inner: => Parser[Answer]) = new Parser[Answer] {
    //override val numAlt = inner.numAlt => from makeTree instead
    //override val numCc = inner.numCc
    val map = tabs.getOrElseUpdate(name,new HashMap[Subword,List[(Answer,Backtrack)]])
    rules += ((name,this))

    override def makeTree = inner.tree
    val tree = PRule(name)
    def apply(sw: Subword) = sw match {
      case (i,j) if(i <= j) => map.getOrElseUpdate(if(cyclic) (i%size, j%size) else sw, inner(sw))
      case _ => List()
    }
  }

  // Mapper. Equivalent of ADP's <<< operator.
  // To separate left and right hand side of a grammar rule
  def p_map[T,U](inner:Parser[T], f: T => U) = new Parser[U] {
    def tree = PMap(f,inner.tree)
    def apply(sw:Subword) = inner(sw) map {case (s,b) => (f(s),b) }
  }

  // Or combinator. Equivalent of ADP's ||| operator.
  // In ADP semantics we concatenate the results of the parse
  // of 'this' with the parse of 'that'
  def p_or[T](inner:Parser[T], that: Parser[T]) = new Parser[T] {
    def tree = POr(inner.tree, that.tree)
    def apply(sw: Subword) = inner(sw)++that(sw)
  }

  // Aggregate combinator.
  // Takes a function which modifies the list of a parse. Usually used
  // for max or min functions (but can also be a prettyprint).
  def p_aggr[T](inner:Parser[T], h: List[T] => List[T]) = new Parser[T] {
    def tree = PAggr(h,inner.tree)
    def apply(sw: Subword) = { val l=inner(sw); val b=h(l.map(_._1)); l.filter{e=>b contains e._1} }
  }

  // Filter combinator.
  // Yields an empty list if the filter does not pass.
  def p_filter[T](inner:Parser[T], p: Subword => Boolean) = new Parser[T] {
    def tree = PFilter(p, inner.tree)
    def apply(sw: Subword) = if(p(sw)) inner(sw) else List[(T,Backtrack)]()
  }

  // Concatenate combinator.
  // Parses a concatenation of string left~right with length(left) in [lL,lU]
  // and length(right) in [rL,rU], lU,rU=0 means unbounded (infinity).
  def p_concat[T,U](inner:Parser[T], that: Parser[U], indices:(Int,Int,Int,Int)) = new Parser[(T,U)] {
    def tree = PConcat(inner.tree, that.tree, indices)
    def apply(sw: Subword) = (twotracks,sw,indices) match {
      case (false,(i,j),(lL,lU,rL,rU)) if i<j => // Regular parsers
        val min_k = if (rU==0) i+lL else Math.max(i+lL,j-rU)
        val max_k = if (lU==0) j-rL else Math.min(j-rL,i+lU)
        for(
          k <- (min_k to max_k).toList;
          (x,xb) <- inner((i,k));
          (y,yb) <- that((k,j))
        ) yield(((x,y),xb:::k::yb)) // XXX: add k only fot the case where it's moving

      case (true,(i,j),(l,u,1,_)) if i<j => // concat1
        val i0 = if (l==0) 0 else Math.max(i-l,0)
        for(
          k <- (i0 to i-u).toList;
          (x,xb) <- inner.apply((k,i)); // inner.apply2((i,j),k);
          (y,yb) <- that((k,j))
        ) yield(((x,y),xb:::k::yb)) // XXX: fix this

      case (true,(i,j),(l,u,2,_)) if i<j => // concat2
        val j0 = if (l==0) 0 else Math.max(j-l,0)
        for(
          k <- (j0 to j-u).toList;
          (x,xb) <- inner((i,k));
          (y,yb) <- that.apply((k,j)) //that.apply2((i,j),k)
        ) yield(((x,y),xb:::k::yb)) // XXX: fix this
      case _ => List()
    }
  }

  abstract class Parser[T] extends (Subword => List[(T,Backtrack)]) with Treeable { inner =>
    def apply(sw: Subword): List[(T,Backtrack)]

    def ^^[U](f: T => U) = p_map(inner,f)
    def |(that: Parser[T]) = p_or(inner,that)
    def aggregate(h: List[T] => List[T]) = p_aggr(inner,h)
    def filter (p: Subword => Boolean) = p_filter(inner,p)
  }
}

