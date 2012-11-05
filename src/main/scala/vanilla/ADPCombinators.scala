package vanilla

trait Signature {
  type Answer
  type Alphabet

  def h(l: List[Answer]) : List[Answer]
}

trait ADPParsers {
  type Subword = (Int, Int)
  type Input // = String


  /**
   * tree structure which can be used for generating
   * recurrences
   */
  abstract class PTree[+T]
  case class Aggregate[T,U](h: List[T] => List[U], p: PTree[T]) extends PTree[U]
  case class Or[T](l: PTree[T], r: PTree[T]) extends PTree[T]
  case class Map[T,U](f: T => U, p: PTree[T]) extends PTree[U]

  //type info more to "please" the type system than any deeper meaning
  case class Concat[T,U](l: PTree[T], r: PTree[U], indices: (Int,Int,Int,Int)) extends PTree[(T,U)]
  case class Filter[T](f: Subword => Boolean, p: PTree[T]) extends PTree[T]
  case class Production[T](name:String) extends PTree[T]

  abstract class Terminal[T] extends PTree[T]


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

  abstract class Parser[T] extends (Subword => List[T]) { inner =>
    def apply(sw: Subword): List[T]
    def makeTree : PTree[T]

    /*
     * Mapper.
     * Equivalent of ADP's <<< operator.
     * To separate left and right hand side of a grammar rule
     */
    def map[U](f: T => U) = new Parser[U]{
      def apply(sw:Subword) = inner(sw) map f
      def makeTree = Map(f,inner.makeTree)
    }

    def ^^[U](f: T => U) = this.map(f)

    /*
     * Or combinator.
     * Equivalent of ADP's ||| operator.
     * In ADP semantics we concatenate the results of the parse
     * of 'this' with the parse of 'that'
     */
    def or (that: => Parser[T]) = new Parser[T]{
      def apply(sw: Subword) = inner(sw)++that(sw)
      def makeTree = Or(inner.makeTree, that.makeTree)
    }

    def |(that: => Parser[T]) = or(that)

    /*
     * Aggregate combinator.
     * Takes a function which modifies the list of a parse. Usually used
     * for max or min functions (but can also be a prettyprint).
     */
    def aggregate [U] (h: List[T] => List[U]) = new Parser[U]{
      def apply(sw: Subword) = h(inner(sw))
      def makeTree = Aggregate(h,inner.makeTree)
    }

    /*
     * Concatenate combinator.
     * Parses a concatenation of string left~right with length(left) in [lL,lU]
     * and length(right) in [rL,rU], lU,rU=0 means unbounded (infinity).
     */
    def concat[U](lL:Int, lU:Int, rL:Int, rU:Int)(that: => Parser[U]) = new Parser[(T,U)] {
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
      def makeTree = Concat(inner.makeTree, that.makeTree, (lL,lU,rL,rU))
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

    /*
     * Filter combinator.
     * Yields an empty list if the filter does not pass.
     */
    def filter (p: Subword => Boolean) = new Parser[T]{
      def apply(sw: Subword) = if(p(sw)) inner(sw) else List[T]()
      def makeTree = Filter(p, inner.makeTree)
    }

    /*
     * Tabulation (or memoization).
     * Might provide information regarding the table dimensions
     * as a parameter at some point.
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

trait LexicalParsers extends ADPParsers {
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

  def digitParser: Parser[Int] = (char filter isDigit) ^^ readDigit

  def readDigit(c: Char) = (c - '0').toInt

  def isDigit(sw: Subword) = sw match{
    case(i,j) if(i+1 == j) => input(i).isDigit
    case _ => false
  }
}

trait Gen extends ADPParsers {

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

  def gen[T](p: Parser[T]): String = gen(p.makeTree)
}

/*** Example ***/

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

  def areBrackets(sw: Subword) = sw match {
    case(i,j) => input(i) == '(' && input(j-1) == ')'
  }

  val dummyParser = digitParser | digitParser
  val myParser: Parser[Int] = (
      digitParser
    | (char -~~ myParser ~~- char).filter(areBrackets _).^^{ case (c1,(i,c2)) => i}
    | myParser +~+ myParser ^^ {case (x,y) => x+y}
  ).tabulate

  def main(args: Array[String]) = {
    println(myParser(0,input.length))
  }
}

/*
XXX: are we sure that the order of the operators are correct ?
> infixr 6 |||
> infix  8 <<<
> infixl 7 ~~~
> infix  5 ...
> infix  8 ><<
> infixl 7 ~~, ~~*, *~~, *~*
> infixl 7 -~~, ~~-, +~~, ~~+, +~+

XXX: do we need ><<, special case of <<< for a nullary function f
> (><<)           :: c -> Parser b -> Parser c
> (><<) f q (i,j) =  [f|a <- (q (i,j))]
*/
/** Superseded by concat */
    /*
     * the cThenS combinator. Parses a single input element
     * to the left, and a String to the right
     */
     /*
    def cThenS [U](that: => Parser[U]) = new Parser[(T,U)]{
      def apply(sw: Subword) = sw match {
        case (i,j) if i<j =>
          for(
            x <- inner((i,i+1));
            y <- that((i+1,j))
          ) yield((x,y))
        case _ => List[(T,U)]()
      }
    }

    def -~~ [U](that: => Parser[U]) = cThenS(that)
*/
    /*
     * the sThenC combinator. Parses a single input element
     * to the right, and a String to the left
     */
     /*
    def sThenC [U](that: => Parser[U]) = new Parser[(T,U)]{
      def apply(sw: Subword) = sw match {
        case (i,j) if i<j =>
          for(
            x <- inner((i,j-1));
            y <- that((j-1,j))
          ) yield((x,y))
        case _ => List[(T,U)]()
      }
    }

    def ~~- [U](that: => Parser[U]) = sThenC(that)
*/
