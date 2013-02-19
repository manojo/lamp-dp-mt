package lms

import scala.virtualization.lms.common._
import java.io.PrintWriter
import java.io.FileOutputStream
import scala.reflect.SourceContext

trait ListOptProg extends MyListOps with NumericOps{
  def test1(xs: Rep[List[Int]]) : Rep[List[Int]] = {
    xs.map(x => x * unit(2))
      .map(x => x + unit(1))
      .map(x => x * unit(3))
  }
}

class TestListOpt extends FileDiffSuite {

  val prefix = "test-out/"

  def testlistopt = {
    withOutFile(prefix+"mapmap"){
       new ListOptProg with MyListOpsExpOpt with NumericOpsExp with CompileScala{ self =>

        val codegen = new ScalaGenMyListOps with ScalaGenNumericOps{ val IR: self.type = self }
        codegen.emitSource(test1 _ , "test1", new java.io.PrintWriter(System.out))

        val testc = compile(test1)
        val res = testc(scala.List(1,2,3))
        scala.Console.println(res)

      }
    }

    assertFileEqualsCheck(prefix+"mapmap")
  }
}