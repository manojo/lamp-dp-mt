package lms

import scala.virtualization.lms.common._

import java.io.PrintWriter
import java.io.FileOutputStream

trait ParsersProg extends LexicalParsers {this: Sig =>
  type Answer = Char

  def test1(in: Rep[Array[Char]]) = char(in)(0, 1)

  def test2(in: Rep[Array[Char]]) = charf(in, 'm')(0,1)

  def test3(in: Rep[Array[Char]]) = {
    val p = char(in) ^^ (x => x)
    p(0,1)
  }

  def test4(in: Rep[Array[Char]]) = (charf(in,'m') | charf(in,'a'))(0,1)

  def test5(in: Rep[Array[Char]]) : Rep[List[Char]] = {
    val p = (charf(in,'m') | charf(in,'a')) aggregate(x => List(x.head))
    p(0,1)
  }

  def test6(in: Rep[Array[Char]]) : Rep[List[(Char,Char)]] = {
    val p = (charf(in, 'm') ~~+ charf(in, 'a'))
    p(0,2)
  }

  def testTab1(in: Input) : Rep[List[Char]] = {
    val myParser : Parser[Char] = {
      val a : Rep[Array[Array[List[Char]]]] = NewArray(in.length+1)
      (0 until in.length + 2).foreach{ i=>
        a(0) = NewArray(in.length+1)
      }

      tabulate(charf(in, 'm'),
        "myParser",
        a
      )
    }

    myParser(0,1)
  }

  def testRec1(in: Input) : Rep[List[Char]] = {
    def concatenate(t : Rep[(Char, List[Char])]) = t._1 :: t._2

    val myParser : Parser[List[Char]] = {
      val a : Rep[Array[Array[List[List[Char]]]]]
        = NewArray(in.length+1)
      (0 until in.length + 2).foreach{ i=>
        a(0) = NewArray(in.length+1)
      }

      lazy val p: Parser[List[Char]] =
        tabulate((charf(in, 'm') -~~ p) ^^ concatenate,
          "myParser",
          a
        )
      p
    }

    myParser(0,in.length).head
  }
}

//matrix multiplication
trait MatMultProg extends Parsers{ this: Sig =>
  type Alphabet = (Int,Int)
  type Answer = (Int, Int, Int)

  def single(i: Rep[(Int,Int)]) = (i._1, unit(0), i._2)
  def mult(l: Rep[Answer],r : Rep[Answer]) = {
    (l._1, l._2 + r._2 + l._1 * l._3 * r._3 ,r._3)
  }

  def el(in: Input) = new Parser[Alphabet] {
    def apply(i: Rep[Int], j : Rep[Int]) =
      if(i+1==j) List(in(i)) else List()
  }

  def testMatMult(in : Input): Rep[Answer] = {
    val myParser : Parser[Answer] = {
      val a : Rep[Array[Array[List[Answer]]]] = NewArray(in.length+1)
      (0 until in.length + 2).foreach{ i=>
        a(0) = NewArray(in.length+1)
      }

      lazy val p : Parser[Answer] = tabulate(
       (el(in) ^^ single
        | (p +~+ p) ^^ {x => mult(x._1,x._2)}
       ),
       "mat",
       a
      )
     p
    }

    val sth : Int = myParser match {
      case TabulatedParser(
        OrParser(MapParser(_,_),p),
        _,_) => p() match{
          case MapParser(/*ConcatParser(_,_,_,_,_,_)*/_,_) => 1
          case _ => 0
      }
      case _ => 0
    }
    println(sth)


    myParser(0, in.length).head
  }
}

class TestSimpleParsers extends FileDiffSuite {

  val prefix = "test-out/"

  def testParsers = {
    withOutFile(prefix+"simpleParsers"){
       new ParsersProg with ParsersExp with Sig { self =>

        val codegen = new ScalaGenArrayOps with ScalaGenListOps with ScalaGenNumericOps with ScalaGenIfThenElse with ScalaGenBooleanOps
          with ScalaGenEqual with ScalaGenOrderingOps with ScalaGenMathOps
          with ScalaGenHackyRangeOps with ScalaGenTupleOps{ val IR: self.type = self }

        codegen.emitSource(test1 _ , "test1", new java.io.PrintWriter(System.out))
        codegen.emitSource(test2 _ , "test2", new java.io.PrintWriter(System.out))
        codegen.emitSource(test3 _ , "test3", new java.io.PrintWriter(System.out))
        codegen.emitSource(test4 _ , "test4", new java.io.PrintWriter(System.out))
        codegen.emitSource(test5 _ , "test5", new java.io.PrintWriter(System.out))
        codegen.emitSource(test6 _ , "test6", new java.io.PrintWriter(System.out))
      }
    }

    assertFileEqualsCheck(prefix+"simpleParsers")
  }


  def testTabulation1 = {
    withOutFile(prefix+"tabulation1"){
       new ParsersProg with ParsersExp with Sig { self =>
        val codegen = new ScalaGenArrayOps with ScalaGenListOps with ScalaGenNumericOps with ScalaGenIfThenElse with ScalaGenBooleanOps
          with ScalaGenEqual with ScalaGenOrderingOps with ScalaGenMathOps
          with ScalaGenHackyRangeOps with ScalaGenTupleOps{ val IR: self.type = self }

        codegen.emitSource(testTab1 _ , "test-tabulation", new java.io.PrintWriter(System.out))
      }
    }
    assertFileEqualsCheck(prefix+"tabulation1")
  }

  def testTabulation2 = {
    withOutFile(prefix+"tabulation2"){
       new ParsersProg with ParsersExp with Sig { self =>
        val codegen = new ScalaGenArrayOps with ScalaGenListOps with ScalaGenNumericOps with ScalaGenIfThenElse with ScalaGenBooleanOps
          with ScalaGenEqual with ScalaGenOrderingOps with ScalaGenMathOps
          with ScalaGenHackyRangeOps with ScalaGenTupleOps{ val IR: self.type = self }

        codegen.emitSource(testRec1 _ , "test-recursion", new java.io.PrintWriter(System.out))
      }
    }
    assertFileEqualsCheck(prefix+"tabulation2")
  }

  def testMatMult1 = {
    withOutFile(prefix+"matmult"){
       new MatMultProg with ParsersExp with Sig { self =>
        val codegen = new ScalaGenArrayOps with ScalaGenListOps with ScalaGenNumericOps with ScalaGenIfThenElse with ScalaGenBooleanOps
          with ScalaGenEqual with ScalaGenOrderingOps with ScalaGenMathOps
          with ScalaGenHackyRangeOps with ScalaGenTupleOps{ val IR: self.type = self }

        codegen.emitSource(testMatMult _ , "test-matmult", new java.io.PrintWriter(System.out))

      }
    }
    assertFileEqualsCheck(prefix+"matmult")
  }
}