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

  import scala.util.Random
  Random.setSeed(123456748299L)
  def rnd:Int = Math.abs(Random.nextInt)%253+1

  def genMats(n:Int) = {
    val s = Seq.fill(n)(rnd)
    (Seq(rnd) ++ s).zip(s).map{case(x,y)=>(x,y)/*unbox ints!!*/}.toArray
  }

  val sz=List(128,256,512,1024,2048,4096,8192)

  println("====( CUDA warm-up )==============================================")
  for (i<-0 until 2) backtrack(genMats(1024))
  println("====( CUDA )======================================================")
  for (s<-sz) {
    println("---- Size = "+s+" ----------------")
    for (i<-0 until (if (i>2048) 10 else 20)) backtrack(genMats(s))
  }
  println("====( Scala warm-up )=============================================")
  backtrack(genMats(512),true)
  println("====( Scala )=====================================================")
  for (s<-sz) {
    println("---- Size = "+s+" ----------------")
    for (i<-0 until (if (i>2048) 5 else 20)) backtrack(genMats(s),true)
  }
}
