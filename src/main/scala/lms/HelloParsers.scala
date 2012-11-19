package lms

import scala.virtualization.lms.common._

trait Parsers extends ArrayOps with NumericOps with IfThenElse with LiftNumeric with Equal with BooleanOps{

  abstract class Parser extends ((Rep[Int], Rep[Int]) => Rep[Char]){inner =>

    def filter (p: (Rep[Int], Rep[Int]) => Rep[Boolean]) = new Parser {
      def apply(i: Rep[Int], j: Rep[Int]): Rep[Char] = if(p(i,j)) inner(i,j) else '-'
    }
  }


  def char(in: Rep[Array[Char]]) = new Parser{
    def apply(i: Rep[Int], j: Rep[Int]): Rep[Char] = if(i+1 == j) in(i) else '-'
  }

  def charf(in: Rep[Array[Char]], f: Rep[Char] => Rep[Boolean]) = char(in) filter { (i: Rep[Int], j: Rep[Int]) =>
    (i + 1 == j) && f(in(i))
  }

  def bla(in: Rep[Array[Char]]) : Rep[Char] = charf(in, x=> x == 'm')(0,1)

}

trait ParsersExp extends Parsers with ArrayOpsExp with LiftNumeric
    with NumericOpsExp with IfThenElseExp with EqualExp with BooleanOpsExp

object HelloParsers extends App {

  //import LoopsProgExp._

  val concreteProg = new Parsers with ParsersExp { self =>
    val codegen = new ScalaGenArrayOps with ScalaGenNumericOps with ScalaGenIfThenElse with ScalaGenBooleanOps
      with ScalaGenEqual{ val IR: self.type = self }

    codegen.emitSource(bla, "K", new java.io.PrintWriter(System.out))

  }

  //val f = (x:Rep[Double]) => fac(x) + fac(2.0 *x)
  //println(globalDefs.mkString("\n"))
  //println(f)
  //val p = new CudaGenNumericOps with CudaGenMathOps with CudaGenEqual with
  //  CudaGenIfThenElse with CudaGenFunctions { val IR: FacProgExp.type = FacProgExp }
}