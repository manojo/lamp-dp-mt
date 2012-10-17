package vanilla

trait Signature{
  type Answer
  type Alphabet

  def h(l: List[Answer]) : List[Answer]
}

trait ADPParsers {

  type Subword= (Int, Int)
  type Input// = String

  /*
   * the input is a "global" value, as in DP we need
   * the it during the whole running time of the algorithm
   */
  def input: Input

  //def parseAll[T](p: Parser[T], in: Input, sw: Subword) = 

  abstract class Parser[T] extends (Subword => List[T]){ inner =>
    def apply(sw: Subword): List[T]

    /**
     * mappers delight!!! equivalent to ADP's <<<
     */
    def map[U](f: T => U) = new Parser[U]{
      def apply(sw:Subword) = inner(sw) map f
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
    }

    /*
     * a 'aggregate' combinator. Takes a function which
     * modifies the list of a parse. Usually used for
     * max or min functions (but can also be a prettyprint)
     */
    def aggregate [U] (h: List[T] => List[U]) = new Parser[U]{
      def apply(sw: Subword) = h(inner(sw))
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
    }

    def ~~- [U](that: => Parser[U]) = sThenC(that)    

    /*
     * a filter combinator. Yields an empty list if the filter
     * does not pass
     */
    def filter (p: Subword => Boolean) = new Parser[T]{
      def apply(sw: Subword) = 
        if(p(sw)) inner(sw) else List[T]()
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
    }
  }
}

trait LexicalParsers extends ADPParsers{

  type Input = String

  def char = new Parser[Char]{
    def apply(sw:Subword) = sw match {
      case (i, j) if(j == i+1) => List(input(i))
      case _ => List()
    }
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

trait BracketsSignature extends Signature{
  def readDigit(c: Alphabet) : Answer
  def bracket(l: Alphabet, s: Answer, r: Alphabet) : Answer
  def split(s: Answer, t: Answer): Answer
}

trait BracketsAlgebra extends BracketsSignature{
  type Answer = Int
  type Alphabet = Char

  def bracket(l: Char, s: Int, r: Char) = s
  def split(s: Int, t: Int) = s+t

  def h(l : List[Int]) = if(l.isEmpty) List() else List(l.max)
}

object HelloADP extends LexicalParsers with BracketsAlgebra{

  def input = "(((3)))(2)"

  def bracketize(c:Char,s:String) = "("+c+","+s+")"

  def areBrackets(sw: Subword) = sw match{
    case(i,j) => input(i) == '(' && input(j-1) == ')'
  }
  


  val dummyParser = digitParser ||| digitParser
  val myParser: Parser[Int] = 
    (digitParser |||
    (char cThenS myParser sThenC char).filter(areBrackets _).^^{ case ((c1,i),c2) => i} |||
    myParser ~~~ myParser ^^ {case (x,y) => x+y}).tabulate

  def main(args: Array[String]) = {
    println(myParser(0,input.length))
  }
}