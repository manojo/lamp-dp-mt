package v4.examples
import v4._

// Zuker folding (Minimum Free Energy)
// ----------------------------------------------------------------------------
// Based on http://gapc.eu/grammar/adpfold.gap (gapc-2012.07.23/grammar/adpf.gap)
// See p.147 of "Parallelization of Dynamic Programming Recurrences in Computational Biology"
// Same coefficients as: http://www.tbi.univie.ac.at/~ivo/RNA/ (with parameters -noLP -d2)

trait ZukerSig extends Signature with LibRNA {
  type Alphabet = Char
  type SSeq = (Int,Int) // = Subword

  def sadd(lb:Int, e:Answer) : Answer
  def cadd(x:Answer, e:Answer) : Answer
  def dlr(lb:Int, e:Answer, rb:Int) : Answer
  def sr(lb:Int, e:Answer, rb:Int) : Answer
  def hl(lb:Int, f1:Int, x:SSeq, f2:Int, rb:Int) : Answer
  def bl(lb:Int, f1:Int, b:SSeq, x:Answer, f2:Int, rb:Int) : Answer
  def br(lb:Int, f1:Int, x:Answer, b:SSeq, f2:Int, rb:Int) : Answer
  def il(f1:Int, f2:Int, r1:SSeq, x:Answer, r2:SSeq, f3:Int, f4:Int) : Answer
  def ml(bl:Int, f1:Int, x:Answer, f2:Int, rb:Int) : Answer
  def app(c1:Answer, c:Answer) : Answer
  def ul(c1:Answer) : Answer
  def addss(c1:Answer, e:SSeq) : Answer
  def ssadd(e:SSeq, x:Answer) : Answer
  def nil(d:Unit) : Answer
}

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
  private def dots(s:SSeq,c:Char='.') = (0 until s._2-s._1).map{_=>c}.mkString
  def sadd(lb:Int, e:Answer) = "."+e
  def cadd(x:Answer, e:Answer) = x+e
  def dlr(lb:Int, e:Answer, rb:Int) = e
  def sr(lb:Int, e:Answer, rb:Int) = "("+e+")"
  def hl(lb:Int, f1:Int, x:SSeq, f2:Int, rb:Int) = "(("+dots(x)+"))"
  def bl(lb:Int, f1:Int, x:SSeq, e:Answer, f2:Int, rb:Int) = "(("+dots(x)+e+"))"
  def br(lb:Int, f1:Int, e:Answer, x:SSeq, f2:Int, rb:Int) = "(("+e+dots(x)+"))"
  def il(f1:Int, f2:Int, r1:SSeq, x:Answer, r2:SSeq, f3:Int, f4:Int) = "(("+dots(r1)+x+dots(r2)+"))"
  def ml(bl:Int, f1:Int, x:Answer, f2:Int, rb:Int) = "(("+x+"))"
  def app(c1:Answer, c:Answer) = c1+c
  def ul(c1:Answer) = c1
  def addss(c1:Answer, e:SSeq) = c1+dots(e)
  def ssadd(e:SSeq, x:Answer) = dots(e)+x
  def nil(d:Unit) = ""
}

trait ZukerMFE extends ZukerSig {
  type Answer = Int
  def sadd(lb:Int, e:Answer) = e
  def cadd(x:Answer, e:Answer) = x + e
  def dlr(lb:Int, e:Answer, rb:Int) = e + ext_mismatch_energy(lb, rb-1) + termau_energy(lb, rb-1) // OK
  def sr(lb:Int, e:Answer, rb:Int) = e + sr_energy(lb,rb) // OK
  def hl(lb:Int, f1:Int, x:SSeq, f2:Int, rb:Int) = hl_energy(f1,f2) + sr_energy(lb, rb) // OK
  def bl(lb:Int, f1:Int, b:SSeq, x:Answer, f2:Int, rb:Int) = x + bl_energy(f1,b._1,b._2-1,f2,f2-1) + sr_energy(lb, rb) // OK
  def br(lb:Int, f1:Int, x:Answer, b:SSeq, f2:Int, rb:Int) = x + br_energy(f1,b._1,b._2-1,f2,f1+1) + sr_energy(lb, rb) // OK
  def il(f1:Int, f2:Int, r1:SSeq, x:Answer, r2:SSeq, f3:Int, f4:Int) = x + il_energy(f2,r1._2,r2._1-1,f3) + sr_energy(f1, f4) // OK
  def ml(lb:Int, f1:Int, x:Answer, f2:Int, rb:Int) = ml_energy() + ul_energy() + x + termau_energy(f1, f2) + sr_energy(lb, rb) + ml_mismatch_energy(f1,f2)
  def app(c1:Answer, c:Answer) = c1 + c
  def ul(c1:Answer) = ul_energy() + c1
  def addss(c1:Answer, e:SSeq) = c1 // + ss_energy(e._1,e._2-1)=0 OK
  def ssadd(e:SSeq, x:Answer) = ul_energy() + x // + ss_energy(e._1,e._2-1)=0 OK
  def nil(d:Unit) = 0
  override val h = min[Answer] _
}

trait ZukerExplain extends ZukerSig {
  type Answer = String

  private def dots(s:SSeq,c:Char='.') = (0 until s._2-s._1).map{_=>c}.mkString
  def sadd(lb:Int, e:Answer) = "."+e +" sadd"
  def cadd(x:Answer, e:Answer) = x+e +" cadd"
  def dlr(lb:Int, e:Answer, rb:Int) = e + " dlr"+(lb,rb)
  def sr(lb:Int, e:Answer, rb:Int) = "("+e+")"  +" sr"
  def hl(lb:Int, f1:Int, x:SSeq, f2:Int, rb:Int) = "{"+lb+","+rb+"}"
  def bl(lb:Int, f1:Int, x:SSeq, e:Answer, f2:Int, rb:Int) = "(("+dots(x)+e+"))"  +" lb"
  def br(lb:Int, f1:Int, e:Answer, x:SSeq, f2:Int, rb:Int) = "(("+e+dots(x)+"))"  +" br"
  def il(f1:Int, f2:Int, r1:SSeq, x:Answer, r2:SSeq, f3:Int, f4:Int) = "(("+dots(r1)+x+dots(r2)+"))"  +" il"
  def ml(bl:Int, f1:Int, x:Answer, f2:Int, rb:Int) = "(("+x+"))"  +" ml"+(bl,rb)
  def app(c1:Answer, c:Answer) = c1+c  +" app"
  def ul(c1:Answer) = c1  +" ul"
  def addss(c1:Answer, e:SSeq) = c1+dots(e) +" addss"
  def ssadd(e:SSeq, x:Answer) = dots(e)+x   +" ssadd"
  def nil(d:Unit) = ""  +" nil"
}

trait ZukerGrammar extends ADPParsers with ZukerSig {
  val BASE = eli
  val LOC = emptyi
  val REG = seq()
  val REG3 = seq(3,maxN)
  val REG30 = seq(1,30)

  val struct:Tabulate = tabulate("st",(
      BASE   ~ struct ^^ sadd
    | dangle ~ struct ^^ cadd
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
    | dangle ^^ ul
    | (dangle ^^ ul) ~ REG ^^ addss
    ) aggregate h)

  val axiom = struct
}

object Zuker extends App {
  object mfe extends ZukerGrammar with ZukerMFE
  object pretty extends ZukerGrammar with ZukerPrettyPrint
  object count extends ZukerGrammar with ZukerCount
  object explain extends ZukerGrammar with ZukerExplain

  mfe.setParams("src/librna/vienna/rna_turner2004.par")
  def parse(s:String) = {
    mfe.setSequence(s);
    val seq=s.toArray
    val (score,bt) = mfe.backtrack(seq).head;
    val res = pretty.build(seq,bt)
    mfe.clear; (score,bt,res)
  }

  def testSeq(seq:String) {
    val (score,bt,res)=parse(seq)
    val ref=mfe.refFold(seq,"src/librna/rnafold/RNAfold")
    val our=res+" (%6.2f)".format(score/100.0)
    if (ref==our) print(".")
    else println("\nSeq: "+seq+"\nRef: "+ref+"\nOur: "+res+" (%6.2f)".format(score/100.0)+" FAILED\n"+explain.build(seq.toArray,bt)+"\n")

  }

  // Having separate JVM instances is required due to issue described in
  // http://codethesis.com/sites/default/index.php?servlet=4&content=2
  // Note that sbt execute the program in the same JVM
  // PART 1: moved into v4.examples.Test
  // PART 2: some failing sequences
  testSeq("gggcgcucaaccgagucagcagugcaauauagggccc")
  testSeq("augggcgcucaacucuccgugaauuugaaugagucagcagugcaauauagggcccucauc")
  testSeq("accacuccucauuugacuuauaggcucagaauuaguagaccacaguucacugugaaagga")
  testSeq("uugcccuaugucaaacauaugucgcaaagcacacgucguauucaccacgaucaaccaggg")
  testSeq("ccgaugccagcgucugcgccuucgccuaagggggagaagaagcucucccauaacggcaug")
  /*
  for (k<-0 until 100) testSeq(genSeq(60))
  */
}
