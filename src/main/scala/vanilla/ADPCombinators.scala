package vanilla

trait Signature {
  type Alphabet // input type
  type Answer   // output type

  def h(l: List[Answer]) : List[Answer]
}

trait ADPParsers { this:Signature =>
  type Subword = (Int, Int)
  type Input = Array[Alphabet]

  // Input is a "global" value, used during the whole running time of algorithm
  def input: Input

  // Tree structure for recurrences generation
  abstract class PTree
  case class PTerminal[T](t:T) extends PTree { override def toString = t.toString }
  case class PAggr[T,U](h: List[T] => List[U], p: PTree) extends PTree { override def toString = "Best("+p+")"  }
  case class POr(l: PTree, r: PTree) extends PTree { override def toString = l +" ++ "+r }
  case class PMap[T,U](f: T => U, p: PTree) extends PTree { override def toString = "Map("+p+")"  }
  case class PFilter(f: Subword => Boolean, p: PTree) extends PTree { override def toString = "Filter("+p+")"  }
  case class PRule(name:String) extends PTree { override def toString=name }
  case class PConcat(l: PTree, r: PTree, indices:(Int,Int,Int,Int)) extends PTree {
    override def toString = indices match {
      case (1,1,0,0) => l + " -~~ "+r
      case (0,0,1,1) => l + " ~~- "+r
      case _ => l+" ~"+indices+"~ "+r
    }
  }

  // Memoization through tabulation
  import scala.collection.mutable.HashMap
  val tabs = new HashMap[String,HashMap[Subword,List[Answer]]]

  def tabulate(name:String, p:Parser[Answer]) = new Parser[Answer] {
    val map = tabs.getOrElseUpdate(name,new HashMap[Subword,List[Answer]])
    def apply(sw: Subword) = sw match {
      case (i,j) if(i <= j) => map.getOrElseUpdate(sw, p(sw))
      case _ => List()
    }
    def tree = p.tree
  }


  abstract class Parser[T] extends (Subword => List[T]) { inner =>
    def apply(sw: Subword): List[T]
    def tree : PTree

    // Mapper. Equivalent of ADP's <<< operator.
    // To separate left and right hand side of a grammar rule
    def ^^[U](f: T => U) = this.map(f)
    private def map[U](f: T => U) = new Parser[U]{
      def apply(sw:Subword) = inner(sw) map f
      def tree = PMap(f,inner.tree)
    }

    // Or combinator. Equivalent of ADP's ||| operator.
    // In ADP semantics we concatenate the results of the parse
    // of 'this' with the parse of 'that'
    def |(that: => Parser[T]) = or(that)
    private def or (that: => Parser[T]) = new Parser[T]{
      def apply(sw: Subword) = inner(sw)++that(sw)
      def tree = POr(inner.tree, that.tree)
    }

    // Aggregate combinator.
    // Takes a function which modifies the list of a parse. Usually used
    // for max or min functions (but can also be a prettyprint).
    def aggregate[U](h: List[T] => List[U]) = new Parser[U]{
      def apply(sw: Subword) = h(inner(sw))
      def tree = PAggr(h,inner.tree)
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
      def tree = PConcat(inner.tree, that.tree, (lL,lU,rL,rU))
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
      def tree = PFilter(p, inner.tree)
    }

    /**
     * named parser. If the parser has a name its tree will be
     * made only once
     */
    /*
    def named(name: String) = new Parser[T]{
      def apply(sw: Subword) = inner.apply(sw)
      def makeTree = store.get(name) match {
        case None =>
          store += name -> Production(name)
          inner.makeTree
        //WATCHOUT for possible unsafe type casting!!
        case Some(p) => p.asInstanceOf[PTree[T]]
      }
    }
    def gen[T](p: Parser[T]): String = gen(p.makeTree)
    def gen[T](t: PTree[T]): String = t match {
      case Production(name) => name+"[i,j]"
      //case CharT() => "char"
      case Or(l,r) => gen(l) + " ++ " + gen(r)
      case Map(f, Concat(l,r, (lL, lU, rL, rU))) =>
        val lgen = gen(l)
        val rgen = gen(r)
        lgen+ "k]" + " + " + "[k" + rgen // to replace with gen of f
      case Map(f, t) =>
        gen(t)
      case Aggregate(h,t) =>
        "min(" + gen(t) +")"

      case _ => "no gen yet!"
    }
    */
  }
  // val store = new scala.collection.mutable.HashMap[String,PTree[Any]]
}

trait LexicalParsers extends ADPParsers { this:Signature =>
  override type Alphabet = Char

  def char = new Parser[Char]{
    def apply(sw:Subword) = sw match {
      case (i, j) if(j == i+1) => List(input(i))
      case _ => List()
    }
    def tree = new PTerminal("Char")
  }

  def charf(f: Char => Boolean) = char filter {
    case(i,j) if(i+1 == j) => f(input(i))
    case _ => false
  }

  def digitParser: Parser[Int] = (char filter isDigit) ^^ readDigit
  def readDigit(c: Char) = (c - '0').toInt
  def isDigit(sw: Subword) = sw match {
    case(i,j) if(i+1 == j) => input(i).isDigit
    case _ => false
  }
}

/*** Example ***/

trait BracketsSignature extends Signature {
  def readDigit(c: Alphabet) : Answer
  def bracket(l: Alphabet, s: Answer, r: Alphabet) : Answer
  def split(s: Answer, t: Answer): Answer
}

trait BracketsAlgebra extends BracketsSignature {
  type Answer = Int
  override type Alphabet = Char

  def bracket(l: Char, s: Int, r: Char) = s
  def split(s: Int, t: Int) = s+t
  def h(l : List[Int]) = if(l.isEmpty) List() else List(l.max)
}

object HelloADP extends LexicalParsers with BracketsAlgebra {
  def input = "(((3)))(2)".toArray
  def bracketize(c:Char,s:String) = "("+c+","+s+")"

  def areBrackets(sw: Subword) = sw match {
    case(i,j) => input(i) == '(' && input(j-1) == ')'
  }

  val dummyParser = digitParser | digitParser
  val myParser: Parser[Int] = tabulate("M",
      digitParser
    | (char -~~ myParser ~~- char).filter(areBrackets _).^^{ case (c1,(i,c2)) => i}
    | myParser +~+ myParser ^^ {case (x,y) => x+y}
  )

  def main(args: Array[String]) = {
    println(myParser(0,input.length))
    println("Hash maps: "+tabs.size)
  }
}
