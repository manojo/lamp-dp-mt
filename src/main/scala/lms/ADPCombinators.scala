package lms

import scala.virtualization.lms.common._

// -----------------------------------------------------------------------------
// Concepts and concrete syntax

trait Signature {
  type Answer
  type Alphabet
  def h(l: List[Answer]) : List[Answer]
}

trait ADPParsers { this: Base =>
  type Subword = Rep[(Int, Int)]
  type Input // = String

  /*
   * The input is a "global" value, as in DP we need it
   * during the whole running time of the algorithm.
   */
  def input: Input

  //def parseAll[T](p: Parser[T], in: Input, sw: Subword) =

  abstract class Parser[T] extends (Subword => List[T]) { inner =>
    def apply(sw: Subword): List[T]

    // Mapper, Equivalent of ADP's <<< operator.
    // To separate left and right hand side of a grammar rule
    def ^^[U](f: T => U) = parser_map(this,f)

    // Or combinator. Equivalent of ADP's ||| operator.
    // In ADP semantics we concatenate the results of the parse of
    // 'this' with the parse of 'that'
    def |(that: => Parser[T]) = parser_or(this,that)

    // Aggregate combinator.
    // Takes a function which modifies the list of a parse. Usually used
    // for max or min functions (but can also be a prettyprint).
    def aggregate[U](h: List[T] => List[U]) = parser_aggregate(this,h)

    // Concatenate combinators.
    // Parses a concatenation of string left~right with length(left) in [lL,lU]
    // and length(right) in [rL,rU], lU,rU=0 means unbounded (infinity).
    def ~~ [U](lL:Int, lU:Int, rL:Int, rU:Int, that: => Parser[U]) = parser_concat(this, lL,lU,rL,rU, that)
    def ~~ [U](lRange:Pair[Int,Int], rRange:Pair[Int,Int], that: => Parser[U]) = parser_concat(this, lRange._1,lRange._2,rRange._1,rRange._2, that)

    def ~~~ [U](that: => Parser[U]) = ~~(0,0,0,0, that)
    def ~~+ [U](that: => Parser[U]) = ~~(0,0,1,0, that)
    def +~~ [U](that: => Parser[U]) = ~~(1,0,0,0, that)
    def +~+ [U](that: => Parser[U]) = ~~(1,0,1,0, that)

    def *~~ [U](lMin:Int, rRange:Pair[Int,Int], that: => Parser[U]) = ~~(lMin,0,rRange._1,rRange._2, that)
    def ~~* [U](lRange:Pair[Int,Int], rMin:Int, that: => Parser[U]) = ~~(lRange._1,lRange._2,rMin,0, that)
    def *~* [U](lMin:Int, rMin:Int, that: => Parser[U]) = ~~(lMin,0,rMin,0, that)

    def -~~ [U](that: => Parser[U]) = ~~(1,1,0,0, that)
    def ~~- [U](that: => Parser[U]) = ~~(0,0,1,1, that)

    // Filter combinator.
    // Yields an empty list if the filter does not pass.
    def filter (p: Subword => Boolean) = parser_filter(this,p)

    // Tabulation (or memoization).
    // Might provide information regarding the table dimensions
    // as a parameter at some point.
    def tabulate = parser_tabulate(this)
  }

  // Concrete syntax
  // XXX: we need to process over Rep[Parser[]] and keep manifest ??!
  def parser_map[T,U](inner:Parser[T], f: T => U): Parser[U]
  def parser_or[T](inner:Parser[T], that: => Parser[T]): Parser[T]
  def parser_aggregate[T,U](inner:Parser[T], h: List[T] => List[U]): Parser[U]
  def parser_concat[T,U](inner:Parser[T], lL:Int, lU:Int, rL:Int, rU:Int, that: => Parser[U]) : Parser[(T,U)]
  def parser_filter[T](inner:Parser[T], p: Subword => Boolean): Parser[T]
  def parser_tabulate[T](inner:Parser[T]):Parser[T]
}

// -----------------------------------------------------------------------------
// Interpreter
trait Interpreter extends ADPParsers { this: Base =>
  override type Rep[+A] = A
  override def unit[A : Manifest](a: A) = a

  override def parser_map[T,U](inner:Parser[T], f: T => U) = new Parser[U] {
    def apply(sw:Subword) = inner(sw) map f
  }
  override def parser_or[T](inner:Parser[T],that: => Parser[T]): Parser[T] = new Parser[T] {
    def apply(sw: Subword) = inner(sw)++that(sw)
  }
  override def parser_aggregate[T,U](inner:Parser[T], h: List[T] => List[U]) = new Parser[U] {
    def apply(sw: Subword) = h(inner(sw))
  }
  override def parser_concat[T,U](inner:Parser[T], lL:Int, lU:Int, rL:Int, rU:Int, that: => Parser[U]) = new Parser[(T,U)] {
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
  }

  override def parser_filter[T](inner:Parser[T], p: Subword => Boolean) = new Parser[T] {
    def apply(sw: Subword) = if(p(sw)) inner(sw) else List[T]()
  }
  override def parser_tabulate[T](inner:Parser[T]) = new Parser[T]{
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

// -----------------------------------------------------------------------------

// XXX: why do we have this Interpreter dependency, can we get rid of ?
trait LexicalParsers extends ADPParsers with Interpreter { this: Base =>
  type Input = String
  def char = new Parser[Char] {
    def apply(sw:Subword) = sw match {
      case (i, j) if(j == i+1) => List(input(i))
      case _ => List()
    }
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

// -----------------------------------------------------------------------------
// User program

trait BracketsSignature extends Signature {
  def readDigit(c: Alphabet) : Answer
  def bracket(l: Alphabet, s: Answer, r: Alphabet) : Answer
  def split(s: Answer, t: Answer): Answer
}

trait BracketsAlgebra extends BracketsSignature {
  type Answer = Int
  type Alphabet = Char
  def bracket(l: Char, s: Int, r: Char) = s
  def split(s: Int, t: Int) = s+t
  def h(l : List[Int]) = if(l.isEmpty) List() else List(l.max)
}

trait Prog extends LexicalParsers { this: Base with ADPParsers =>
  // ---------- HelloADP extends LexicalParsers with BracketsAlgebra
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

  def main = println(myParser(0,input.length))
  // ----------
}

object ADPTest extends App {
  val interpretedProg = new Prog with Base with Interpreter

  // XXX: why do we also get an empty list at some point ???
  println(interpretedProg.main)
}
