package lms

import scala.virtualization.lms.common._

trait FacProg { this: NumericOps with MathOps with Functions with Equal with IfThenElse with LiftNumeric =>

  def fac: Rep[Double=>Double] = doLambda {
    n => if (n == 0) 1.0 else n * fac(n - 1.0)
  }

}

object TestFac extends App {
  object FacProgExp extends FacProg with LiftNumeric
    with NumericOpsExp with MathOpsExp with EqualExp with IfThenElseExp
    with FunctionsRecursiveExp
  import FacProgExp._

  val f = (x:Rep[Double]) => fac(x) + fac(2.0 *x)
  println(globalDefs.mkString("\n"))
  println(f)
  val p = new CudaGenNumericOps with CudaGenMathOps with CudaGenEqual with
    CudaGenIfThenElse with CudaGenFunctions { val IR: FacProgExp.type = FacProgExp }
  p.emitSource(f, "Fac", new java.io.PrintWriter(System.out))
}
