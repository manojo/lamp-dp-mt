package v4.examples
import v4._

import librna.LibRNA

// Zuker folding (Minimum Free Energy)
// ----------------------------------------------------------------------------
// Based on http://gapc.eu/grammar/adpfold.gap (gapc-2012.07.23/grammar/adpf.gap)
// See p.147 of "Parallelization of Dynamic Programming Recurrences in Computational Biology"
// Same coefficients as: http://www.tbi.univie.ac.at/~ivo/RNA/ (with parameters -noLP -d2)

trait ZukerSig extends Signature {
  type Alphabet = Char
  type SSeq = (Int,Int) // = Subword

  def sadd(lb:Int, e:Answer) : Answer
  def cadd(x:Answer, e:Answer) : Answer
  def dlr(lb:Int, e:Answer, rb:Int) : Answer
  def sr(lb:Int, e:Answer, rb:Int) : Answer
  def hl(lb:Int, f1:Int, x:SSeq, f2:Int, rb:Int) : Answer
  def bl(lb:Int, f1:Int, x:SSeq, e:Answer, f2:Int, rb:Int) : Answer
  def br(lb:Int, f1:Int, e:Answer, x:SSeq, f2:Int, rb:Int) : Answer
  def il(f1:Int, f2:Int, r1:SSeq, x:Answer, r2:SSeq, f3:Int, f4:Int) : Answer
  def ml(bl:Int, f1:Int, x:Answer, f2:Int, rb:Int) : Answer
  def app(c1:Answer, c:Answer) : Answer
  def ul(c1:Answer) : Answer
  def addss(c1:Answer, e:SSeq) : Answer
  def ssadd(e:SSeq, x:Answer) : Answer
  def nil(d:Unit) : Answer

  def size:Int
  def in(x:Int):Alphabet
  def basepairing(i:Int, j:Int):Boolean = if (i+2>j) false else (in(i),in(j-1)) match {
    case ('a','u') | ('u','a') | ('u','g') | ('g','u') | ('g','c') | ('c','g') => true
    case _ => false
  }
  def stackpairing(s:SSeq):Boolean = { val (i,j)=s; (i+3 < j) && basepairing(i,j) && basepairing(i+1,j-1) }
}

trait ZukerMFE extends ZukerSig {
  type Answer = Int

  // Read more in librna/rnalib.c, we could get valuable information there
  def sadd(lb:Int, e:Answer) = e
  def cadd(x:Answer, e:Answer) = x + e
  def dlr(lb:Int, e:Answer, rb:Int) = e + LibRNA.ext_mismatch_energy(lb, rb-1, size) + LibRNA.termau_energy(lb, rb-1)

  def sr(lb:Int, e:Answer, rb:Int) = e + LibRNA.sr_energy(lb,rb)
  def hl(lb:Int, f1:Int, x:SSeq, f2:Int, rb:Int) = LibRNA.hl_energy(f1,f2) + LibRNA.sr_energy(lb, rb)

  // XXX: maybe an indexing issue there ?
  def bl(lb:Int, f1:Int, x:SSeq, e:Answer, f2:Int, rb:Int) = e + LibRNA.bl_energy(lb,f1,f2,rb,x._2-x._1) + LibRNA.sr_energy(lb, rb)
  def br(lb:Int, f1:Int, e:Answer, x:SSeq, f2:Int, rb:Int) = e + LibRNA.br_energy(lb,f1,f2,rb,x._2-x._1) + LibRNA.sr_energy(lb, rb)

  def il(f1:Int, f2:Int, r1:SSeq, x:Answer, r2:SSeq, f3:Int, f4:Int) = x + LibRNA.il_energy(r1._1, r1._2-1, r2._1, r2._2-1) + LibRNA.sr_energy(f1, f4)
  def ml(lb:Int, f1:Int, x:Answer, f2:Int, rb:Int) = {
    LibRNA.ml_energy + LibRNA.ul_energy + x + LibRNA.termau_energy(f1, f2) + LibRNA.sr_energy(lb, rb) + LibRNA.ml_mismatch_energy(f1, f2)
  }
  def app(c1:Answer, c:Answer) = c1 + c
  def ul(c1:Answer) = LibRNA.ul_energy + c1
  def addss(c1:Answer, e:SSeq) = c1 + LibRNA.ss_energy(e._1,e._2-1)
  def ssadd(e:SSeq, x:Answer) = LibRNA.ul_energy + x + LibRNA.ss_energy(e._1,e._2-1)
  def nil(d:Unit) = 0

  override val h = min[Answer] _
}
/*
  int bl(Subsequence bl, Subsequence f1, Subsequence x, int e, Subsequence f2, Subsequence br) = e + bl_energy(x, f2) + sr_energy(bl, br)
  int br(Subsequence bl, Subsequence f1, int e, Subsequence x, Subsequence f2, Subsequence br) = e + br_energy(f1, x) + sr_energy(bl, br)
  int il(Subsequence f1, Subsequence f2, Subsequence r1, int x, Subsequence r2, Subsequence f3, Subsequence f4) = x + il_energy(r1, r2) + sr_energy(f1, f4)
  int ml(Subsequence bl, Subsequence f1, int x, Subsequence f2, Subsequence br) = ml_energy() + ul_energy() + x + termau_energy(f1, f2) + sr_energy(bl, br) + ml_mismatch_energy(f1, f2)
*/

trait ZukerCount extends ZukerSig {
  type Answer = Int
  def sadd(lb:Int, e:Answer) = e
  def cadd(x:Answer, e:Answer) = x * e
  def dlr(lb:Int, e:Answer, rb:Int) = e
  def sr(lb:Int, e:Answer, rb:Int) = e
  def hl(lb:Int, f1:Int, x:SSeq, f2:Int, rb:Int) = 1
  def bl(lb:Int, f1:Int, x:SSeq, e:Answer, f2:Int, rb:Int) = e
  def br(lb:Int, f1:Int, e:Answer, x:SSeq, f2:Int, rb:Int) = e
  def il(f1:Int, f2:Int, r1:SSeq, x:Answer, r2:SSeq, f3:Int, f4:Int) = x
  def ml(lb:Int, f1:Int, x:Answer, f2:Int, rb:Int) = x
  def app(c1:Answer, c:Answer) = c1 * c
  def ul(c1:Answer) = c1
  def addss(c1:Answer, e:SSeq) = c1
  def ssadd(e:SSeq, x:Answer) = x
  def nil(d:Unit) = 1
  override val h = sum[Answer] _
}

trait ZukerPrettyPrint extends ZukerSig {
  type Answer = String

  //def stackpairing(s:SSeq):Boolean = true
  private def dots(s:SSeq,c:Char='.') = (0 until s._2-s._1).map{_=>c}.mkString

  def sadd(lb:Int, e:Answer) = "."+e   +" sadd"
  def cadd(x:Answer, e:Answer) = x+e   +" cadd"
  def dlr(lb:Int, e:Answer, rb:Int) = e
  def sr(lb:Int, e:Answer, rb:Int) = "("+e+")"  +" sr"
  def hl(lb:Int, f1:Int, x:SSeq, f2:Int, rb:Int) = "(("+dots(x)+"))"  +" hl"
  def bl(lb:Int, f1:Int, x:SSeq, e:Answer, f2:Int, rb:Int) = "(("+dots(x)+e+"))"  +" lb"
  def br(lb:Int, f1:Int, e:Answer, x:SSeq, f2:Int, rb:Int) = "(("+e+dots(x)+"))"  +" br"
  def il(f1:Int, f2:Int, r1:SSeq, x:Answer, r2:SSeq, f3:Int, f4:Int) = "(("+dots(r1)+x+dots(r2)+"))"  +" il"
  def ml(bl:Int, f1:Int, x:Answer, f2:Int, rb:Int) = "(("+x+"))"  +" ml"
  def app(c1:Answer, c:Answer) = c1+c  +" app"
  def ul(c1:Answer) = c1  +" ul"
  def addss(c1:Answer, e:SSeq) = c1+dots(e) +" addss"
  def ssadd(e:SSeq, x:Answer) = dots(e)+x   +" ssadd"
  def nil(d:Unit) = "" +" nil"
}

trait ZukerGrammar extends ADPParsers with ZukerSig {
  val BASE = eli
  val LOC = emptyi
  val REG = seq(2,-1)
  val REG3 = seq(3,-1)
  val REG30 = seq(2,30)

  val struct:Tabulate = tabulate("st",(
      BASE   ~ struct ^^ { case (b,s) => sadd(b,s) }
    | dangle ~ struct ^^ { case (d,s) => cadd(d,s) }
    | empty           ^^ nil
    ) aggregate h);

  lazy val dangle = LOC ~ closed ~ LOC ^^ dlr
  val closed:Tabulate = tabulate("cl", (stack | hairpin | leftB | rightB | iloop | multiloop) filter stackpairing aggregate h)

  lazy val stack   = BASE ~ closed ~ BASE ^^ sr
  lazy val hairpin = BASE ~ BASE ~ REG3 ~ BASE ~ BASE ^^ hl
  lazy val leftB   = BASE ~ BASE ~ REG30 ~ closed ~ BASE ~ BASE ^^ bl aggregate h
  lazy val rightB  = BASE ~ BASE ~ closed ~ REG30 ~ BASE ~ BASE ^^ br aggregate h
  lazy val iloop   = BASE ~ BASE ~ REG30 ~ closed ~ REG30 ~ BASE ~ BASE ^^ il aggregate h

  lazy val multiloop = BASE ~ BASE ~ ml_comps ~ BASE ~ BASE ^^ ml
  val ml_comps:Tabulate = tabulate("ml",(
      BASE ~ ml_comps ^^ sadd
    | (dangle ^^ ul) ~ ml_comps1 ^^ app
    ) aggregate h)
  val ml_comps1:Tabulate = tabulate("ml1",(
      BASE ~ ml_comps ^^ sadd
    | (dangle ^^ ul) ~ ml_comps1 ^^ app
    | (dangle ^^ ul)
    | (dangle ^^ ul) ~ REG ^^ addss
    ) aggregate h)

  val axiom = struct
}

object Zuker extends App {
  object mfe extends ZukerGrammar with ZukerMFE
  object pretty extends ZukerGrammar with ZukerPrettyPrint
  object count extends ZukerGrammar with ZukerCount
  def parse(s:String) = {
    LibRNA.setParams("src/librna/vienna/rna_turner2004.par")
    LibRNA.setSequence(s);
    val seq=s.toArray
    val (score,bt) = mfe.backtrack(seq).head;
    val res = pretty.build(seq,bt)
    LibRNA.clear; (score,bt,res)
  }

  def run(seq:String):String = {
    import java.io._
    val p = Runtime.getRuntime.exec("src/librna/rnafold/RNAfold -P src/librna/vienna/rna_turner2004.par");
    val in = new PrintStream(p.getOutputStream());
    def gobble(in:InputStream) = new Runnable {
      var out = new StringBuilder
      var thr = new Thread(this); thr.start
      override def toString = { thr.join; out.toString.trim }
      override def run { val r = new BufferedReader(new InputStreamReader(in))
        var l = r.readLine; while(l != null) { out.append(l+"\n"); l = r.readLine }; r.close
      }
    }
    val out=gobble(p.getInputStream);
    in.println(seq); in.close
    p.waitFor; out.toString
  }

  def testSeq(seq:String) {
    val (score,bt,res)=parse(seq)
    /*
    println("Score     : "+score)
    println("Backtrack : "+bt)
    println("Result    : "+res)
    println("Count     : "+count.parse(seq.toArray).head)
    */
    println(run(seq)+"\n"+res+" (%6.2f)".format(score/100.0)+"\n")
  }

  // Having separate instances of sbt is required due to issue described in
  // http://codethesis.com/sites/default/index.php?servlet=4&content=2
  println("Coefficients are WRONG! Fix computations involving LibRNA")

  testSeq("ccuuuuucaaagg")
  // Sequence : ccuuuuucaaagg
  // ViennaRNA: (((((...))))) ( -1.30)
  // Our      : (((((...))))) ( -1.30)
  // GAPC     : (((((...))))) ( -1.30)

  testSeq("guacgucaguacguacgugacugucagucaac")
  // Sequence : guacgucaguacguacgugacugucagucaac
  // ViennaRNA: ((((((....)))))).(((((...))))).. (-9.50)
  // Our      : ((((((....)))))).(((((...))))).. (-9.50)
  // GAPC     : ((((((....)))))).((((.....)))).. (-9.70)

  testSeq("aaaaaagggaaaagaacaaaggagacucuucuccuuuuucaaaggaagaggagacucuuucaaaaaucccucuuuu")
  // Sequence : aaaaaagggaaaagaacaaaggagacucuucuccuuuuucaaaggaagaggagacucuuucaaaaaucccucuuuu
  // ViennaRNA: .....(((((........((((((.((((((((((((...))))).))))))).))))))......)))))..... (-25.00)
  // Our      : .((..(((((........((((((..((((((..(((....)))..))))))..))))))......)))))..)). (-24.80)
  // GAPC(1)  : .....(((((........((((((.((((((((((((...))))).))))))).))))))......)))))..... (-25.00)
  // GAPC(2)  : .....(((((........((((((.((((((((((((...)))))).)))))).))))))......)))))..... (-25.00)
}
