package lms

import scala.virtualization.lms.common._
import java.io.PrintWriter
import java.io.FileOutputStream
import scala.reflect.SourceContext

trait IteratorProg extends IteratorOps with NumericOps with OrderingOps{
  def test1(start: Rep[Int], end: Rep[Int]) = {
    val it = range(start,end)
    val res = it(unit(0))
    res
  }

  def test2(start: Rep[Int], end: Rep[Int]) = {
    val it = range(start,end).map(i => i* unit(2))
    val res = it(unit(0))
    res
  }

  def test3(start: Rep[Int], end: Rep[Int]) = {
    val it = range(start,end).fold(unit(0),
      {(x:Rep[Int], y: Rep[Int]) => x + y})
    val res = it(unit(0))
    res
  }
}

class TestIteratorOps extends FileDiffSuite {

  val prefix = "test-out/"

  def testiterator1 = {
    withOutFile(prefix+"iterator1"){
       new IteratorProg with IteratorOpsExp with NumericOpsExp with OrderingOpsExp with MyScalaCompile{ self =>

        val codegen = new ScalaGenIteratorOps with ScalaGenNumericOps with ScalaGenOrderingOps{ val IR: self.type = self }
        codegen.emitSource2(test1 _ , "test1", new java.io.PrintWriter(System.out))

        val testc = compile2(test1)
        val res = testc(1,10)
        scala.Console.println(res)

      }
    }
    assertFileEqualsCheck(prefix+"iterator1")
  }

  def testiterator2 = {
    withOutFile(prefix+"iterator2"){
       new IteratorProg with IteratorOpsExp with NumericOpsExp with OrderingOpsExp with MyScalaCompile{ self =>

        val codegen = new ScalaGenIteratorOps with ScalaGenNumericOps with ScalaGenOrderingOps{ val IR: self.type = self }
        codegen.emitSource2(test2 _ , "test2", new java.io.PrintWriter(System.out))

        val testc = compile2(test2)
        val res = testc(1,10)
        scala.Console.println(res)

      }
    }
    assertFileEqualsCheck(prefix+"iterator2")
  }

  def testiterator3 = {
    withOutFile(prefix+"iterator3"){
       new IteratorProg with IteratorOpsExp with NumericOpsExp with OrderingOpsExp with MyScalaCompile{ self =>

        val codegen = new ScalaGenIteratorOps with ScalaGenNumericOps with ScalaGenOrderingOps{ val IR: self.type = self }
        codegen.emitSource2(test3 _ , "test3", new java.io.PrintWriter(System.out))

        val testc = compile2(test3)
        val res = testc(1,5)
        scala.Console.println(res)

      }
    }
    assertFileEqualsCheck(prefix+"iterator3")
  }
}