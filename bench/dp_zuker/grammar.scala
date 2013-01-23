package v4.examples
import v4._

// Zuker folding (Minimum Free Energy)

trait ZukerSig extends RNASignature {
  type SSeq = (Int,Int) // = Subword
  val sadd:(Int, Answer) => Answer
  val cadd:(Answer, Answer) => Answer
  val dlr:(Int, Answer, Int) => Answer
  val sr:(Int, Answer, Int) => Answer
  val hl:(Int, Int, SSeq, Int, Int) => Answer
  val bl:(Int, Int, SSeq, Answer, Int, Int) => Answer
  val br:(Int, Int, Answer, SSeq, Int, Int) => Answer
  val il:(Int, Int, SSeq, Answer, SSeq, Int, Int) => Answer
  val ml:(Int, Int, Answer, Int, Int) => Answer
  val app:(Answer, Answer) => Answer
  val ul:(Answer) => Answer
  val addss:(Answer, SSeq) => Answer
  val nil : Unit => Answer
}

trait ZukerMFE extends ZukerSig {
  type Answer = Int
  import librna.LibRNA._

  val sadd = cfun2((lb:Int,e:Int) => e,    "lb,e", "return e;")
  val cadd = cfun2((x:Int,e:Int) => x + e, "x,e" , "return x+e;")
  val dlr = cfun3((lb:Int, e:Answer, rb:Int)=> e + ext_mismatch_energy(lb,rb-1) + termau_energy(lb,rb-1),
                  "lb,e,rb",           "return e + ext_mismatch_energy(lb,rb-1) + termau_energy(lb,rb-1);")
  val sr  = cfun3((lb:Int, e:Answer, rb:Int)=> e + sr_energy(lb,rb),
                  "lb,e,rb",           "return e + sr_energy(lb,rb);")
  val hl  = cfun5((lb:Int, f1:Int, x:SSeq, f2:Int, rb:Int) => hl_energy(f1,f2) + sr_energy(lb,rb),
                  "lb,f1,x,f2,rb",                    "return hl_energy(f1,f2) + sr_energy(lb,rb);")

  val bl  = cfun6((lb:Int, f1:Int, b:SSeq, x:Answer, f2:Int, rb:Int) => x + bl_energy(f1,b._1,b._2-1,f2,f2-1) + sr_energy(lb,rb),
                  "lb,f1,b,x,f2,rb",                            "return x + bl_energy(f1,b._1,b._2-1,f2,f2-1) + sr_energy(lb,rb);")
  val br  = cfun6((lb:Int, f1:Int, x:Answer, b:SSeq, f2:Int, rb:Int) => x + br_energy(f1,b._1,b._2-1,f2,f1+1) + sr_energy(lb,rb),
                  "lb,f1,x,b,f2,rb",                            "return x + br_energy(f1,b._1,b._2-1,f2,f1+1) + sr_energy(lb,rb);")

  val il  = cfun7((f1:Int, f2:Int, r1:SSeq, x:Answer, r2:SSeq, f3:Int, f4:Int) => x + il_energy(f2,r1._2,r2._1-1,f3) + sr_energy(f1,f4),
                  "f1,f2,r1,x,r2,f3,f4",                                  "return x + il_energy(f2,r1._2,r2._1-1,f3) + sr_energy(f1,f4);")
  val ml  = cfun5((lb:Int, f1:Int, x:Answer, f2:Int, rb:Int) => ml_energy + ul_energy + x + termau_energy(f1,f2) + sr_energy(lb,rb) + ml_mismatch_energy(f1,f2),
                  "lb,f1,x,f2,rb",                  "return ml_energy() + ul_energy() + x + termau_energy(f1,f2) + sr_energy(lb,rb) + ml_mismatch_energy(f1,f2);")
  val app = cfun2((c1:Int, c:Int)=> c1+c,  "c1,c", "return c1+c;")
  val ul  = cfun1((c1:Int)=> ul_energy+c1, "c1",   "return ul_energy()+c1;")
  val addss=cfun2((c1:Int, e:SSeq)=> c1,   "c1,e", "return c1;")
  val nil = cfun1((d:Unit)=>0,"","return 0;")
  override val h = min[Answer] _
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
    ) aggregate h, true); // always nonempty

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
      BASE ~ ml_comps1 ^^ sadd
    | (dangle ^^ ul) ~ ml_comps1 ^^ app
    | dangle ^^ ul
    | (dangle ^^ ul) ~ REG ^^ addss
    ) aggregate h)
  val axiom = struct
}

object Zuker extends App with  ZukerGrammar with ZukerMFE with CodeGen {
  override val benchmark = true
  override val tps = (manifest[Alphabet],manifest[Answer])
  override val cudaSplit = 320

  setParams("src/librna/vienna/rna_turner2004.par")
  def parse(s:String) = {
    val seq=mfe.convert(s)
    val (score,bt) = mfe.backtrack(seq).head
    (pretty.build(seq,bt)+" (%6.2f)".format(score/100.0),bt)
  }

  parse(convert(Utils.genRNA(128)))
}
