package lms

import scala.virtualization.lms.common._

import java.io.PrintWriter
import java.io.FileOutputStream

trait ParsersProg extends Parsers {

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

}

class TestSimpleParsers extends FileDiffSuite {

  val prefix = "test-out/"

  def testParsers = {
    withOutFile(prefix+"simpleParsers"){
       new ParsersProg with ParsersExp { self =>
        val codegen = new ScalaGenArrayOps with ScalaGenListOps with ScalaGenNumericOps with ScalaGenIfThenElse with ScalaGenBooleanOps
          with ScalaGenEqual{ val IR: self.type = self }

        codegen.emitSource(test1 _ , "test1", new java.io.PrintWriter(System.out))
        codegen.emitSource(test2 _ , "test2", new java.io.PrintWriter(System.out))
        codegen.emitSource(test3 _ , "test3", new java.io.PrintWriter(System.out))
        codegen.emitSource(test4 _ , "test4", new java.io.PrintWriter(System.out))
        codegen.emitSource(test4 _ , "test5", new java.io.PrintWriter(System.out))
      }
    }

    assertFileEqualsCheck(prefix+"simpleParsers")
  }
}