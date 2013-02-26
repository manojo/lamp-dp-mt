package lms

import scala.virtualization.lms.common._
import scala.virtualization.lms.util.OverloadHack
import java.io.PrintWriter
import java.io.StringWriter
import java.io.FileOutputStream
import scala.reflect.SourceContext

trait ListToGenProg extends Variables with LiftVariables
  with HackyRangeOps with ListOps with NumericOps
  with IfThenElse with OrderingOps{

  def test1(n:Rep[Int]) = {
    val ls: Rep[List[Int]] = (unit(1) until unit(11)).toList
    ls
  }

  //testing concat
  def test2(n:Rep[Int]) = {
    val ls = (unit(1) until unit(11)).toList
    val ls1 = (unit(1) until unit(11)).toList
    ls ++ ls1
  }

  //testing listNew
  def test3(n:Rep[Int]) = {
    val ls = List(unit(10), unit(23), unit(42))
    ls
  }

  //testing ifThenElse
  def test4(n:Rep[Int]) = {
    val ls = if(n > unit(10)) List(unit(10), unit(23), unit(42)) else List()
    ls
  }
}

class TestListToGen extends FileDiffSuite {

  val prefix = "test-out/"

  def testarrayeffects = {
    withOutFile(prefix+"list-to-gen"){
       new ListToGenProg with EffectExp with VariablesExp with HackyRangeOpsExp
        with NumericOpsExp with ListToGenTransform
        with IfThenElseExp with OrderingOpsExp with MyScalaCompile{ self =>

        val printWriter = new java.io.PrintWriter(System.out)

        def transformed1(n: Rep[Int]) = {
          var s = unit(0)
          val generator = this.transform(test1(n))
          generator{x: Rep[Int] => s = s+x}
          s
        }

        def transformed2(n: Rep[Int]) = {
          var s = unit(0)
          val generator = this.transform(test2(n))
          generator{x: Rep[Int] => s = s+x}
          s
        }

        def transformed3(n: Rep[Int]) = {
          var s = unit(0)
          val generator = this.transform(test3(n))
          generator{x: Rep[Int] => s = s+x}
          s
        }

        def transformed4(n: Rep[Int]) = {
          var s = unit(0)
          val generator = this.transform(test4(n))
          generator{x: Rep[Int] => s = s+x}
          s
        }

        //test1: mat mult
        val codegen = new ScalaGenVariables
          with ScalaGenHackyRangeOps with ScalaGenNumericOps
          with ScalaGenIfThenElse with ScalaGenOrderingOps
          { val IR: self.type = self }

        codegen.emitSource(transformed1 _ , "test1", printWriter)
        val testc1 = compile(transformed1)
        scala.Console.println(testc1(10))

        codegen.emitSource(transformed2 _ , "test2", printWriter)
        val testc2 = compile(transformed2)
        scala.Console.println(testc2(10))

        codegen.emitSource(transformed3 _ , "test3", printWriter)
        val testc3 = compile(transformed3)
        scala.Console.println(testc3(10))

        codegen.emitSource(transformed4 _ , "test4", printWriter)
        val testc4 = compile(transformed4)
        scala.Console.println(testc4(9))
        scala.Console.println(testc4(11))

      }
    }
    assertFileEqualsCheck(prefix+"list-to-gen")
  }
}