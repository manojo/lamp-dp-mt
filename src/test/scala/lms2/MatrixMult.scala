package lms2

import scala.virtualization.lms.common._
import lms._


trait MatrixMult2 extends Signature with ADPParsers{
  type Alphabet = (Int,Int) // matrix as (rows, columns)
  type Answer = (Int,Int,Int) // rows, cost, columns

  val mAlph = manifest[Alphabet]
  val mAns  = manifest[Answer]

  // Algebra
  def single(i: Rep[Alphabet]) = (i._1, unit(0), i._2)
  def mult(m:Rep[(Answer,Answer)]):Rep[Answer] = { val l=m._1; val r=m._2; (l._1, l._2 + r._2 + l._1 * l._3 * r._3, r._3) }
  def h(a:Rep[Answer],b:Rep[Answer]) = if (a._2 < b._2) a else b

  // Grammar
  val axiom:Tabulate = tabulate("M",( // XXX: can we get rid of the name? it was used only for CUDA codegen
    el              ^^ single // XXX: bug in here
  | (axiom ~ axiom) ^^ mult
  ) /*aggregate h*/)

  def testParse(input: Rep[Input]) = {
    parse(input, (unit(0),unit(10000),unit(0)), h)
  }
}

class TestMatrixMult2 extends FileDiffSuite {

  val prefix = "test-out/"

  def testmatrixmult = {
    withOutFile(prefix+"lms2-matmult"){
      new MatrixMult2 with PackageExp with MyScalaCompile{ self =>

        val printWriter = new java.io.PrintWriter(System.out)
        val codegen = new ScalaGenPackage with ScalaGenVariables {
          val IR: self.type = self
        }

        analyze

        val input = scala.Array((1,2),(2,20),(20,2),(2,4),(4,2),(2,1),(1,7),(7,3)) // -> 1x3 matrix, 122 multiplications
        codegen.emitSource(testParse, "testParse", new java.io.PrintWriter(System.out))

        val progParse = compile(testParse)
        scala.Console.println(progParse(input))


      }
    }
    assertFileEqualsCheck(prefix+"lms2-matmult")
  }


  def testmatrixmultC = {
    withOutFile(prefix+"lms2-matmult-c"){
      new MatrixMult2 with PackageExp{ self =>

        val printWriter = new java.io.PrintWriter(System.out)

        val cCodegen = new CGenPackage with CGenVariables{
          val IR: self.type = self
        }

        analyze

        val input = scala.Array((1,2),(2,20),(20,2),(2,4),(4,2),(2,1),(1,7),(7,3)) // -> 1x3 matrix, 122 multiplications

        cCodegen.emitSource(testParse, "testParse", new java.io.PrintWriter(System.out))
        cCodegen.emitDataStructures(printWriter)


      }
    }
    assertFileEqualsCheck(prefix+"lms2-matmult-c")
  }
}