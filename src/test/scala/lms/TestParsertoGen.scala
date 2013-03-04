package lms

import scala.virtualization.lms.common._
import java.io.PrintWriter
import java.io.FileOutputStream



//matrix multiplication List to Gen
trait MatMultToGenProg extends Parsers{ this: Sig =>
  type Alphabet = (Int,Int)
  val mAlph = manifest[(Int,Int)]

  type Answer = (Int, Int, Int)
  val mAns = manifest[(Int,Int,Int)]

  def single(i: Rep[(Int,Int)]) =
    (i._1, unit(0), i._2)

  def mult(l: Rep[Answer],r : Rep[Answer]) = {
    (l._1, l._2 + r._2 + l._1 * l._3 * r._3 ,r._3)
  }
}

class TestParsersToGen extends FileDiffSuite {

  val prefix = "test-out/"

  //listogen transform
  def testBottomUp3 = {
    withOutFile(prefix+"bottomup3"){
       new MatMultToGenProg with ParsersExp with Sig with MiscOpsExp
        with ListToGenTransform with CompileScala{ self =>
        val codegen = new ScalaGenArrayOps with ScalaGenMyListOps with ScalaGenNumericOps with ScalaGenIfThenElse with ScalaGenBooleanOps
          with ScalaGenEqual with ScalaGenOrderingOps with ScalaGenMathOps
          with ScalaGenHackyRangeOps with ScalaGenTupleOps with ScalaGenMiscOps{ val IR: self.type = self }


        def multParser(in:Input, a: Rep[Array[Array[Answer]]]) : TabulatedParser2 = {
          lazy val p /*: Parser[Answer]*/ : TabulatedParser2 = tabulate2(
           (el(in) ^^ single
            | (p +~+ p) ^^ {(x: Rep[(Answer,Answer)]) => mult(x._1,x._2)}
           ),//.aggfold((unit(0),unit(100000),unit(0)), (x,y) => if(x._2 < y._2) x else y),
           "mat",
           a,
           (unit(0),unit(100000),unit(0)),
           (x,y) => if(x._2 < y._2) x else y
          )
         p
        }

        def bottomUp2(in: Input, p :  => TabulatedParser2,
            costMatrix: Rep[Array[Array[Answer]]], z: Rep[Answer])(implicit mAlph: Manifest[Alphabet], mA: Manifest[Answer]) : Rep[Answer] = {
          (1 until in.length + 1).foreach{l =>
            (0 until in.length + 1 -l).foreach{i =>
              val j = i+l

              var s = z
              val res = p(i,j)

              val genned = transform(res)
              genned{x : Rep[Answer] =>
                if(x._2 < readVar(s)._2) s = x
              }

              val a = costMatrix(i);a(j) = s
            }
          }
          val temp = costMatrix(0);temp(in.length)
        }

        //with listtogen transform
        def testBottomup3(in: Input): Rep[Answer] = {
          val a : Rep[Array[Array[Answer]]] = NewArray(in.length+1)
          (0 until in.length + 1).foreach{ i=>
            a(i) = NewArray(in.length+1)
          }

          val mParser = multParser(in, a)
          val res = bottomUp2(in,mParser,a, (unit(0), unit(100000), unit(0)))(mAlph, mAns)
          res
        }

        codegen.emitSource(testBottomup3 _ , "test-bottomup3", new java.io.PrintWriter(System.out))

        val testc = compile(testBottomup3)
        val res = testc(scala.Array((10,100),(100,5),(5,50)))
        scala.Console.println(res)

      }
    }
    assertFileEqualsCheck(prefix+"bottomup3")
  }
}