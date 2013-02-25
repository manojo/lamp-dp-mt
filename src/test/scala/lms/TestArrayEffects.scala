package lms

import scala.virtualization.lms.common._
import scala.virtualization.lms.util.OverloadHack
import java.io.PrintWriter
import java.io.StringWriter
import java.io.FileOutputStream
import scala.reflect.SourceContext

trait ArrayEffectsProg extends Variables with While with LiftVariables
  with RangeOps with NumericOps with OrderingOps with IfThenElse
  with PrimitiveOps with Equal with Structs with MiscOps
  with TupleOps with ArrayOps with OverloadHack{

  type FibPair = Record { val fib_1: Int; val fib_0: Int}
  def FibPair(f_1: Rep[Int], f_0: Rep[Int]): Rep[FibPair] = new Record {
    val fib_1 = f_1; val fib_0 = f_0
  }

    def testFib(n:Rep[Int]) = {
    val a: Rep[Array[Int]] = NewArray(n)

    a(unit(0)) = unit(1)
    a(unit(1)) = unit(1)

    (unit(2) until a.length).foreach{i =>
      a(i) = a(i-unit(1)) + a(i-unit(2))
    }

    a(a.length- unit(1))
  }

  //x is a redundant parameter just for using compile2s below
  def testFib2(n:Rep[Int], x: Rep[Int]) = {
    val a: Rep[Array[FibPair]] = NewArray(n)

    a(unit(0)) = FibPair(unit(1), unit(0))
    a(unit(1)) = FibPair(unit(1), unit(1))

    (unit(2) until a.length).foreach{i =>
      a(i) = FibPair(a(i-unit(1)).fib_1 + a(i-unit(2)).fib_1,
                    a(i-unit(1)).fib_0 + a(i-unit(2)).fib_0)
    }

    a(a.length- unit(1))
  }


  //x is a redundant parameter just for using compile2s below
  def testFib3(a:Rep[Array[(Int,Int)]], x: Rep[Int]) = {

    a(unit(0)) = (unit(1), unit(0))
    a(unit(1)) = (unit(1), unit(1))

    (unit(2) until a.length).foreach{i =>
      a(i) = (a(i-unit(1))._1 + a(i-unit(2))._1,
              a(i-unit(1))._2 + a(i-unit(2))._2)
    }

    a(a.length- unit(1))
  }

  /**
   * defining a struct for storing matrix results
   */

  type Matres = Record { val rows: Int; val cols: Int; val mults: Int }
  def Matres(r: Rep[Int], c: Rep[Int], m: Rep[Int]): Rep[Matres] = new Record {
    val rows = r; val cols = c; val mults = m
  }

  def testMatMult(in: Rep[Array[(Int,Int)]], x: Rep[Int]) = {

    def mult(l: Rep[Matres],r : Rep[Matres]) = {
      Matres(l.rows, r.cols, l.mults + r.mults +
        l.rows * l.cols * r.cols)
    }

    val costMatrix : Rep[Array[Matres]] = NewArray((in.length+unit(1)) * (in.length+ unit(1)))

    (unit(1) until in.length + unit(1)).foreach{l =>
      (unit(0) until in.length + unit(1) -l).foreach{i =>
        val j = i+l

        if(i + 1 == j){
          val tmp = in(i)
          costMatrix(i * (in.length + unit(1)) + j) = Matres(tmp._1, tmp._2, unit(0))
        }else{
          var s : Rep[Matres] = Matres(unit(0), unit(0), unit(10000))
          (i+1 until j+1).foreach{ k=>
            val x = costMatrix(i * (in.length + unit(1)) + k)
            val y = costMatrix(k * (in.length + unit(1)) + j)
            val tmp = mult(x,y)
            if(tmp.mults < s.mults){ s = tmp}
          }
          costMatrix(i * (in.length + unit(1)) + j) = s
        }
      }
    }

    println(costMatrix(0 * (in.length + unit(1)) + in.length))
  }
}

class TestArrayEffects extends FileDiffSuite {

  val prefix = "test-out/"

  def testarrayeffects = {
    withOutFile(prefix+"array-effects"){
       new ArrayEffectsProg with EffectExp with VariablesExp with RangeOpsExp
        with WhileExp with NumericOpsExp with OrderingOpsExp
        with IfThenElseExp with PrimitiveOpsExp with EqualExp
        with StructExp with StructExpOptCommon with ArrayOpsExp
        with MiscOpsExp with TupleOpsExp with MyScalaCompile{ self =>

        val printWriter = new java.io.PrintWriter(System.out)

        //test1: mat mult
        val codegen = new ScalaGenWhile with ScalaGenVariables
          with ScalaGenRangeOps with ScalaGenNumericOps
          with ScalaGenOrderingOps with ScalaGenPrimitiveOps
          with ScalaGenEqual with ScalaGenArrayOps
          with ScalaGenStruct with ScalaGenMiscOps
          with ScalaGenTupleOps { val IR: self.type = self }

        codegen.emitSource(testFib _ , "testFib", printWriter)
        val testc1 = compile(testFib)//, source)
        scala.Console.println(testc1(10))

        codegen.emitSource2(testFib2 _ , "testFib2", printWriter)
        codegen.emitDataStructures(printWriter)
        val source = new StringWriter
        codegen.emitDataStructures(new PrintWriter(source))
        val testc2 = compile2s(testFib2, source)
        scala.Console.println(testc2(10,1))

        codegen.emitSource2(testFib3 _ , "testFib3", printWriter)
        codegen.emitDataStructures(printWriter)
        val source2 = new StringWriter
        codegen.emitDataStructures(new PrintWriter(source2))
        val testc3 = compile2s(testFib3, source2)
        scala.Console.println(testc3(scala.Array((0,0),(0,0),(0,0),(0,0),(0,0),(0,0)),1))


        codegen.emitSource2(testMatMult _ , "testMatMult", printWriter)
        codegen.emitDataStructures(printWriter)
        val source3 = new StringWriter
        codegen.emitDataStructures(new PrintWriter(source3))
        val testc4 = compile2s(testMatMult, source3)
        //how do I pass an array of structs as a parameter ??
        scala.Console.println(testc4(scala.Array((10,100),(100,5),(5,50)), 0))


      }
    }
    assertFileEqualsCheck(prefix+"array-effects")
  }
}