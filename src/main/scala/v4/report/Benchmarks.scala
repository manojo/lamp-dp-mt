package v4.report
import v4._
import v4.examples._

object Benchmarks extends App {
  // Matrix multiplication optimized for Scala
  object mm1 extends Signature with ADPParsers with CodeGen {
    type Alphabet = (Int,Int)
    type Answer = (Int,Int,Int) // rows, cost, columns
    override val h = minBy(cfun1((a:Answer)=>a._2,"a","return a._2;"))
    val single = cfun1((m:Alphabet)=>(m._1,0,m._2),"m","return (T3iii){m._1,0,m._2};")
    val mult = cfun2((l:Answer,r:Answer) => (l._1, l._2+r._2 + l._1*l._3*r._3, r._3),
                     "l,r",  "return (T3iii){l._1, l._2+r._2 + l._1*l._3*r._3, r._3};")
    val axiom:Tabulate = tabulate("M",( el ^^ single | (axiom ~ axiom) ^^ mult) aggregate h,true)
    override val tps=(manifest[Alphabet],manifest[Answer])
  }
  // Matrix multiplication optimized for CUDA
  object mm3 extends Signature with ADPParsers with CodeGen {
    type Alphabet = (Int,Int) // matrix as (rows, columns)
    type Answer = Int
    override val h = min[Int] _
    val single = cfun1((i: Alphabet) => 0,"i","return 0;")
    val mult = cfun5((i:Int,l:Answer,k:Int,r:Answer,j:Int) => l + r + in(i)._1 * in(k)._1 * in(j-1)._2,
                     "i,l,k,r,j","return l + r + _in1[i]._1 * _in1[k]._1 * _in1[j-1]._2;")
    val axiom:Tabulate = tabulate("M",( el ^^ single | (emptyi ~ axiom ~ emptyi ~ axiom ~ emptyi) ^^ mult ) aggregate h,true)
    override val tps=(manifest[Alphabet],manifest[Answer])
  }
  // Smith-Waterman
  object swat extends SWatGrammar with SWatAlgebra with CodeGen {
    override val tps = (manifest[Alphabet],manifest[Answer])
    override val bottomUp = true // reduces recursion
  }
  // RNAFold
  object fold extends v4.examples.RNAFoldGrammar with v4.examples.RNAFoldAlgebra with CodeGen {
    override val tps=(manifest[Alphabet],manifest[Answer])
    override val cudaSplit = 96
  }
  // Zuker MFE
  object zuker extends ZukerGrammar with ZukerMFE with CodeGen {
    override val tps = (manifest[Alphabet],manifest[Answer])
    override val cudaSplit = 320
  }
  object zuker_pp extends ZukerGrammar with ZukerPrettyPrint

  // ---------------------------------------------------------------------------

  def rna(size:Int) = zuker.convert(Utils.genRNA(size))
  def time[T](u:()=>T) { val start=System.currentTimeMillis; u()
    val d=System.currentTimeMillis-start; print(" %d.%03d".format(d/1000,d%1000)); System.out.flush; System.gc
  }

  // Sizes to benchmark
  val sizes = List(64,96,128,192,256,384,512,768,1024,1536,2048,3072,4096,6144,8192)
  zuker.setParams("src/librna/vienna/rna_turner2004.par")
  fold.setParams("src/librna/vienna/rna_turner2004.par")

  /*
  def zukerCmp(seq:String,scala:Boolean=false) {
    val s = zuker.convert(seq)
    val start=System.currentTimeMillis
    val (score,bt)=zuker.backtrack(s,scala).head
    val d=System.currentTimeMillis-start; println("Running time: %d.%03d".format(d/1000,d%1000));
    val res = zuker_pp.build(s,bt)+" (%6.2f)".format(score/100.0)
    val ref=Utils.refFold(seq,"src/librna/rfold")
    if (ref==res) println("Match")
    else println("\nSeq: "+seq+"\nRef: "+ref+"\nOur: "+res+"\n")
  }
  for (size <- sizes) for (i<-0 to 3) zukerCmp(Utils.genRNA(size))
  */

  for (size <- sizes) {
    val numS = (if (size>=2048) 8 else 15)
    val numC = if (size<=512) 20 else (if (size>=4096) 8 else 12)
    def runScala(n:Int,s:String,f:()=>Unit) = if (size<=4096) { f(); print("sprintf('%.3f',median(["); for (i<-0 until n) time(f); println(" ])) % Scala "+s+" ("+size+")") }
    def runCuda(n:Int,s:String,f:()=>Unit) = { f(); print("sprintf('%.3f',median(["); for (i<-0 until n) time(f); println(" ])) % Scala+CUDA "+s+" ("+size+")") }

    runCuda(numC,"MatrixMult3",()=>mm3.backtrack(Utils.genMats(size)))
    runScala(numS,"MatrixMult1",()=>mm1.backtrack(Utils.genMats(size),true))

    runCuda(numC,"Smith-Waterman",()=>swat.backtrack(Utils.genDNA(size),Utils.genDNA(size)))
    runScala(numS,"Smith-Waterman",()=>swat.backtrack(Utils.genDNA(size),Utils.genDNA(size),true))

    runCuda(numC,"Zuker",()=>zuker.backtrack(rna(size)))
    runScala(numS,"Zuker",()=>zuker.backtrack(rna(size),true))

    runCuda(numC,"RNAfold",()=>fold.backtrack(rna(size)))
    runScala(numS,"RNAfold",()=>fold.backtrack(rna(size),true))
  }
}
