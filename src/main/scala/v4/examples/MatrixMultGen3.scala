package v4.examples
import v4._

// Matrix chain multiplication.
// We make all compromises to be able to generate code.
// Ultimately, we might want to infer as much information as possible instead of making it explicit

trait MatrixSig3 extends Signature {
  type Alphabet = (Int,Int) // matrix as (rows, columns)
  type Answer = Int
  override val h = min[Int] _

  val single = new (Alphabet=>Answer) with CFun {
    def apply(i: Alphabet) = 0
    val args=List(("i","(Int,Int)"))
    val body="return 0;"
    val tpe ="Int"
  }

  def in(n:Int):Alphabet
  val mult = new ((Int,Answer,Int,Answer,Int)=>Answer) with CFun {
    def apply(i:Int,l:Answer,k:Int,r:Answer,j:Int) = l + r + in(i)._1 * in(k)._1 * in(j-1)._2
    val args=List(("i","Int"),("l","Int"),("k","Int"),("r","Int"),("j","Int"))
    val body = "return l + r + _in1[i]._1 * _in1[k]._1 * _in1[j-1]._2;"
    val tpe ="Int"
  }
}

trait MatrixGrammar3 extends ADPParsers with MatrixSig3 {
  val matrixGrammar:Tabulate = tabulate("M",(
    el ^^ single
  | (emptyi ~ matrixGrammar ~ emptyi ~ matrixGrammar ~ emptyi) ^^ mult
  ) aggregate h,true)

  val axiom=matrixGrammar
}

// Code generator only
object MatrixMultGen3 extends MatrixGrammar3 with MatrixSig3 with CodeGen with App {
  //val input = List((1,2),(2,20),(20,2),(2,4),(4,2),(2,1),(1,7),(7,3)).toArray // -> 1x3 matrix, 122 multiplications
  def r(x:Int) = (x*2309 ^ (x+2)*947) % 173 + 3
  var input=(0 until 1024).map { x=>(r(x),r(x+1)) }.toArray

  // ------- Extra codegen initialization
  override val benchmark = true
  override val tps=(manifest[Alphabet],manifest[Answer])
  // ------- Extra codegen initialization
  // println(gen)

  /*
  println("------ SCALA -------------------")
  val (res1,bt1) = backtrack(input,true).head
  println("--> "+res1)
  println("--> "+build(input,bt1))
  println("------ CUDA  -------------------")
  val (res2,bt2) = backtrack(input).head
  println("--> "+res2)
  println("--> "+build(input,bt2))
  */
  Utils.runBenchmark(
    (n:Int)=>backtrack(Utils.genMats(n)),
    (n:Int)=>backtrack(Utils.genMats(n),true)
  )
}
