package v4.examples
import v4._

// Matrix chain multiplication.
// We make all compromises to be able to generate code.
// Ultimately, we might want to infer as much information as possible instead of making it explicit

trait MatrixAlgebraGen extends MatrixSig {
  type Answer = (Int,Int,Int) // rows, cost, columns

  override val h = minBy(cfun1((a:Answer)=>a._2,"a","return a._2;"))
  val single = cfun1((m:Alphabet)=>(m._1,0,m._2),"m","return (T3iii){m._1,0,m._2};")
  val mult = cfun2((l:Answer,r:Answer) => (l._1, l._2+r._2 + l._1*l._3*r._3, r._3),
                   "l,r", "return (T3iii){l._1, l._2+r._2 + l._1*l._3*r._3, r._3};")
}

// Code generator only
object MatrixMultGen extends MatrixGrammar with MatrixAlgebraGen with CodeGen with App {
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

  backtrack(input,true)
  backtrack(input,true)
  backtrack(input,true)
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
  /*
  Utils.runBenchmark(
    (n:Int)=>backtrack(Utils.genMats(n)),
    (n:Int)=>backtrack(Utils.genMats(n),true)
  )
  */
}
