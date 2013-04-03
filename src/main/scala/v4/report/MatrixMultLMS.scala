package v4.report

import scala.virtualization.lms.common._
import scala.virtualization.lms.internal._

import v4._
import v4.examples._
import lms._

// +----------------------------------------------------------+
// |                                                          |
// |   DEPRECATED: see v4.examples.MatrixAlgebraLMS instead   |
// |                                                          |
// +----------------------------------------------------------+

// This example is broken due to the use of "Tuple.tX"
// instead of "Tuple._X" in lms.CGenTupleOps codegen

trait RepPackage extends NumericOpsExp with TupleOpsExp with MyScalaCompile with FunctionGen { self =>
  val codegen = new ScalaGenNumericOps with ScalaGenTupleOps { val IR: self.type = self }
  val cCodegen = new CGenNumericOps with lms.CGenTupleOps with CFatCodegen { val IR: self.type = self }
}

trait RepWorld extends NumericOps with TupleOps {
  type Alphabet = (Int, Int)
  type Answer = (Int, Int, Int)

  def hf(a: Rep[Answer]) :Rep[Int] = a._2
  def repSingle(a: Rep[Alphabet]): Rep[Answer] = (a._1, unit(0), a._2)
  def repMult(l: Rep[Answer], r: Rep[Answer]): Rep[Answer] =
    (l._1, l._2 + r._2 + l._1 * l._3 * r._3, r._3)
}

object MatrixMultLMS extends MatrixSig with MatrixGrammar
    with CodeGen with App {
  val tps=(manifest[Alphabet],manifest[Answer])
  override val benchmark = true // display timing measurements

  // Algebra is defined immediately in the concrete program
  type Answer = (Int, Int, Int)
  val concreteProg = new RepWorld with RepPackage
  override val h = minBy(concreteProg.gen(concreteProg.hf))
  val single = concreteProg.gen(concreteProg.repSingle)
  val mult = concreteProg.gen2(concreteProg.repMult)

  val input = List((1,2),(2,20),(20,2),(2,4),(4,2),(2,1),(1,7),(7,3)).toArray
  println(parse(input).head) // -> 1x3 matrix, 122 multiplications
}
