package v4.examples
import v4._

// Matrix chain multiplication.
// We make all compromises to be able to generate code.
// Ultimately, we might want to infer as much information as possible instead of making it explicit

trait MatrixAlgebraGen extends MatrixSig {
  type Answer = (Int,Int,Int) // rows, cost, columns

  val hf = new (Answer=>Int) with CFun {
    def apply(a:Answer) = a._2
    val args=List(("a","(Int,Int,Int)"))
    val body="return a._2;"
    val tpe ="Int"
  }
  override val h = minBy(hf)

  val single = new (Alphabet=>Answer) with CFun {
    def apply(i: Alphabet) = (i._1, 0, i._2)
    val args=List(("i","(Int,Int)"))
    val body="return (T3iii){i._1,0,i._2};"
    val tpe ="(Int,Int,Int)"
  }
  val mult = new ((Answer,Answer)=>Answer) with CFun {
    def apply(l:Answer,r:Answer) = { val ((r1,m1,c1),(r2,m2,c2))=(l,r); (r1, m1 + m2 + r1 * c1 * c2, c2) }
    val args=List(("l","(Int,Int,Int)"),("r","(Int,Int,Int)"))
    val body = "return (T3iii){l._1, l._2 + r._2 + l._1 * l._3 * r._3, r._3};"
    val tpe ="(Int,Int,Int)"
  }
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

  println("------ SCALA -------------------")
  val (res1,bt1) = backtrack(input,true).head
  println("--> "+res1)
  println("--> "+build(input,bt1))
  println("------ CUDA  -------------------")
  val (res2,bt2) = backtrack(input).head
  println("--> "+res2)
  println("--> "+build(input,bt2))
}
