package lms.v2

import lms.{MyListOps,MyListOpsExp,ScalaGenMyListOps}
import lms.{HackyRangeOps,HackyRangeOpsExp,ScalaGenHackyRangeOps}
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
                 with MathOps with HackyRangeOps with TupleOps with MiscOps { this: Signature =>

  type Input = Rep[Array[Alphabet]] //DSL related type aliases and info

  abstract class Parser[T:Manifest] extends ((Rep[Int], Rep[Int]) => Rep[List[T]]){inner =>
    def aggregate(h:(Rep[T],Rep[T])=>Rep[T]) = parser_aggregate(inner, h)
    def filter (p: (Rep[Int], Rep[Int]) => Rep[Boolean]) = parser_filter(this, p)
    def ^^[U:Manifest](f: Rep[T] => Rep[U]) = parser_map(this, f)
    def |(that: => Parser[T]) = parser_or(inner, that)
    
    // Concatenation XXX: rework + add yield analysis
    private def concat[U:Manifest](lL:Rep[Int], lU:Rep[Int], rL:Rep[Int], rU:Rep[Int])(that: => Parser[U]) = parser_concat(inner, lL,lU,rL,rU, that)
    def ~ [U:Manifest](that: => Parser[U]) = concat(0,-1,0,-1)(that) // 0 to infinity on each side, !WARNING, this might generate inifite loops without yield analysis
    def ~~[U:Manifest](lL:Rep[Int], lU:Rep[Int], rL:Rep[Int], rU:Rep[Int])(that: => Parser[U]) = concat(lL,lU,rL,rU)(that)
    def +~+ [U:Manifest](that: => Parser[U]) = concat(1,-1,1,-1)(that) // XXX: legacy to get rid of
  }

  def parser_aggregate[T:Manifest](inner: Parser[T], h:(Rep[T],Rep[T])=>Rep[T]) : Parser[T]
  def parser_filter[T:Manifest](inner: Parser[T], p: (Rep[Int], Rep[Int]) => Rep[Boolean]) : Parser[T]
  def parser_map[T:Manifest, U:Manifest](inner: Parser[T], f: Rep[T] => Rep[U]) : Parser[U]
  def parser_or[T:Manifest](inner: Parser[T], that: Parser[T]): Parser[T]
  def parser_concat[T:Manifest, U:Manifest](inner: Parser[T], lL:Rep[Int], lU:Rep[Int], rL:Rep[Int], rU:Rep[Int], that: Parser[U]): Parser[(T,U)]
  def tabulate(name:String, inner: =>Parser[Answer], mat: Rep[Array[Answer]], z: Rep[Answer], n:Rep[Int]) : Parser[Answer] // XXX: mat,z must go away
  
  /*************** terminals below *****************/
  def el(in: Input)(implicit mAlph: Manifest[Alphabet]) = new Parser[Alphabet] {
    def apply(i:Rep[Int], j:Rep[Int]) = if(i+1==j) List(in(i)) else List()
  }

  def eli(in: Input) = new Parser[Int] {
    def apply(i: Rep[Int], j : Rep[Int]) = if(i+1==j) List(i) else List()
  }
}

trait LexicalParsers extends Parsers {this: Signature =>
  type Alphabet = Char
  val mAlph = manifest[Char]

  def char(in: Input) = new Parser[Char] {
    def apply(i: Rep[Int], j: Rep[Int]) = if(i+1==j) List(in(i)) else List()
  }
  def charf(in: Input, c: Rep[Char]) = char(in) filter {(i:Rep[Int], j:Rep[Int]) => (i + 1 == j) && in(i) == c }
}

trait ParsersExp extends Parsers with ArrayOpsExp with MyListOpsExp with LiftNumeric
    with NumericOpsExp with IfThenElseExp with EqualExp with BooleanOpsExp
    with OrderingOpsExp with MathOpsExp with HackyRangeOpsExp
    with TupleOpsExp with ListToGenTransform{this: Signature =>

  def parser_filter[T:Manifest](inner: Parser[T], p: (Rep[Int], Rep[Int]) => Rep[Boolean]) :  Parser[T] = FilterParser(inner,p)
  def parser_map[T:Manifest, U:Manifest](inner: Parser[T], f: Rep[T] => Rep[U]) : Parser[U] = MapParser(inner,f)
  def parser_or[T:Manifest](inner: Parser[T], that: Parser[T]): Parser[T] = OrParser(inner, that)
  def parser_aggregate[T:Manifest](inner: Parser[T], h:(Rep[T],Rep[T])=>Rep[T]) : Parser[T] = AggregateParser(inner,h)
  def parser_concat[T:Manifest, U:Manifest](inner: Parser[T], lL:Rep[Int], lU:Rep[Int], rL:Rep[Int], rU:Rep[Int],
                                            that: Parser[U]): Parser[(T,U)] = ConcatParser(inner, lL,lU,rL,rU, that)
  def tabulate(name:String, inner: =>Parser[Answer], mat: Rep[Array[Answer]], z: Rep[Answer], n:Rep[Int]) = new TabulatedParser(name, inner, mat, z, n)(mAns)

  // Memoization through tabulation
  import scala.collection.mutable.HashSet
  val productions = new HashSet[String]

  /*** case classes for matching on Parsers */
  case class FilterParser[T:Manifest](inner: Parser[T], p: (Rep[Int], Rep[Int]) => Rep[Boolean]) extends Parser[T] {
    def apply(i: Rep[Int], j: Rep[Int]) = if(p(i,j)) inner(i,j) else List()
  }

  case class MapParser[T:Manifest, U:Manifest](inner: Parser[T], f: Rep[T] => Rep[U]) extends Parser[U] {
    def apply(i: Rep[Int], j: Rep[Int]) = inner(i,j) map f
  }

  case class OrParser[T:Manifest](inner: Parser[T], that: Parser[T]) extends Parser[T] {
    def apply(i: Rep[Int], j: Rep[Int]) = inner(i,j) ++ that(i,j)
  }

  case class AggregateParser[T:Manifest, U:Manifest](inner: Parser[T], h:(Rep[T],Rep[T])=>Rep[T]) extends Parser[T] {
    def apply(i: Rep[Int], j: Rep[Int]) = {
      val tmp=inner(i,j); if (tmp.isEmpty) List() else { List(list_fold(tmp.tail,tmp.head,h)) }
    }
  }

  case class ConcatParser[T:Manifest, U:Manifest](inner: Parser[T], lL:Rep[Int], lU:Rep[Int], rL:Rep[Int], rU:Rep[Int], that: Parser[U]) extends Parser[(T,U)]{
    def apply(i: Rep[Int], j: Rep[Int]) = if(i< j){
      val min_k = if (rU== -1) i+lL else Math.max(i+lL,j-rU)
      val max_k = if (lU== -1) j-rL else Math.min(j-rL,i+lU)
      for(
        k <- (min_k until max_k+1).toList;
        x <- inner(i,k);
        y <- that(k,j)
      ) yield((x,y))
      //for(k <- (min_k until max_k+1).toList) yield((inner(i,k).head,that()(k,j).head)) + WARNING: test emptynesss of x,y
    } else List()
  }

  class TabulatedParser(name:String, inner: =>Parser[Answer], mat: Rep[Array[Answer]], z: Rep[Answer], n:Rep[Int])(implicit val mAns: Manifest[Answer]) extends Parser[Answer] {
  // Upper triangular matrix
    val mem = (n+1)*(n+2)/2;
    def idx(i:Rep[Int],j:Rep[Int]) = { val d=n+2+i-j; mem - (d*(d-1))/2 + i; }

    def apply(i: Rep[Int], j: Rep[Int]) = {
      if(!(productions contains(name))) {
        productions += name
        // --- STAGED
        val tmp = inner(i,j)
        var s:Rep[Answer] = z // z is a zero placeholder
        if (!tmp.isEmpty) s = tmp.head
        //transform(tmp).apply{x:Rep[Answer] => s=x}
        mat(idx(i,j))=s
        // --- STAGED
        productions -= name
      }
      val e = mat(idx(i,j))
      if (e==z) List() else List(e)
    }
  }

  // Bottom-up parsing (from bottomUp2)
  def bottomUp(in:Input, p: =>TabulatedParser, costMatrix: Rep[Array[Answer]], z: Rep[Answer])(implicit mAlph: Manifest[Alphabet], mA: Manifest[Answer]) : Rep[Answer] = {
  	val n = in.length
    val mem = (n+1)*(n+2)/2;
    def idx(i:Rep[Int],j:Rep[Int]) = { val d=n+2+i-j; mem - (d*(d-1))/2 + i; }

    (1 until in.length + 1).foreach{l =>
      (0 until in.length + 1 -l).foreach{i =>
        val j = i+l
        var s = z
        val res = p(i,j)
        if (!res.isEmpty) s=res.head
        //transform(res).apply{x:Rep[Answer] => s=x}
        costMatrix(idx(i,j))=s
      }
    }
    costMatrix(idx(0,in.length))
  }
}

// A package to simplify mixing all the traits
trait ParsersPkg extends ParsersExp with Signature with MiscOpsExp with ListToGenTransform with IfThenElseExp with CompileScala { self =>
    val codegen = new ScalaGenArrayOps with ScalaGenMyListOps with ScalaGenNumericOps with ScalaGenIfThenElse with ScalaGenBooleanOps
      with ScalaGenEqual with ScalaGenOrderingOps with ScalaGenMathOps with ScalaGenHackyRangeOps with ScalaGenTupleOps
      with ScalaGenMiscOps with ScalaGenGeneratorOps{ val IR: self.type = self }
}

// ------------------------------------------------------------------------------

//matrix multiplication List to Gen
trait MatMultAlgebra extends Parsers with Signature {
  type Alphabet = (Int,Int)
  type Answer = (Int, Int, Int)

  val mAlph = manifest[Alphabet]
  val mAns = manifest[Answer]

  def single(i: Rep[(Int,Int)]) = (i._1, unit(0), i._2)
  def mult(l: Rep[Answer],r : Rep[Answer]) = (l._1, l._2+r._2+l._1*l._3*r._3, r._3)
}

object MatMutlTest extends App {
  new MatMultAlgebra with ParsersPkg {
    def h(x:Rep[Answer],y:Rep[Answer]) = if(x._2 < y._2) x else y

    def test(in:Input):Rep[Answer] = {
      val a : Rep[Array[Answer]] = NewArray((in.length+1)*(in.length+1))
      val z = (unit(0),unit(100000),unit(0))

      lazy val p:TabulatedParser = tabulate("mat",(
          el(in) ^^ single
        | (p +~+ p) ^^ {x: Rep[(Answer,Answer)] => mult(x._1,x._2)}
      ).aggregate(h),a,z,in.length)

      bottomUp(in,p,a,z)(mAlph, mAns)
    }

/*
    val z = (unit(0),unit(100000),unit(0))
    def multParser(in:Input, a: Rep[Array[Answer]]) : TabulatedParser = {
      lazy val p:TabulatedParser = tabulate("mat",(
          el(in) ^^ single
        | (p +~+ p) ^^ {x: Rep[(Answer,Answer)] => mult(x._1,x._2)}
      ).aggregate(h),a,z,in.length)
      p
    }

    def test(in: Input): Rep[Answer] = { // arrays allocation wrapper
      val a : Rep[Array[Answer]] = NewArray((in.length+1)*(in.length+1))
      val mParser = multParser(in, a)
      val res = bottomUp(in,mParser,a,z)(mAlph, mAns)
      res
    }
*/
    codegen.emitSource(test _, "test-bottomup4", new java.io.PrintWriter(System.out))
    val testc = compile(test)
    val res = testc(scala.Array((10,100),(100,5),(5,50)))
    scala.Console.println(res)
  }
}
