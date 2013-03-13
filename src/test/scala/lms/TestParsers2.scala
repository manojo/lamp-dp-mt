/*package lms.v2

import lms._

import scala.virtualization.lms.common._
import java.io.PrintWriter
import java.io.StringWriter
import java.io.FileOutputStream

// Matrix multiplication algebra
trait MatMultAlgebra2 extends Parsers with Signature {
  type Alphabet = (Int,Int)
  type Answer = (Int, Int, Int)

  val mAlph = manifest[Alphabet]
  val mAns = manifest[Answer]

  def single(i:Rep[(Int,Int)]) = (i._1, unit(0), i._2)
  def mult(l:Rep[Answer], r:Rep[Answer]) = (l._1, l._2+r._2+l._1*l._3*r._3, r._3)
}

class TestParsers2 extends FileDiffSuite {

  val prefix = "test-out/"

  def testBottomUp1 = {
    withOutFile(prefix+"parsers2-bottomup1"){
      new MatMultAlgebra2 with ParsersPkg { self =>

        def h(x:Rep[Answer],y:Rep[Answer]) = if(x._2 < y._2) x else y
        val z = unit((-1,-1,-1))

        // Matrix multiplication grammar
        def grammar(in:Input):Rep[Answer] = {
          lazy val p:TabulatedParser = tabulate("mat",(
              el(in) ^^ single
            | (p +~+ p) ^^ {x: Rep[(Answer,Answer)] => mult(x._1,x._2)}
          ).aggregate(h,z))

          bottomUp(in,p)(mAlph, mAns)
        }

        // Now we compile and execute our program
        codegen.emitSource(grammar _, "test-bottomup4", new java.io.PrintWriter(System.out))
        val prog = compile(grammar)
        val res = prog(scala.Array((10,100),(100,5),(5,50)))
        scala.Console.println(res)

      }
    }
    assertFileEqualsCheck(prefix+"parsers2-bottomup1")
  }

}
*/