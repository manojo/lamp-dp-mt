package lms

import scala.virtualization.lms.common._

import java.io.PrintWriter
import java.io.FileOutputStream

trait ParsersProg extends Parsers {

  def test1(in: Rep[Array[Char]]) : Rep[Char] = char(in)(0, 1)

  def test2(in: Rep[Array[Char]]) : Rep[Char] = charf(in, x=> x == 'm')(0,1)

}

class TestSimpleParsers extends FileDiffSuite {

  val prefix = "test-out/"

  def testParsers = {
    withOutFile(prefix+"simpleParsers"){
       new ParsersProg with ParsersExp { self =>
        val codegen = new ScalaGenArrayOps with ScalaGenNumericOps with ScalaGenIfThenElse with ScalaGenBooleanOps
          with ScalaGenEqual{ val IR: self.type = self }

        codegen.emitSource(test1 _ , "test1", new java.io.PrintWriter(System.out))
        codegen.emitSource(test2 _ , "test2", new java.io.PrintWriter(System.out))
      }
    }

    assertFileEqualsCheck(prefix+"simpleParsers")
  }


}