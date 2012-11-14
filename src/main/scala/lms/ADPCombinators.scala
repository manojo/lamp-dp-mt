package lms

import scala.virtualization.lms.common._

// -----------------------------------------------------------------------------
// Concepts and concrete syntax

trait Signature {
  type Answer
  type Alphabet
  def h(l: List[Answer]) : List[Answer]
}

trait ADPParsers extends Base {
  type Subword = (Int, Int)
  type Input // = String

  // The input is a "global" value, as in DP we need it
  // during the whole running time of the algorithm.
  def input: Input

  //def parseAll[T](p: Parser[T], in: Input, sw: Subword) =

  // Mapper, Equivalent of ADP's <<< operator.
  // To separate left and right hand side of a grammar rule
  def infix_^^[T:Manifest,U:Manifest](p:Rep[Parser[T]], f: T => U) = parser_map(p,f)

  // Or combinator. Equivalent of ADP's ||| operator.
  // In ADP semantics we concatenate the results of the parse of
  // 'this' with the parse of 'that'
  def infix_|[T:Manifest](p1:Rep[Parser[T]], p2: => Rep[Parser[T]]) = parser_or(p1,p2)

  // Concatenate combinators.
  // Parses a concatenation of string left~right with length(left) in leftR=[leftL,leftU]
  // and length(right) in rightR=[rightL,rightU], leftU,rightU=0 means unbounded (infinity).
  def infix_~~  [T:Manifest,U:Manifest](p1:Rep[Parser[T]], leftR:(Int,Int), rightR:(Int,Int), p2: => Rep[Parser[U]]) = parser_concat(p1, (leftR._1,leftR._2,rightR._1,rightR._2), p2)
  def infix_~~~ [T:Manifest,U:Manifest](p1:Rep[Parser[T]], p2: => Rep[Parser[U]]) = parser_concat(p1, (0,0,0,0), p2)
  def infix_~~+ [T:Manifest,U:Manifest](p1:Rep[Parser[T]], p2: => Rep[Parser[U]]) = parser_concat(p1, (0,0,1,0), p2)
  def infix_+~~ [T:Manifest,U:Manifest](p1:Rep[Parser[T]], p2: => Rep[Parser[U]]) = parser_concat(p1, (1,0,0,0), p2)
  def infix_+~+ [T:Manifest,U:Manifest](p1:Rep[Parser[T]], p2: => Rep[Parser[U]]) = parser_concat(p1, (1,0,1,0), p2)
  def infix_*~~ [T:Manifest,U:Manifest](p1:Rep[Parser[T]], leftL:Int, rightR:(Int,Int), p2: => Rep[Parser[U]]) = parser_concat(p1, (leftL,0,rightR._1,rightR._2), p2)
  def infix_~~* [T:Manifest,U:Manifest](p1:Rep[Parser[T]], leftR:(Int,Int), rightL:Int, p2: => Rep[Parser[U]]) = parser_concat(p1, (leftR._1,leftR._2,rightL,0), p2)
  def infix_*~* [T:Manifest,U:Manifest](p1:Rep[Parser[T]], leftL:Int, rightL:Int, p2: => Rep[Parser[U]]) = parser_concat(p1, (leftL,0,rightL,0), p2)
  def infix_-~~ [T:Manifest,U:Manifest](p1:Rep[Parser[T]], p2: => Rep[Parser[U]]) = parser_concat(p1, (1,1,0,0), p2)
  def infix_~~- [T:Manifest,U:Manifest](p1:Rep[Parser[T]], p2: => Rep[Parser[U]]) = parser_concat(p1, (0,0,1,1), p2)

  // Aggregate combinator.
  // Takes a function which modifies the list of a parse. Usually used
  // for max or min functions (but can also be a prettyprint).
  def infix_aggregate[T:Manifest,U:Manifest](p:Rep[Parser[T]], h: List[T] => List[U]) = parser_aggregate(p,h)

  // Filter combinator.
  // Yields an empty list if the filter does not pass.
  def infix_filter[T:Manifest](p:Rep[Parser[T]], pred: Subword => Boolean) = parser_filter(p,pred)

  // Tabulation (or memoization).
  // Might provide information regarding the table dimensions
  // as a parameter at some point.
  def infix_tabulate[T:Manifest](p:Rep[Parser[T]]) = parser_tabulate(p)

  abstract class Parser[T] extends (Subword => List[T]) { inner =>
    def apply(sw: Subword): List[T]
  }

  // Concrete syntax
  def parser_map[T:Manifest,U:Manifest](p:Rep[Parser[T]], f: T => U) : Rep[Parser[U]]
  def parser_or[T:Manifest](p1:Rep[Parser[T]], p2: => Rep[Parser[T]]) : Rep[Parser[T]]
  def parser_concat[T:Manifest,U:Manifest](p1:Rep[Parser[T]], bounds:(Int,Int,Int,Int), p2: => Rep[Parser[U]]) : Rep[Parser[(T,U)]]
  def parser_aggregate[T:Manifest,U:Manifest](p:Rep[Parser[T]], h: List[T] => List[U]) : Rep[Parser[U]]
  def parser_filter[T:Manifest](p:Rep[Parser[T]], pred: Subword => Boolean) : Rep[Parser[T]]
  def parser_tabulate[T:Manifest](p:Rep[Parser[T]]) : Rep[Parser[T]]
}

trait LexicalParsers extends ADPParsers {
  override type Input = String
  def char: Rep[Parser[Char]]
  def charf(f: Char => Boolean): Rep[Parser[Char]]
  def digitParser: Rep[Parser[Int]]

  def readDigit(c: Char) = (c - '0').toInt
  def isDigit(sw: Subword) = sw match {
    case(i,j) if (i+1==j) => input(i).isDigit
    case _ => false
  }
}

// -----------------------------------------------------------------------------
// Intermediate representation

trait ADPParsersExp extends ADPParsers with BaseExp {
  case class ADP_Map[T,U](p:Exp[Parser[T]], f: T => U) extends Def[Parser[U]]
  case class ADP_Or[T](p1:Exp[Parser[T]], p2:Exp[Parser[T]]) extends Def[Parser[T]]
  case class ADP_CCat[T,U](p1:Exp[Parser[T]], bounds:(Int,Int,Int,Int), p2: Exp[Parser[U]]) extends Def[Parser[(T,U)]]
  case class ADP_Agg[T,U](p:Exp[Parser[T]], h: List[T] => List[U]) extends Def[Parser[U]]
  case class ADP_Filter[T](p:Exp[Parser[T]], pred: Subword => Boolean) extends Def[Parser[T]]
  case class ADP_Tab[T](p:Exp[Parser[T]]) extends Def[Parser[T]]

  override def parser_map[T:Manifest,U:Manifest](p:Exp[Parser[T]], f: T => U) = ADP_Map(p,f)
  override def parser_or[T:Manifest](p1:Exp[Parser[T]], p2: => Exp[Parser[T]]) = ADP_Or(p1,p2)
  override def parser_concat[T:Manifest,U:Manifest](p1:Exp[Parser[T]], bounds:(Int,Int,Int,Int), p2: => Exp[Parser[U]]) = ADP_CCat(p1,bounds,p2)
  override def parser_aggregate[T:Manifest,U:Manifest](p:Exp[Parser[T]], h: List[T] => List[U]) = ADP_Agg(p,h)
  override def parser_filter[T:Manifest](p:Exp[Parser[T]], pred: Subword => Boolean) = ADP_Filter(p, pred)
  override def parser_tabulate[T:Manifest](p:Exp[Parser[T]]) = ADP_Tab(p)
}

trait LexicalParsersExp extends LexicalParsers with ADPParsersExp {
  case object Lex_Char extends Def[Parser[Char]]
  case class Lex_Charf(f: Char => Boolean) extends Def[Parser[Char]]
  case object Lex_DigitParser extends Def[Parser[Int]]

  override def char = Lex_Char
  override def charf(f: Char => Boolean) = Lex_Charf(f)
  override def digitParser = Lex_DigitParser
}

// -----------------------------------------------------------------------------
// Optimization
// trait ADPParsersOpt extends ADPParsersExp { this: BaseExp => }
// trait LexicalParsersOpt extends LexicalParsersExp with ADPParsersOpt { this: BaseExp => }

// -----------------------------------------------------------------------------
// Code generation

trait ScalaGenADPParsers extends ScalaGenBase {
  val IR: BaseExp with ADPParsersExp
  import IR._

  override def emitNode(sym: Sym[Any], node: Def[Any]): Unit = node match {
    case ADP_Map(p, f) =>
      emitValDef(sym, "new Parser[U] { def apply(sw:Subword) = "+quote(p)+"(sw) map f }")
    case ADP_Or(p1,p2) =>
      emitValDef(sym, "new Parser[T] { def apply(sw: Subword) = "+quote(p1)+"(sw)++"+quote(p2)+"(sw) }")

    case ADP_CCat(inner,(lL,lU,rL,rU),that) =>
      // XXX: treat specific cases at compile time for indices
      emitValDef(sym, """new Parser[T,U] {
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
        }}""")
    case ADP_Agg(p,h) =>
      emitValDef(sym, "new Parser[T,U] { def apply(sw: Subword) = h("+quote(p)+"(sw)) }")
    case ADP_Filter(p, pred) =>
      emitValDef(sym, "new Parser[T] { def apply(sw: Subword) = if(pred(sw)) "+quote(p)+"(sw) else List[T]() }")
    case ADP_Tab(p) =>
      emitValDef(sym, """new Parser[T] {
        //for now, the tabulation store is kept inside the parser
        //maybe to be changed and made global at some point of time
        val map = new scala.collection.mutable.HashMap[Subword, List[T]]
        def apply(sw: Subword) = sw match {
          case (i, j) if(i <= j) => map.getOrElseUpdate(sw, """+quote(p)+"""(sw))
          case _ => List()
        }}""")

    case _ => super.emitNode(sym, node)
  }
}

trait ScalaGenLexicalParsers extends ScalaGenADPParsers {
  val IR: BaseExp with LexicalParsersExp
  import IR._

  override def emitNode(sym: Sym[Any], node: Def[Any]): Unit = node match {
    case Lex_Char =>
      emitValDef(sym, """new Parser[Char] {
        def apply(sw:Subword) = sw match {
          case (i, j) if(j == i+1) => List(input(i))
          case _ => List()
        }}""")
    case Lex_Charf(f) => emitValDef(sym, """char filter {
          case(i,j) if(i+1 == j) => f(input(i))
          case _ => false
        }""")
    case Lex_DigitParser => emitValDef(sym, "(char filter isDigit) ^^ readDigit")
    case _ => super.emitNode(sym, node)
  }
}

// -----------------------------------------------------------------------------
// Interpreters
trait Interpreter extends ADPParsers {
  override type Rep[+A] = A
  override def unit[A : Manifest](a: A) = a

  override def parser_map[T:Manifest,U:Manifest](inner:Parser[T], f: T => U) = new Parser[U] {
    def apply(sw:Subword) = inner(sw) map f
  }
  override def parser_or[T:Manifest](inner:Parser[T],that: => Parser[T]): Parser[T] = new Parser[T] {
    def apply(sw: Subword) = inner(sw)++that(sw)
  }
  override def parser_concat[T:Manifest,U:Manifest](inner:Parser[T], bounds:(Int,Int,Int,Int), that: => Parser[U]) = new Parser[(T,U)] {
    def apply(sw: Subword) = (sw,bounds) match {
      case ((i,j),(lL,lU,rL,rU)) if i<j =>
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

  override def parser_aggregate[T:Manifest,U:Manifest](inner:Parser[T], h: List[T] => List[U]) = new Parser[U] {
    def apply(sw: Subword) = h(inner(sw))
  }
  override def parser_filter[T:Manifest](inner:Parser[T], p: Subword => Boolean) = new Parser[T] {
    def apply(sw: Subword) = if(p(sw)) inner(sw) else List[T]()
  }
  override def parser_tabulate[T:Manifest](inner:Parser[T]) = new Parser[T]{
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

trait LexicalInterpreter extends Interpreter with LexicalParsers {
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

trait Prog extends LexicalParsers with BracketsAlgebra {
  def input = "(((3)))(2)"
  def bracketize(c:Char,s:String) = "("+c+","+s+")"

  def areBrackets(sw: Subword) = sw match {
    case(i,j) => input(i) == '(' && input(j-1) == ')'
  }

  //val dummyParser = digitParser | digitParser

// XXX: this does not work for the moment
/*
  val myParser: Rep[Parser[Int]] = (
    digitParser
  | (char -~~ myParser ~~- char).filter(areBrackets _) ^^ { case (c1,(i,c2)) => i }
  | myParser +~+ myParser ^^ {case (x,y) => x+y}
  ) tabulate
*/

  //def f0(x:(Char,(Int,Char))) = x._2._1
  //def f1(x:(Int,Int)) = x._1+x._2

 /* val myParser: Rep[Parser[Int]] = (
    digitParser |
    ((char -~~ myParser ~~- char) filter (areBrackets _)) ^^ {x: (Char,(Int,Char)) => x._2._1} |
    myParser +~+ myParser ^^ {x: (Int,Int) => x._1 + x._2}
  ) tabulate*/

  val dummyParser = digitParser
}

object ADPTest extends App {

/*  val concreteProg = new Prog with EffectExp with ADPParsersExp with LexicalParsersExp with CompileScala { self =>
    override val codegen = new ScalaGenEffect with ScalaGenADPParsers with ScalaGenLexicalParsers { val IR: self.type=self }
    codegen.emitSource(dummyParser,new java.io.PrintWriter(System.out))
  }
*/
  val interpretedProg = new Prog with LexicalInterpreter
  println(interpretedProg.dummyParser((0,interpretedProg.input.length)))
}
