package v2

trait Signature {
  type Alphabet // input type
  type Answer   // output type

  def h(l: List[Answer]) : List[Answer]
  val cyclic = false // is the problem cyclic
  val window = 0     // windowing the problem
}

trait ADPParsers { this:Signature =>
  type Subword = (Int, Int)
  type Input = Array[Alphabet]

  // Input is a "global" value, used during the whole running time of algorithm
  private var input: Input = null
  def in(k:Int):Alphabet = input(k % size) // to deal with cyclic
  def size:Int = input.size

  // Memoization through tabulation
  import scala.collection.mutable.HashMap
  val tabs = new HashMap[String,HashMap[Subword,List[Answer]]]
  val rules = new HashMap[String,Parser[Answer]]
  def tabulate(name:String, inner:Parser[Answer]) = new Parser[Answer] {
    val map = tabs.getOrElseUpdate(name,new HashMap[Subword,List[Answer]])
    rules += ((name,this))

    def apply(sw: Subword) = sw match {
      case (i,j) if(i <= j && cyclic) =>
        val sw2 = (i%size, j%size); map.getOrElseUpdate(sw2, inner(sw))
      case (i,j) if(i <= j) => map.getOrElseUpdate(sw, inner(sw))
      case _ => List()
    }
    //def tree = PRule(name)
    //override def makeTree = inner.tree
  }

  abstract class Parser[T] extends (Subword => List[T]) { inner =>
    def apply(sw: Subword): List[T]
    //def tree : PTree
    //def makeTree = tree

    // Mapper. Equivalent of ADP's <<< operator.
    // To separate left and right hand side of a grammar rule
    def ^^[U](f: T => U) = this.map(f)
    private def map[U](f: T => U) = new Parser[U]{
      def apply(sw:Subword) = inner(sw) map f
      //def tree = PMap(f,inner.tree)
    }

    // Or combinator. Equivalent of ADP's ||| operator.
    // In ADP semantics we concatenate the results of the parse
    // of 'this' with the parse of 'that'
    def |(that: => Parser[T]) = or(that)
    private def or (that: => Parser[T]) = new Parser[T] {
      def apply(sw: Subword) = inner(sw)++that(sw)
      //def tree = POr(inner.tree, that.tree)
    }

    // Aggregate combinator.
    // Takes a function which modifies the list of a parse. Usually used
    // for max or min functions (but can also be a prettyprint).
    def aggregate[U](h: List[T] => List[U]) = new Parser[U] {
      def apply(sw: Subword) = h(inner(sw))
      //def tree = PAggr(h,inner.tree)
    }

    // Concatenate combinator.
    // Parses a concatenation of string left~right with length(left) in [lL,lU]
    // and length(right) in [rL,rU], lU,rU=0 means unbounded (infinity).
    private def concat[U](lL:Int, lU:Int, rL:Int, rU:Int)(that: => Parser[U]) = new Parser[(T,U)] {
      def apply(sw: Subword) = sw match {
        case (i,j) if i<j =>
          val min_k = if (rU==0) i+lL else Math.max(i+lL,j-rU)
          val max_k = if (lU==0) j-rL else Math.min(j-rL,i+lU)
          for(
            k <- (min_k to max_k).toList;
            x <- inner((i,k));
            y <- that((k,j))
          ) yield((x,y))
        case _ => List[(T,U)]()
      }
      //def tree = PConcat(inner.tree, that.tree, (lL,lU,rL,rU))
    }

    def ~~~ [U](that: => Parser[U]) = concat(0,0,0,0)(that)
    def ~~+ [U](that: => Parser[U]) = concat(0,0,1,0)(that)
    def +~~ [U](that: => Parser[U]) = concat(1,0,0,0)(that)
    def +~+ [U](that: => Parser[U]) = concat(1,0,1,0)(that)

    def *~~ [U](lMin:Int, rRange:Pair[Int,Int], that: => Parser[U]) = concat(lMin,0,rRange._1,rRange._2)(that)
    def ~~* [U](lRange:Pair[Int,Int], rMin:Int, that: => Parser[U]) = concat(lRange._1,lRange._2,rMin,0)(that)
    def *~* [U](lMin:Int, rMin:Int, that: => Parser[U]) = concat(lMin,0,rMin,0)(that)

    def ~~ [U](lRange:Pair[Int,Int], rRange:Pair[Int,Int], that: => Parser[U]) = concat(lRange._1,lRange._2,rRange._1,rRange._2)(that)

    def -~~ [U](that: => Parser[U]) = concat(1,1,0,0)(that)
    def ~~- [U](that: => Parser[U]) = concat(0,0,1,1)(that)

    // Filter combinator.
    // Yields an empty list if the filter does not pass.
    def filter (p: Subword => Boolean) = new Parser[T] {
      def apply(sw: Subword) = if(p(sw)) inner(sw) else List[T]()
      //def tree = PFilter(p, inner.tree)
    }
  }

  def parse(p:Parser[Answer])(in:Input):List[Answer] = {
    input = in;
    val res = if (cyclic) {
      h( ((0 until size).flatMap{ x => p(x,size+x) }).toList )
    } else if (window>0) {
      h( ((0 to size-window).flatMap{ x => p(x,window+x) }).toList )
    } else {
      p(0,size)
    }
    input = null; res
  }

  //def elems(k:Int) = new Parser[List[Alphabet]] {}
  //def elem:Parser[Alphabet] = elem(1).head
}

trait LexicalParsers extends ADPParsers { this:Signature =>
  override type Alphabet = Char

  def char = new Parser[Char] {
    def apply(sw:Subword) = sw match {
      case (i, j) if(j == i+1) => List(in(i))
      case _ => List()
    }
    //def tree = new PTerminal((i:Var,j:Var) => (List(i.e(j,1)),"Char["+i+"]"))
  }

  // same as a char but returns its index instead
  def chari = new Parser[Int] {
    def apply(sw:Subword) = sw match {
      case (i, j) if(j == i+1) => List(i)
      case _ => List()
    }
  }

  def charf(f: Char => Boolean) = char filter {
    case(i,j) if(i+1 == j) => f(in(i))
    case _ => false
  }

  def digitParser: Parser[Int] = (char filter isDigit) ^^ readDigit
  def readDigit(c: Char) = (c - '0').toInt
  def isDigit(sw: Subword) = sw match {
    case(i,j) if(i+1 == j) => in(i).isDigit
    case _ => false
  }
}
