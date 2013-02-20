package lms

import scala.virtualization.lms.common._
import java.io.PrintWriter
import java.io.FileOutputStream
import scala.reflect.SourceContext

trait GeneratorProg extends GeneratorOps with NumericOps
  with OrderingOps with PrimitiveOps with Equal{
  def test1(start: Rep[Int], end: Rep[Int]) = {
    val g = range(start,end)

      var s = unit(0)
      g{ x:Rep[Int] => s = x }
      s
  }

  def test2(start: Rep[Int], end: Rep[Int]) = {
    val g = range(start,end).map{x:Rep[Int] => x * unit(2)}

    var s = unit(0)
    g{ x:Rep[Int] => s = x }
    s
  }

  //sum
  def test3(start: Rep[Int], end: Rep[Int]) = {
    val g = range(start,end)

    var s = unit(0)
    g{ x:Rep[Int] => s = s+x }
    s
  }

  //sum of odds
  def test4(start: Rep[Int], end: Rep[Int]) = {
    val g = range(start,end).filter{x:Rep[Int] =>
      notequals(x%unit(2), unit(0))
    }

    var s = unit(0)
    g{ x:Rep[Int] => s = s+x }
    s
  }

  //concat sum ++ sum of odds
  def test5(start: Rep[Int], end: Rep[Int]) = {
    val f = range(start, end)
    val g = range(start,end).filter{x:Rep[Int] =>
      notequals(x%unit(2), unit(0))
    }

    var s = unit(0)
    (f++g){ x:Rep[Int] => s = s+x }
    s
  }

  //a flatMap!!!
  def test6(start: Rep[Int], end: Rep[Int]) = {
    val f = range(start, end).flatMap{i:Rep[Int] =>
      range(start,i)
    }

    var s = unit(0)
    f{ x:Rep[Int] => s = s+x }
    s
  }
}

class TestGeneratorOps extends FileDiffSuite {

  val prefix = "test-out/"

  def testgenerator1 = {
    withOutFile(prefix+"generator-simple"){
       new GeneratorProg with GeneratorOpsExp with NumericOpsExp
        with OrderingOpsExp with PrimitiveOpsExp with EqualExp with MyScalaCompile{ self =>

        //test1: first "loop"
        val codegen = new ScalaGenGeneratorOps with ScalaGenNumericOps
          with ScalaGenOrderingOps with ScalaGenPrimitiveOps with ScalaGenEqual{ val IR: self.type = self }
        codegen.emitSource2(test1 _ , "test1", new java.io.PrintWriter(System.out))

        val testc1 = compile2(test1)
        scala.Console.println(testc1(1,11))

        //test2: a map
        codegen.emitSource2(test2 _ , "test2", new java.io.PrintWriter(System.out))
        val testc2 = compile2(test2)
        scala.Console.println(testc2(1,11))

        //test3: a sum
        codegen.emitSource2(test3 _ , "test3", new java.io.PrintWriter(System.out))
        val testc3 = compile2(test3)
        scala.Console.println(testc3(1,11))

        //test4: a filtersum
        codegen.emitSource2(test4 _ , "test4", new java.io.PrintWriter(System.out))
        val testc4 = compile2(test4)
        scala.Console.println(testc4(1,11))

        //test5: a concat
        codegen.emitSource2(test5 _ , "test5", new java.io.PrintWriter(System.out))
        val testc5 = compile2(test5)
        scala.Console.println(testc5(1,11))

        //test6: a flatMap
        codegen.emitSource2(test6 _ , "test6", new java.io.PrintWriter(System.out))
        val testc6 = compile2(test6)
        scala.Console.println(testc6(1,6))

      }
    }
    assertFileEqualsCheck(prefix+"generator-simple")
  }
}