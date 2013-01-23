package v4.examples
import v4._

// Matrix chain multiplication.
// We make all compromises to be able to generate code.
// Ultimately, we might want to infer as much information as possible instead of making it explicit

trait MatrixSig3 extends Signature {
  type Alphabet = (Int,Int) // matrix as (rows, columns)
  type Answer = Int
  override val h = min[Int] _

  def in(n:Int):Alphabet
  val single = cfun1((i: Alphabet) => 0,"i","return 0;")
  val mult = cfun5((i:Int,l:Answer,k:Int,r:Answer,j:Int) => l + r + in(i)._1 * in(k)._1 * in(j-1)._2,
                   "i,l,k,r,j","return l + r + _in1[i]._1 * _in1[k]._1 * _in1[j-1]._2;")
}

trait MatrixGrammar3 extends ADPParsers with MatrixSig3 {
  val matrixGrammar:Tabulate = tabulate("M",(
    el ^^ single
  | (emptyi ~ matrixGrammar ~ emptyi ~ matrixGrammar ~ emptyi) ^^ mult
  ) aggregate h,true)

  val axiom=matrixGrammar
}

object MatrixMultGen3 extends MatrixGrammar3 with MatrixSig3 with CodeGen with App {
  override val tps=(manifest[Alphabet],manifest[Answer]) // Extra codegen initialization
  override val benchmark = true
  /*
  val input = List((1,2),(2,20),(20,2),(2,4),(4,2),(2,1),(1,7),(7,3)).toArray // -> 1x3 matrix, 122 multiplications
  println(parse(input))

  Utils.runBenchmark(
    (n:Int)=>backtrack(Utils.genMats(n)),
    (n:Int)=>backtrack(Utils.genMats(n),true)
  )
  */
}
