package lms.v2

import lms._
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
                 with MathOps with HackyRangeOps with TupleOps with MiscOps{this: Sig =>

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
  def parser_or[T:Manifest](inner: Parser[T], that: => Parser[T]): Parser[T]
  def parser_concat[T:Manifest, U:Manifest](inner: Parser[T], lL:Rep[Int], lU:Rep[Int], rL:Rep[Int], rU:Rep[Int], that: => Parser[U]): Parser[(T,U)]
  def tabulate(name:String, inner: =>Parser[Answer], mat: Rep[Array[Array[Answer]]], z: Rep[Answer]) : Parser[Answer] // XXX: mat must go away
  
  /*************** simple parsers below *****************/
  def el(in: Input)(implicit mAlph: Manifest[Alphabet]) = new Parser[Alphabet] {
    def apply(i:Rep[Int], j:Rep[Int]) = if(i+1==j) List(in(i)) else List()
  }

  def eli(in: Input) = new Parser[Int] {
    def apply(i: Rep[Int], j : Rep[Int]) = if(i+1==j) List(i) else List()
  }
}

trait LexicalParsers extends Parsers {this: Sig =>
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
    with TupleOpsExp with ListToGenTransform{this: Sig =>

  def parser_filter[T:Manifest](inner: Parser[T], p: (Rep[Int], Rep[Int]) => Rep[Boolean]) :  Parser[T] = FilterParser(inner,p)
  def parser_map[T:Manifest, U:Manifest](inner: Parser[T], f: Rep[T] => Rep[U]) : Parser[U] = MapParser(inner,f)
  def parser_or[T:Manifest](inner: Parser[T], that: => Parser[T]): Parser[T] = OrParser(inner, ()=>that)
  def parser_aggregate[T:Manifest](inner: Parser[T], h:(Rep[T],Rep[T])=>Rep[T]) : Parser[T] = AggregateParser(inner,h)
  def parser_concat[T:Manifest, U:Manifest](inner: Parser[T], lL:Rep[Int], lU:Rep[Int], rL:Rep[Int], rU:Rep[Int],
                                            that: => Parser[U]): Parser[(T,U)] = ConcatParser(inner, lL,lU,rL,rU, () => that)
  def tabulate(name:String, inner: =>Parser[Answer], mat: Rep[Array[Array[Answer]]], z: Rep[Answer]) = TabulatedParser(name, inner, mat, z)(mAns)

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

  case class OrParser[T:Manifest](inner: Parser[T], that: () => Parser[T]) extends Parser[T] {
    def apply(i: Rep[Int], j: Rep[Int]) = inner(i,j) ++ that()(i,j)
  }

  case class AggregateParser[T:Manifest, U:Manifest](inner: Parser[T], h:(Rep[T],Rep[T])=>Rep[T]) extends Parser[T] {
    def apply(i: Rep[Int], j: Rep[Int]) = {
      val tmp=inner(i,j); if (tmp.isEmpty) List() else { List(list_fold(tmp.tail,tmp.head,h)) }
    }
  }

  case class ConcatParser[T:Manifest, U:Manifest](inner: Parser[T], lL:Rep[Int], lU:Rep[Int], rL:Rep[Int], rU:Rep[Int], that: () => Parser[U]) extends Parser[(T,U)]{
    def apply(i: Rep[Int], j: Rep[Int]) = if(i< j){
      val min_k = if (rU== -1) i+lL else Math.max(i+lL,j-rU)
      val max_k = if (lU== -1) j-rL else Math.min(j-rL,i+lU)
      for(
        k <- (min_k until max_k+1).toList;
        x <- inner(i,k);
        y <- that()(k,j)
      ) yield((x,y))
      //for(k <- (min_k until max_k+1).toList) yield((inner(i,k).head,that()(k,j).head)) + WARNING: test emptynesss of x,y
    } else List()
  }

  case class TabulatedParser(name:String, inner: Parser[Answer], mat: Rep[Array[Array[Answer]]], z: Rep[Answer])(implicit val mAns: Manifest[Answer]) extends Parser[Answer] {
    def apply(i: Rep[Int], j: Rep[Int]) = {
      if(!(productions contains(name))) {
        productions += name
        val tmp = inner(i,j)
        var s:Rep[Answer] = z
        //if (!tmp.isEmpty) s = tmp.head // z is a zero placeholder
        transform(tmp).apply { x:Rep[Answer] => s=x }
        val x=mat(i); x(j)=s
        productions -= name
      }
      val e = mat(i).apply(j)
      if (e==z) List() else List(e)

    }
  }

  // Bottom-up parsing (from bottomUp2)
  def bottomUp(in:Input, p: =>TabulatedParser, costMatrix: Rep[Array[Array[Answer]]], z: Rep[Answer])(implicit mAlph: Manifest[Alphabet], mA: Manifest[Answer]) : Rep[Answer] = {
    (1 until in.length + 1).foreach{l =>
      (0 until in.length + 1 -l).foreach{i =>
        val j = i+l
        var s = z
        val res = p(i,j)
        val genp = transform(res)
        genp{x:Rep[Answer] => s=x}
        val x=costMatrix(i); x(j)=s
      }
    }
    val temp = costMatrix(0); temp(in.length)
  }
}

// ------------------------------------------------------------------------------

import scala.virtualization.lms.common._
import java.io.PrintWriter
import java.io.FileOutputStream

//matrix multiplication List to Gen
trait MatMultToGenProg extends Parsers{ this: Sig =>
  type Alphabet = (Int,Int)
  type Answer = (Int, Int, Int)

  val mAlph = manifest[Alphabet]
  val mAns = manifest[Answer]

  def single(i: Rep[(Int,Int)]) = (i._1, unit(0), i._2)
  def mult(l: Rep[Answer],r : Rep[Answer]) = (l._1, l._2+r._2+l._1*l._3*r._3, r._3)
}

object MatMutlTest extends App {
  new MatMultToGenProg with ParsersExp with Sig with MiscOpsExp with ListToGenTransform with IfThenElseExp with CompileScala { self =>
    val codegen = new ScalaGenArrayOps with ScalaGenMyListOps with ScalaGenNumericOps with ScalaGenIfThenElse with ScalaGenBooleanOps
      with ScalaGenEqual with ScalaGenOrderingOps with ScalaGenMathOps with ScalaGenHackyRangeOps with ScalaGenTupleOps
      with ScalaGenMiscOps with ScalaGenGeneratorOps{ val IR: self.type = self }

        def h(x:Rep[Answer],y:Rep[Answer]) = if(x._2 < y._2) x else y
        val z = (unit(0),unit(100000),unit(0))

        def multParser(in:Input, a: Rep[Array[Array[Answer]]]) : TabulatedParser = {
          lazy val p:TabulatedParser = tabulate("mat",(
          	   el(in) ^^ single
             | (p +~+ p) ^^ {x: Rep[(Answer,Answer)] => mult(x._1,x._2)}
           ).aggregate(h),a,z)
          p
        }

        //with listtogen transform
        def test(in: Input): Rep[Answer] = {
          val a : Rep[Array[Array[Answer]]] = NewArray(in.length+1)

          (0 until in.length + 1).foreach{ i=> a(i) = NewArray(in.length+1) }
          val mParser = multParser(in, a)
          val res = bottomUp(in,mParser,a,z)(mAlph, mAns)
          res
        }

  /*
        def ttt(y:Rep[List[Int]]):Rep[Int] = {
          var x = if (y.head==3) List(3) else List()
          if (x.isEmpty) { unit(0) } else { x.head }
        }
        val ttc = compile(ttt);
        val ttr = scala.List(2)
        scala.Console.println(ttc(ttr))
    */    

        codegen.emitSource(test _ , "test-bottomup3", new java.io.PrintWriter(System.out))
        val testc = compile(test)
        val res = testc(scala.Array((10,100),(100,5),(5,50)))
        scala.Console.println(res)
      }


}
