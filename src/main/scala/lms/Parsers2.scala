package lms.v2

import lms.{MyListOps,MyListOpsExp,ScalaGenMyListOps, MyScalaCompile}
import lms.{MyRangeOps,MyRangeOpsExp,ScalaGenMyRangeOps}
import lms.{ListToGenTransform,ScalaGenGeneratorOps}
import scala.virtualization.lms.common._

trait Signature {
  type Alphabet
  type Answer

  val mAlph: Manifest[Alphabet]
  val mAns : Manifest[Answer]

  //def h(a:Answer, b:Answer):Answer
}

trait Parsers extends ArrayOps with MyListOps with NumericOps with IfThenElse
                 with LiftNumeric with Equal with BooleanOps with OrderingOps
                 with MathOps with MyRangeOps with TupleOps with MiscOps { this: Signature =>

  type Input = Rep[Array[Alphabet]] //DSL related type aliases and info

  abstract class Parser[T:Manifest] extends ((Rep[Int], Rep[Int]) => Rep[List[(T,Int,List[Int])]]){inner =>
    def aggregate(h:(Rep[T],Rep[T])=>Rep[T], z:Rep[T]) = parser_aggregate(inner, h, z)
    def filter (p: (Rep[Int], Rep[Int]) => Rep[Boolean]) = parser_filter(this, p)
    def ^^[U:Manifest](f: Rep[T] => Rep[U]) = parser_map(this, f)
    def |(that: => Parser[T]) = parser_or(inner, that)

    // Concatenation XXX: rework + add yield analysis
    private def concat[U:Manifest](lL:Rep[Int], lU:Rep[Int], rL:Rep[Int], rU:Rep[Int])(that: => Parser[U]) = parser_concat(inner, lL,lU,rL,rU, that)
    def ~ [U:Manifest](that: => Parser[U]) = concat(0,-1,0,-1)(that) // 0 to infinity on each side, !WARNING, this might generate inifite loops without yield analysis
    def ~~[U:Manifest](lL:Rep[Int], lU:Rep[Int], rL:Rep[Int], rU:Rep[Int])(that: => Parser[U]) = concat(lL,lU,rL,rU)(that)
    def +~+ [U:Manifest](that: => Parser[U]) = concat(1,-1,1,-1)(that) // XXX: legacy to get rid of
  }

  def parser_aggregate[T:Manifest](inner: Parser[T], h:(Rep[T],Rep[T])=>Rep[T], z:Rep[T]) : Parser[T]
  def parser_filter[T:Manifest](inner: Parser[T], p: (Rep[Int], Rep[Int]) => Rep[Boolean]) : Parser[T]
  def parser_map[T:Manifest, U:Manifest](inner: Parser[T], f: Rep[T] => Rep[U]) : Parser[U]
  def parser_or[T:Manifest](inner: Parser[T], that: Parser[T]): Parser[T]
  def parser_concat[T:Manifest, U:Manifest](inner: Parser[T], lL:Rep[Int], lU:Rep[Int], rL:Rep[Int], rU:Rep[Int], that: Parser[U]): Parser[(T,U)]
  def tabulate(name:String, inner: =>Parser[Answer]) : Parser[Answer]

  /*************** terminals below *****************/
  def el(in: Input)(implicit mAlph: Manifest[Alphabet]) = new Parser[Alphabet] {
    def apply(i:Rep[Int], j:Rep[Int]) = if(i+1==j) List((in(i),unit(0),List[Int]())) else List[(Alphabet,Int,List[Int])]()
  }
  def eli(in: Input) = new Parser[Int] {
    def apply(i: Rep[Int], j : Rep[Int]) = if(i+1==j) List((i,unit(0),List[Int]())) else List[(Int,Int,List[Int])]()
  }
}

trait LexicalParsers extends Parsers {this: Signature =>
  type Alphabet = Char
  val mAlph = manifest[Char]

  def char(in: Input) = el(in)
  def charf(in: Input, c:Rep[Char]) = char(in) filter {(i:Rep[Int], j:Rep[Int]) => (i + 1 == j) && in(i) == c }
}

trait ParsersExp extends Parsers with ArrayOpsExp with MyListOpsExp with LiftNumeric
    with NumericOpsExp with IfThenElseExp with EqualExp with BooleanOpsExp
    with OrderingOpsExp with MathOpsExp with MyRangeOpsExp
    with TupleOpsExp with ListToGenTransform{this: Signature =>

  def parser_filter[T:Manifest](inner: Parser[T], p: (Rep[Int], Rep[Int]) => Rep[Boolean]) :  Parser[T] = FilterParser(inner,p)
  def parser_map[T:Manifest, U:Manifest](inner: Parser[T], f: Rep[T] => Rep[U]) : Parser[U] = MapParser(inner,f)
  def parser_or[T:Manifest](inner: Parser[T], that: Parser[T]): Parser[T] = OrParser(inner, that)
  def parser_aggregate[T:Manifest](inner: Parser[T], h:(Rep[T],Rep[T])=>Rep[T], z:Rep[T]) : Parser[T] = AggregateParser(inner,h,z)
  def parser_concat[T:Manifest, U:Manifest](inner: Parser[T], lL:Rep[Int], lU:Rep[Int], rL:Rep[Int], rU:Rep[Int],
                                            that: Parser[U]): Parser[(T,U)] = ConcatParser(inner, lL,lU,rL,rU, that)
  def tabulate(name:String, inner: =>Parser[Answer]) = new TabulatedParser(name, inner)(mAns)

  // Memoization through tabulation
  import scala.collection.mutable.HashSet
  val productions = new HashSet[String]

  /*** case classes for matching on Parsers */
  case class FilterParser[T:Manifest](inner: Parser[T], p: (Rep[Int], Rep[Int]) => Rep[Boolean]) extends Parser[T] {
    def apply(i: Rep[Int], j: Rep[Int]) = if(p(i,j)) inner(i,j) else List[(T,Int,List[Int])]()
  }

  case class MapParser[T:Manifest, U:Manifest](inner: Parser[T], f: Rep[T] => Rep[U]) extends Parser[U] {
    def apply(i: Rep[Int], j: Rep[Int]) = inner(i,j) map {x => (f(x._1),x._2,x._3)}
  }

  case class OrParser[T:Manifest](inner: Parser[T], that: Parser[T]) extends Parser[T] {
    def apply(i: Rep[Int], j: Rep[Int]) = inner(i,j) ++ that(i,j)
  }

  case class AggregateParser[T:Manifest, U:Manifest](inner: Parser[T], h:(Rep[T],Rep[T])=>Rep[T], z:Rep[T]) extends Parser[T] {
    def apply(i: Rep[Int], j: Rep[Int]) = {
      val zero:Rep[(T,Int,List[Int])] = (z,unit(-1),List[Int]())
      val res = list_fold(inner(i,j), zero, (x:Rep[(T,Int,List[Int])], y:Rep[(T,Int,List[Int])]) => if (x._2==unit(-1) || y._1==h(x._1,y._1)) y else x)
      if (res._2!=unit(-1)) List(res) else List()
    }
    //list_reduce(inner(i,j),h,z)
    // { val tmp=inner(i,j); if (tmp.isEmpty) List() else List(list_fold(tmp.tail,tmp.head,h)) }
  }

  case class ConcatParser[T:Manifest, U:Manifest](inner: Parser[T], lL:Rep[Int], lU:Rep[Int], rL:Rep[Int], rU:Rep[Int], that: Parser[U])
      (implicit mRes:Manifest[List[((T,U),Int,List[Int])]]) extends Parser[(T,U)]{
    def apply(i: Rep[Int], j: Rep[Int]) = if(i < j) {
      val min_k = if (rU== -1) i+lL else Math.max(i+lL,j-rU)
      val max_k = if (lU== -1) j-rL else Math.min(j-rL,i+lU)
      for(
        k <- (min_k until max_k+1).toList;
        x <- inner(i,k);
        y <- that(k,j)
      ) yield { val a:Rep[(T,U)]=(x._1,y._1); (a, x._2 /* *unit(XX)+y._2 */, x._3 /* ::: k :: y._2 */ ) } // XXX: fix this
      // for(k <- (min_k until max_k+1).toList) yield((inner(i,k).head,that()(k,j).head)) + WARNING: test emptynesss of x,y
    } else List[((T,U),Int,List[Int])]()
  }

  // Call init(n) before usage and clear to free memory, use get to retrieve final value
  class TabulatedParser(name:String, inner: =>Parser[Answer])(implicit val mAns: Manifest[Answer]) extends Parser[Answer] {
    private var sz:Rep[Int] = unit(0)
    private var mem:Rep[Int] = unit(0)
    private var tab :Rep[Array[(Answer,Int,List[Int])]] = unit(null) //NewArray[(Answer,Int,List[Int])](1)
    private def idx(i:Rep[Int],j:Rep[Int]) = { val d=sz+2+i-j; mem - (d*(d-1))/2 + i; }
    def init(size:Rep[Int]) { sz=size; mem=(sz+1)*(sz+2)/2; tab=NewArray[(Answer,Int,List[Int])](mem)} // XXX: make recursive
    def clear = { sz=unit(0); tab= unit(null)} // XXX: make recursive
    def get:Rep[(Answer,Int,List[Int])] = tab(idx(0,sz)) // XXX: useful?

    def apply(i: Rep[Int], j: Rep[Int]) = {
      if(!(productions contains(name))) {
        productions += name
        // --- STAGED
        val tmp = inner(i,j)
        //if (!tmp.isEmpty) { tab(idx(i,j)) = tmp.head }
        transform(tmp).apply{x:Rep[(Answer,Int,List[Int])] => tab(idx(i,j))=x}
        // --- STAGED
        productions -= name
      }
      val e = tab(idx(i,j))
      // Since we build bottom-up, null means 'already processed and with no result'
      // NOTE: A null would be encoded in C with uninitialized value and rule_id = -1
      if (e==null.asInstanceOf[(Answer,Int,List[Int])]) List[(Answer,Int,List[Int])]() else List(e)
    }
  }

  // Bottom-up scheduling (from bottomUp2)
  def bottomUp(in:Input, p: =>TabulatedParser)(implicit mAlph: Manifest[Alphabet], mA: Manifest[Answer]) : Rep[(Answer,Int,List[Int])] = {
    //
    // XXX: convert here into generators recursively ?
    //
    // XXX: make sure this loop is fine
        val n = in.length; p.init(n)
    (1 until n+1).foreach{l =>
      (0 until n+1 -l).foreach{i =>
        val j = i+l
        p(i,j);
        ();
      }
    }
    val r = p.get
    // XXX: retrieve backtrack
    p.clear
    r // and backtrack
  }
}

// A package to simplify mixing all the traits
trait ParsersPkg extends ParsersExp with Signature with MiscOpsExp with ListToGenTransform with IfThenElseExp with MyScalaCompile { self =>
    val codegen = new ScalaGenArrayOps with ScalaGenMyListOps with ScalaGenNumericOps with ScalaGenIfThenElse with ScalaGenBooleanOps
      with ScalaGenEqual with ScalaGenOrderingOps with ScalaGenMathOps with ScalaGenMyRangeOps with ScalaGenTupleOps
      with ScalaGenMiscOps with ScalaGenGeneratorOps{ val IR: self.type = self }
}

// ------------------------------------------------------------------------------

// Matrix multiplication algebra
trait MatMultAlgebra extends Parsers with Signature {
  type Alphabet = (Int,Int)
  type Answer = (Int, Int, Int)

  val mAlph = manifest[Alphabet]
  val mAns = manifest[Answer]

  def single(i:Rep[(Int,Int)]) = (i._1, unit(0), i._2)
  def mult(l:Rep[Answer], r:Rep[Answer]) = (l._1, l._2+r._2+l._1*l._3*r._3, r._3)
}

object MatMutlTest extends App {
  new MatMultAlgebra with ParsersPkg {
    def h(x:Rep[Answer],y:Rep[Answer]) = if(x._2 < y._2) x else y
    val z = unit((-1,-1,-1))

    // Matrix multiplication grammar
    def grammar(in:Input):Rep[(Answer,Int,List[Int])] = {
      lazy val p:TabulatedParser = tabulate("mat",(
          el(in) ^^ single
        | (p +~+ p) ^^ {x: Rep[(Answer,Answer)] => mult(x._1,x._2)}
      ).aggregate(h,z))

      bottomUp(in,p)(mAlph, mAns)
    }
    /*def grammar(in:Input): Rep[(Answer, Int, List[Int])] = {
      val a = NewArray[(Answer, Int, List[Int])](1)
      a(unit(0)) = (unit((1,1,1)), unit(1), List(1))
      a(unit(0))
    }
    */

    // Now we compile and execute our program
    codegen.emitSource(grammar _, "test-bottomup4", new java.io.PrintWriter(System.out))
    val prog = compile(grammar)
    val res = prog(scala.Array((10,100),(100,5),(5,50)))
    scala.Console.println(res._1)
  }
}