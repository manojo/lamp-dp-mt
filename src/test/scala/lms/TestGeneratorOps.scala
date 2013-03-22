package lms

import scala.virtualization.lms.common._
import scala.virtualization.lms.util.OverloadHack
import java.io.PrintWriter
import java.io.StringWriter
import java.io.FileOutputStream
import scala.reflect.SourceContext

trait GeneratorProg extends GeneratorOps with NumericOps
  with OrderingOps with PrimitiveOps with Equal
  with Structs with MiscOps with ArrayOps with LiftVariables with OverloadHack
  {

  type Complex = Record { val re: Double; val im: Double }
  def Complex(r: Rep[Double], i: Rep[Double]): Rep[Complex] = new Record { val re = r; val im = i }

  def infix_+(x: Rep[Complex], y: Rep[Complex])(implicit o: Overloaded1): Rep[Complex] = Complex(x.re + y.re, x.im + y.im)
  def infix_-(x: Rep[Complex], y: Rep[Complex])(implicit o: Overloaded1): Rep[Complex] = Complex(x.re - y.re, x.im - y.im)
  def infix_toDouble(x: Rep[Int]): Rep[Double] = x.asInstanceOf[Rep[Double]]

  def test1(start: Rep[Int], end: Rep[Int]) = {
    val g = range(start,end)

    var s = 0
    g{ x:Rep[Int] => s = x}
    s
  }

  def test2(start: Rep[Int], end: Rep[Int]) = {
    val g = range(start,end).map{x:Rep[Int] => x* unit(2)}

    var s  = 0
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

  //gen-ing a single elem from a list
  def test7(start: Rep[Int], end: Rep[Int]) = {
    val a : Rep[Array[Int]] = Array(1,2,3)
    val g = new Generator[Int]{
      def apply(f: Rep[Int] => Rep[Unit]) = {
        if(start + unit(1) == end) f(start)
      }
    }

    var s = unit(0)
    g{ x:Rep[Int] => s = a(x) }
    s
  }

  //fromSeq
  def test8(start : Rep[Int]) = {
    val g = Gen.fSeq(unit(1),unit(2),unit(3))

    var s = unit(0)
    g{ x:Rep[Int] => s = s + x }
    s
  }

}

trait ArrayProg extends GeneratorOps with NumericOps
  with OrderingOps with PrimitiveOps with Equal
  with Structs with MiscOps with TupleOps with ArrayOps
  with LiftVariables with OverloadHack{

  type Matres = Record { val rows: Int; val cols: Int; val mults: Int }
  def Matres(r: Rep[Int], c: Rep[Int], m: Rep[Int]): Rep[Matres] = new Record {
    val rows = r; val cols = c; val mults = m
  }

  type Alphabet = (Int,Int)
  type Input = Rep[Array[Alphabet]]


  def testMul(in: Input, n:Rep[Int]) = {

    def mult(l: Rep[Matres],r : Rep[Matres]) = {
      Matres(l.rows, r.cols, l.mults + r.mults +
        l.rows * l.cols * r.cols)
    }

    // a(i)(j) = a(i * (in.length + 1) + j) : this "lowering" done here to get
    // rid of some effect-related issues
    val costMatrix : Rep[Array[Matres]] = NewArray((in.length+unit(1)) * (in.length+ unit(1)))

    def el(i: Rep[Int], j: Rep[Int]) = new Generator[(Int,Int)]{
      def apply(f: Rep[Alphabet] => Rep[Unit]) =
        if(i + 1 == j) f(in(i))
    }

    def matrixEl(i: Rep[Int], j: Rep[Int]) = new Generator[Matres]{
      def apply(f: Rep[Matres] => Rep[Unit]) =
        if(i + 1 == j) {
          f(costMatrix(i * (in.length + unit(1)) + j))
        }
    }

    def single(i: Rep[Int], j: Rep[Int]): Generator[Matres] =
      el(i, j).map{x: Rep[(Int,Int)] =>
        Matres(x._1, x._2, unit(0))
      }

    def concat(i: Rep[Int], j: Rep[Int]): Generator[Matres] =
      range(i+1, j).map{k : Rep[Int] =>
        val x = costMatrix(i * (in.length + unit(1)) + k)
        val y = costMatrix(k * (in.length + unit(1)) + j)
        (x,y)
      }.map{x: Rep[(Matres,Matres)] =>
        mult(x._1,x._2)
      }


    (unit(1) until in.length + unit(1)).foreach{l =>
      (unit(0) until in.length + unit(1) -l).foreach{i =>
        val j = i+l

        val p = single(i,j) ++ concat(i,j)

        var s/*: Rep[Matres]*/ = Matres(unit(0), unit(0), unit(10000))
        p{  x: Rep[Matres] =>
          if(x.mults < readVar(s).mults){s = x}
        }
        costMatrix(i * (in.length + unit(1)) + j) = s
      }
    }

    println(costMatrix(0 * (in.length + unit(1)) + in.length))
  }
}

class TestGeneratorOps extends FileDiffSuite {

  val prefix = "test-out/"

  def testgenerator1 = {
    withOutFile(prefix+"generator-simple"){
       new GeneratorProg with GeneratorOpsExp with NumericOpsExp
        with OrderingOpsExp with PrimitiveOpsExp with EqualExp
        with StructExp with StructExpOptCommon with ArrayOpsExp
        with MiscOpsExp with MyScalaCompile{ self =>

        val printWriter = new java.io.PrintWriter(System.out)

        //test1: first "loop"
        val codegen = new ScalaGenGeneratorOps with ScalaGenNumericOps
          with ScalaGenOrderingOps with ScalaGenPrimitiveOps with ScalaGenEqual
          with ScalaGenArrayOps with ScalaGenStruct with ScalaGenMiscOps
          with ScalaGenVariables { val IR: self.type = self }

        codegen.emitSource2(test1 _ , "test1", printWriter)
        codegen.emitDataStructures(printWriter)
        val source = new StringWriter
        codegen.emitDataStructures(new PrintWriter(source))
        val testc1 = compile2s(test1, source)
        scala.Console.println(testc1(1,11))

        //test2: a map
        codegen.emitSource2(test2 _ , "test2", printWriter)
        val testc2 = compile2(test2)
        scala.Console.println(testc2(1,11))

        //test3: a sum
        codegen.emitSource2(test3 _ , "test3", printWriter)
        val testc3 = compile2(test3)
        scala.Console.println(testc3(1,11))

        //test4: a filtersum
        codegen.emitSource2(test4 _ , "test4", printWriter)
        val testc4 = compile2(test4)
        scala.Console.println(testc4(1,11))

        //test5: a concat
        codegen.emitSource2(test5 _ , "test5", printWriter)
        val testc5 = compile2(test5)
        scala.Console.println(testc5(1,11))

        //test6: a flatMap
        codegen.emitSource2(test6 _ , "test6", printWriter)
        val testc6 = compile2(test6)
        scala.Console.println(testc6(1,6))

        //test7: single elem from Array
        codegen.emitSource2(test7 _ , "test7", printWriter)
        val testc7 = compile2(test7)
        scala.Console.println(testc7(1,2))

        //test8: fromSeq
        codegen.emitSource(test8 _ , "test8", printWriter)
        val testc8 = compile(test8)
        scala.Console.println(testc8(1))

      }
    }
    assertFileEqualsCheck(prefix+"generator-simple")
  }


  def testgenerator2 = {
    withOutFile(prefix+"generator-array"){
       new ArrayProg with GeneratorOpsExp with NumericOpsExp
        with OrderingOpsExp with PrimitiveOpsExp with EqualExp
        with StructExp with StructExpOptCommon with ArrayOpsExp
        with MiscOpsExp with TupleOpsExp with MyScalaCompile{ self =>

        val printWriter = new java.io.PrintWriter(System.out)

        //test1: mat mult
        val codegen = new ScalaGenGeneratorOps with ScalaGenNumericOps
          with ScalaGenOrderingOps with ScalaGenPrimitiveOps with ScalaGenEqual
          with ScalaGenArrayOps with ScalaGenStruct with ScalaGenMiscOps
          with ScalaGenTupleOps with ScalaGenVariables { val IR: self.type = self }

        codegen.emitSource2(testMul _ , "testMul", printWriter)
        codegen.emitDataStructures(printWriter)
        val source = new StringWriter
        codegen.emitDataStructures(new PrintWriter(source))

        val testc1 = compile2s(testMul, source)
        testc1(scala.Array((10,100),(100,5),(5,50)), 0)

      }
    }
    assertFileEqualsCheck(prefix+"generator-array")
  }

  //C Code generation!!!
  def testgenerator1c = {
    withOutFile(prefix+"generator-simple-c"){
       new GeneratorProg with GeneratorOpsExp with NumericOpsExp
        with OrderingOpsExp with PrimitiveOpsExp with EqualExp
        with StructExp with StructExpOptCommon with ArrayOpsExp
        with MiscOpsExp{ self =>

        val printWriter = new java.io.PrintWriter(System.out)

        //test1: first "loop"
        val codegen = new CGenGeneratorOps with CGenNumericOps
          with CGenOrderingOps with CGenPrimitiveOps with CGenEqual
          with CGenArrayOps /*with CGenStruct*/ with CGenMiscOps
          with CGenVariables { val IR: self.type = self }

        codegen.emitSource2(test1 _ , "test1", printWriter)

        //test2: a map
        codegen.emitSource2(test2 _ , "test2", printWriter)


        //test3: a sum
        codegen.emitSource2(test3 _ , "test3", printWriter)

        //test4: a filtersum
        codegen.emitSource2(test4 _ , "test4", printWriter)

        //test5: a concat
        codegen.emitSource2(test5 _ , "test5", printWriter)

        //test6: a flatMap
        codegen.emitSource2(test6 _ , "test6", printWriter)

        //test7: single elem from Array
        //codegen.emitSource2(test7 _ , "test7", printWriter)

        //test8: fromSeq
        //codegen.emitSource(test8 _ , "test8", printWriter)

      }
    }
    assertFileEqualsCheck(prefix+"generator-simple-c")
  }
}