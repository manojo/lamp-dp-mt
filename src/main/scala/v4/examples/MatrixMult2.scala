package v4.examples
import v4._

// -----------------------------------------------
// Matrix chain multiplication variant
// -----------------------------------------------
// This grammar variant is slightly faster for CUDA
// slower in all other cases

trait MatrixSig2 extends Signature {
  type Alphabet = (Int,Int) // matrix as (rows, columns)
  type Answer = Int
  override val h = min[Int] _
  val tps=(manifest[Alphabet],manifest[Answer])

  def in(n:Int):Alphabet
  val single = cfun1((i: Alphabet) => 0,"i","return 0;")
  val mult = cfun5((i:Int,l:Answer,k:Int,r:Answer,j:Int) => l+r + in(i)._1*in(k)._1*in(j-1)._2,
                                        "i,l,k,r,j","return l+r + _in1[i]._1*_in1[k]._1*_in1[j-1]._2;")
}

trait MatrixGrammar2 extends ADPParsers with MatrixSig2 {
  val axiom:Tabulate = tabulate("M",(
    el ^^ single
  | (emptyi ~ axiom ~ emptyi ~ axiom ~ emptyi) ^^ mult
  ) aggregate h,true)
}

object MatrixMult2 extends MatrixGrammar2 with MatrixSig2 with CodeGen with App {
  override val cudaSharedInput=true

  def bench(size:Int,num:Int=1) {
    def pt(ms:Long) = "%3d.%03d".format(ms/1000,ms%1000)
    def run(name:String,f:Array[(Int,Int)]=>Unit) {
      Utils.reset; f(Utils.genMats(size)); // reset random number generator, warm-up
      val ts = (0 until num).map{_=> val m=Utils.genMats(size); val s=System.currentTimeMillis; f(m); System.currentTimeMillis-s }.sorted
      val med=if (ts.length%2==1) ts(ts.length/2) else (ts(ts.length/2)+ts(ts.length/2-1))/2
      println("%-20s : ".format(name)+" "+pt(med)+"  ["+pt(ts.head)+", "+pt(ts.last)+"]")
    }
    println("Benchmarks: chain of "+size+" matrices, median of "+num+" samples (BT enabled)")
    run("Scala-TopDown",mats=>backtrack(mats,psTopDown))
    run("Scala-BottomUp",mats=>backtrack(mats,psBottomUp))
    run("CPU",mats=>backtrack(mats,psCPU))
    run("CUDA",mats=>backtrack(mats,psCUDA))
    run("LMS-Scala",mats=>backtrack(mats,psScalaLMS))
    run("LMS-CPU",mats=>backtrack(mats,psCPU))
    run("LMS-CUDA",mats=>backtrack(mats,psCUDA))
  }
  bench(128,10)

  //override val benchmark = true
  /*
  val input = List((1,2),(2,20),(20,2),(2,4),(4,2),(2,1),(1,7),(7,3)).toArray // -> 1x3 matrix, 122 multiplications
  println(parse(input))

  Utils.runBenchmark(
    (n:Int)=>backtrack(Utils.genMats(n)),
    (n:Int)=>backtrack(Utils.genMats(n),psBottomUp)
  )
  */
}
