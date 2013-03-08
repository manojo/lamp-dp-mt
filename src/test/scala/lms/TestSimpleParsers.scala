package lms

import scala.virtualization.lms.common._
import scala.virtualization.lms.internal.Effects
import java.io.PrintWriter
import java.io.FileOutputStream

//matrix multiplication
trait MatMultProg extends Parsers{ this: Sig =>
  type Alphabet = (Int,Int)
  val mAlph = manifest[(Int,Int)]

  type Answer = (Int, Int, Int)
  val mAns = manifest[(Int,Int,Int)]

  def single(i: Rep[(Int,Int)]) =
    (i._1, unit(0), i._2)

  def mult(l: Rep[Answer],r : Rep[Answer]) = {
    (l._1, l._2 + r._2 + l._1 * l._3 * r._3 ,r._3)
  }

  def multParser(in:Input, a: Rep[Array[Array[Answer]]]) /*: TabulatedParser*/ = {
    lazy val p : Parser[Answer]/*: TabulatedParser*/ = tabulate(
     (el(in) ^^ single
      | (p +~+ p) ^^ {(x: Rep[(Answer,Answer)]) => mult(x._1,x._2)}
     ).aggfold((unit(0),unit(100000),unit(0)), (x,y) => if(x._2 < y._2) x else y),
     "mat",
     a
    )
   p
  }

  def multWithArray(in: Input) = {
    val a : Rep[Array[Array[Answer]]] = NewArray(in.length+1)
    (0 until in.length + 1).foreach{ i=>
      a(0) = NewArray(in.length+1)
    }
    multParser(in, a)
  }

  def testMult1(in : Input): Rep[Answer] = {
    multWithArray(in)(0, in.length).head
  }
}

class TestSimpleParsers extends FileDiffSuite {

  val prefix = "test-out/"

  def testMatMult1 = {
    withOutFile(prefix+"matmult"){
       new MatMultProg with ParsersExp with Sig with MiscOpsExp{ self =>
        val codegen = new ScalaGenArrayOps with ScalaGenMyListOps with ScalaGenNumericOps with ScalaGenIfThenElse with ScalaGenBooleanOps
          with ScalaGenEqual with ScalaGenOrderingOps with ScalaGenMathOps
          with ScalaGenMyRangeOps with ScalaGenTupleOps with ScalaGenMiscOps{ val IR: self.type = self }

        codegen.emitSource(testMult1 _ , "test-matmult", new java.io.PrintWriter(System.out))

      }
    }
    assertFileEqualsCheck(prefix+"matmult")
  }

  def testMatMult2 = {
    withOutFile(prefix+"matmult2"){
       new MatMultProg with ParsersExp with Sig with MiscOpsExp{ self =>
        val codegen = new ScalaGenArrayOps with ScalaGenMyListOps with ScalaGenNumericOps with ScalaGenIfThenElse with ScalaGenBooleanOps
          with ScalaGenEqual with ScalaGenOrderingOps with ScalaGenMathOps
          with ScalaGenMyRangeOps with ScalaGenTupleOps with ScalaGenMiscOps { val IR: self.type = self }

        def testMult2(in: Input) : Rep[Answer] = {
          val opti = transform(multWithArray(in))//.asInstanceOf[Parser[Answer]]
          opti(0, in.length).head
        }

        codegen.emitSource(testMult2 _ , "test-matmult2", new java.io.PrintWriter(System.out))

      }
    }
    assertFileEqualsCheck(prefix+"matmult2")
  }

  def testBottomUp1 = {
    withOutFile(prefix+"bottomup1"){
       new MatMultProg with ParsersExp with Sig with MiscOpsExp with CompileScala{ self =>
        val codegen = new ScalaGenArrayOps with ScalaGenMyListOps with ScalaGenNumericOps with ScalaGenIfThenElse with ScalaGenBooleanOps
          with ScalaGenEqual with ScalaGenOrderingOps with ScalaGenMathOps
          with ScalaGenMyRangeOps with ScalaGenTupleOps with ScalaGenMiscOps{ val IR: self.type = self }

        def testBottomup(in: Input): Rep[Answer] = {
          val a : Rep[Array[Array[Answer]]] = NewArray(in.length+1)
          (0 until in.length + 1).foreach{ i=>
            a(i) = NewArray(in.length+1)
          }

          val mParser = multParser(in, a)
          val res = bottomUp(in,mParser,a)
          res
        }

        codegen.emitSource(testBottomup _ , "test-bottomup1", new java.io.PrintWriter(System.out))

        val testc = compile(testBottomup)
        val res = testc(scala.Array((10,100),(100,5),(5,50)))
        scala.Console.println(res)
        //val input = List((10,100),(100,5),(5,50)).toArray
        //println(parse(input))

      }
    }
    assertFileEqualsCheck(prefix+"bottomup1")
  }

  def testBottomUp2 = {
    withOutFile(prefix+"bottomup2"){
       new MatMultProg with ParsersExp with Sig with MiscOpsExp with CompileScala{ self =>
        val codegen = new ScalaGenArrayOps with ScalaGenMyListOps with ScalaGenNumericOps with ScalaGenIfThenElse with ScalaGenBooleanOps
          with ScalaGenEqual with ScalaGenOrderingOps with ScalaGenMathOps
          with ScalaGenMyRangeOps with ScalaGenTupleOps with ScalaGenMiscOps{ val IR: self.type = self }

        def multP(in:Input, a: Rep[Array[Array[Answer]]]) : TabulatedParser = {
          lazy val p : TabulatedParser = tabulate(
           (el(in) ^^ single
            | (p +~+ p) ^^ {(x: Rep[(Answer,Answer)]) => mult(x._1,x._2)}
           ).aggfold((unit(0),unit(100000),unit(0)), (x,y) => if(x._2 < y._2) x else y),
           "mat",
           a
          )
         p
        }

        def testBottomup2(in: Input): Rep[Answer] = {
          val a : Rep[Array[Array[Answer]]] = NewArray(in.length+1)
          (0 until in.length + 1).foreach{ i=>
            a(i) = NewArray(in.length+1)
          }

          val mParser = transform(multP(in, a))
          val res = bottomUp(in,mParser,a)
          res
        }

        codegen.emitSource(testBottomup2 _ , "test-bottomup2", new java.io.PrintWriter(System.out))

        val testc = compile(testBottomup2)
        val res = testc(scala.Array((10,100),(100,5),(5,50)))
        scala.Console.println(res)

      }
    }
    assertFileEqualsCheck(prefix+"bottomup2")
  }
}