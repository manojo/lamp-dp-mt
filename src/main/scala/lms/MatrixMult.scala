package lms

import scala.virtualization.lms.common._
import scala.virtualization.lms.internal._
import java.io.{PrintWriter,StringWriter,FileOutputStream}

import v4._
import v4.examples._

/*
trait Parsers extends ArrayOps with MyListOps with NumericOps with IfThenElse
                 with LiftNumeric with Equal with BooleanOps with OrderingOps
                 with MathOps with HackyRangeOps with TupleOps

trait ParsersExp extends Parsers with ArrayOpsExp with MyListOpsExp with LiftNumeric
    with NumericOpsExp with IfThenElseExp with EqualExp with BooleanOpsExp
    with OrderingOpsExp with MathOpsExp with HackyRangeOpsExp with TupleOpsExp {this: Sig =>}

new ScalaGenArrayOps with ScalaGenMyListOps with ScalaGenNumericOps with ScalaGenIfThenElse with ScalaGenBooleanOps
    with ScalaGenEqual with ScalaGenOrderingOps with ScalaGenMathOps
    with ScalaGenHackyRangeOps with ScalaGenTupleOps
*/

trait RepWorld extends NumericOps with TupleOps {
  type Alphabet = (Int, Int)
  type Answer = (Int,Int,Int)

  def hf(a: Rep[Answer]) :Rep[Int] = a._2

  def repSingle(a: Rep[Alphabet]): Rep[Answer] =
    (a._1, unit(0), a._2)

  def repMult(l: Rep[Answer], r: Rep[Answer]): Rep[Answer] =
    (l._1, l._2 + r._2 + l._1 * l._3 * r._3, r._3)


}

//LMSMatrixMultGen extends MatrixGrammar with LMSMatrixAlgebraGen with CodeGen with App
object LMSMatrixAlgebraGen extends MatrixSig with MatrixGrammar with CodeGen with App{
  type Answer = (Int, Int, Int)

  override val benchmark = true
  override val tps=(manifest[Alphabet],manifest[Answer])

  val concreteProg = new RepWorld with NumericOpsExp with TupleOpsExp with MyScalaCompile with FunctionGen{self =>
    val codegen = new ScalaGenNumericOps with ScalaGenTupleOps{ val IR: self.type = self}
    val cCodegen = new CGenNumericOps with CGenTupleOps with CFatCodegen{ val IR: self.type = self}
    cCodegen.emitSource(repSingle, "F", new java.io.PrintWriter(System.out))
  }

  override val h = minBy(concreteProg.gen(concreteProg.hf))

  val single = concreteProg.gen(concreteProg.repSingle)
  val mult = concreteProg.gen2(concreteProg.repMult)
  println(gen)
}


/*object LMSMatrixMultGen extends MatrixGrammar with LMSMatrixAlgebraGen with CodeGen with App {
  //val input = List((1,2),(2,20),(20,2),(2,4),(4,2),(2,1),(1,7),(7,3)).toArray // -> 1x3 matrix, 122 multiplications
  def r(x:Int) = (x*2309 ^ (x+2)*947) % 173 + 3
  var input=(0 until 512 /*1024*/).map { x=>(r(x),r(x+1)) }.toArray
  // input size: 400-420 -> stack overflow with default settings
  //println(input)

  // ------- Extra codegen initialization
  override val benchmark = true
  override val tps=(manifest[Alphabet],manifest[Answer])
  // ------- Extra codegen initialization
  //println(gen)

  println("--- Scala:")
  println("1. Parsing")
  println(parse(input,true).head)
  println("2. Backtracking")
  val (res,bt) = backtrack(input,true).head
  println(res)
  println("3. Reconstructing from backtrack")
  println(build(input,bt))
  println("--- CUDA:")
  println("1. Parsing")
  println(parse(input).head)
  println("2. Backtracking")
  val (res2,bt2) = backtrack(input).head
  println(res2)
  println("3. Reconstructing from backtrack (Scala)")
  println(build(input,bt2))
}*/