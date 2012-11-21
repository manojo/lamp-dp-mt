package lms

import scala.virtualization.lms.common._

import java.io.PrintWriter
import java.io.FileOutputStream

trait ParsersProg extends LexicalParsers {

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

      tabulate("myParser",
        charf(in, 'm'),
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
        tabulate("myParser",
          (charf(in, 'm') -~~ p) ^^ concatenate,
          a
        )
      p
    }

    myParser(0,in.length).head


  }

}

class TestSimpleParsers extends FileDiffSuite {

  val prefix = "test-out/"

  def testParsers = {
    withOutFile(prefix+"simpleParsers"){
       new ParsersProg with ParsersExp { self =>
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
       new ParsersProg with ParsersExp { self =>
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
       new ParsersProg with ParsersExp { self =>
        val codegen = new ScalaGenArrayOps with ScalaGenListOps with ScalaGenNumericOps with ScalaGenIfThenElse with ScalaGenBooleanOps
          with ScalaGenEqual with ScalaGenOrderingOps with ScalaGenMathOps
          with ScalaGenHackyRangeOps with ScalaGenTupleOps{ val IR: self.type = self }

        codegen.emitSource(testRec1 _ , "test-recursion", new java.io.PrintWriter(System.out))
      }
    }
    assertFileEqualsCheck(prefix+"tabulation2")
  }
}