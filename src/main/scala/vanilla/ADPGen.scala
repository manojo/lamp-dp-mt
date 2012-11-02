package vanilla
import scala.collection.immutable.HashSet

trait ADPGen {

  abstract class PTree[+T]
  case class Aggregate[T,U](h: List[T] => List[U], p: PTree[T]) extends PTree[U]
  case class Or[T](l: PTree[T], r: PTree[T]) extends PTree[T]
  case class Map[T,U](f: T => U, p: PTree[T]) extends PTree[U]

  //type info more to "please" the type system than any deeper meaning
  case class Concat[T,U](l: PTree[T], r: PTree[U]) extends PTree[(T,U)]
  case class Filter[T](f: Subword => Boolean, p: PTree[T]) extends PTree[T]
  case class Production[T](name:String) extends PTree[T]

  abstract class Terminal[T] extends PTree[T]

  type Subword= (Int, Int)
  type Input// = String

  /*
   * the input is a "global" value, as in DP we need
   * the it during the whole running time of the algorithm
   */
  def input: Input

  /*
   * a global store which can be used to store parsers that
   * are productions. Used when transforming into a tree
   */
  val store = new scala.collection.mutable.HashMap[String,PTree[Any]]

  //def parseAll[T](p: Parser[T], in: Input, sw: Subword) =

  abstract class Parser[T] extends (Subword => List[T]){ inner =>

    def apply(sw: Subword): List[T]
    def makeTree : PTree[T]

    /**
     * mappers delight!!! equivalent to ADP's <<<
     */
    def map[U](f: T => U) = new Parser[U]{
      def apply(sw:Subword) = inner(sw) map f
      def makeTree = Map(f,inner.makeTree)
    }

    def ^^[U](f: T => U) = this.map(f)

    /*
     * an or combinator. In ADP semantics we concatenate
     * the results of the parse of 'this' with the parse of
     * 'that'
     */
    def ||| (that: => Parser[T]) = new Parser[T]{
      def apply(sw: Subword) =
        inner(sw)++that(sw)

      def makeTree = Or(inner.makeTree, that.makeTree)
    }

    /*
     * a 'aggregate' combinator. Takes a function which
     * modifies the list of a parse. Usually used for
     * max or min functions (but can also be a prettyprint)
     */
    def aggregate [U] (h: List[T] => List[U]) = new Parser[U]{
      def apply(sw: Subword) = h(inner(sw))
      def makeTree = Aggregate(h,inner.makeTree)
    }

    /*
     * the 'nonEmpty' combinator. Parses arbitrary number of
     * elements to the left, arbitrary to the right,
     * concatenates the result.
     */
    def ~~~ [U](that: => Parser[U]) = new Parser[(T,U)]{
      def apply(sw: Subword) = {
      //println("In cThenS, Subword is "+sw)
        sw match{
        case (i,j) if i<j =>
        for(
          k <- (i+1 to j-1).toList;
          x <- inner((i,k));
          y <- that((k,j))
        ) yield((x,y))
        case _ => List[(T,U)]()
        }
      }

      def makeTree = Concat(inner.makeTree, that.makeTree)
    }

    /*
     * the 'nonEmpty' to the right combinator
     */
    def ~~+ [U](that: => Parser[U]) = new Parser[(T,U)]{
      def apply(sw: Subword) = {
        sw match{
        case (i,j) if i<j =>
        for(
          k <- (i to j-1).toList;
          x <- inner((i,k));
          y <- that((k,j))
        ) yield((x,y))
        case _ => List[(T,U)]()
        }
      }

      //TODO: maybe change
      def makeTree = Concat(inner.makeTree, that.makeTree)
    }

    /*
     * the cThenS combinator. Parses a single input element
     * to the left, and a String to the right
     */
    def cThenS [U](that: => Parser[U]) = new Parser[(T,U)]{
      def apply(sw: Subword) = {
      //println("In cThenS, Subword is "+sw)
        sw match{
        case (i,j) if i<j =>
        for(
          x <- inner((i,i+1));
          y <- that((i+1,j))
        ) yield((x,y))
        case _ => List[(T,U)]()
        }
      }

      //TODO: maybe change
      def makeTree = Concat(inner.makeTree, that.makeTree)
    }

    def -~~ [U](that: => Parser[U]) = cThenS(that)

    /*
     * the sThenC combinator. Parses a single input element
     * to the right, and a String to the left
     */
    def sThenC [U](that: => Parser[U]) = new Parser[(T,U)]{
      def apply(sw: Subword) = {
        //println("In sThenC, Subword is "+sw)
        sw match{
        case (i,j) if i<j =>
        for(
          x <- inner((i,j-1));
          y <- that((j-1,j))
        ) yield((x,y))
        case _ => List[(T,U)]()
        }
      }

      //TODO: maybe change
      def makeTree = Concat(inner.makeTree, that.makeTree)
    }

    def ~~- [U](that: => Parser[U]) = sThenC(that)

    /*
     * a filter combinator. Yields an empty list if the filter
     * does not pass
     */
    def filter (p: Subword => Boolean) = new Parser[T]{
      def apply(sw: Subword) =
        if(p(sw)) inner(sw) else List[T]()

      def makeTree = Filter(p, inner.makeTree)
    }

    /*
     * tabulation, or memo-ization! Might provide information
     * regarding the table dimensions as a parameter at some point.
     */
    def tabulate = new Parser[T]{
      //for now, the tabulation store is kept inside the parser
      //maybe to be changed and made global at some point of time
      import scala.collection.mutable.HashMap
      val map = new HashMap[Subword, List[T]]

      def apply(sw: Subword) = sw match {
        case (i, j) if(i <= j) => map.getOrElseUpdate(sw, inner(sw))
        case _ => List()
      }

      def makeTree = inner.makeTree
    }

    /**
     * named parser. If the parser has a name its tree will be
     * made only once
     */
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
  }
}

trait LexicalParsersGen extends ADPGen{

  type Input = String

  case class CharT() extends Terminal[Char]

  def char = new Parser[Char]{
    def apply(sw:Subword) = sw match {
      case (i, j) if(j == i+1) => List(input(i))
      case _ => List()
    }
    def makeTree = CharT()
  }

  def charf(f: Char => Boolean) = char filter {
    case(i,j) if(i+1 == j) => f(input(i))
    case _ => false
  }

  def digitParser: Parser[Int] =
    (char filter isDigit) ^^ readDigit

  def readDigit(c: Char) = (c - '0').toInt

  def isDigit(sw: Subword) = sw match{
    case(i,j) if(i+1 == j) => input(i).isDigit
    case _ => false
  }
}

object HelloADPGen extends LexicalParsersGen with BracketsAlgebra{

  def input = "(((3)))(2)"

  def bracketize(c:Char,s:String) = "("+c+","+s+")"

  def areBrackets(sw: Subword) = sw match{
    case(i,j) => input(i) == '(' && input(j-1) == ')'
  }

  val dummyParser = digitParser ||| digitParser
  val myParser: Parser[Int] =
    (digitParser |||
    (char cThenS myParser sThenC char).filter(areBrackets _).^^{ case ((c1,i),c2) => i} |||
    myParser ~~~ myParser ^^ {case (x,y) => x+y}).tabulate.named("myParser")

  def main(args: Array[String]) = {
    println(myParser.makeTree)
  }
}