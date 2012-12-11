package v4.examples
import v4._

import librna.LibRNA
/*
object LibRNA { // Faking the library as there are SBT issues
  def setParams(s:String) {}
  def setSequence(s:String) {}
  def clear {}
  def termau_energy(i:Int, j:Int) = 0
  def hl_energy(i:Int, j:Int) = 0
  def hl_energy_stem(i:Int, j:Int) = 0
  def il_energy(i:Int, j:Int, k:Int, l:Int) = 0
  def bl_energy(bl:Int, i:Int, j:Int, br:Int, Xright:Int) = 0
  def br_energy(bl:Int, i:Int, j:Int, br:Int, Xleft:Int) = 0
  def sr_energy(i:Int, j:Int) = 0
  def sr_pk_energy(a:Byte, b:Byte, c:Byte, d:Byte) = 0
  def dl_energy(i:Int, j:Int) = 0
  def dr_energy(i:Int, j:Int, n:Int) = 0
  def dli_energy(i:Int, j:Int) = 0
  def dri_energy(i:Int, j:Int) = 0
  def ext_mismatch_energy(i:Int, j:Int, n:Int) = 0
  def ml_mismatch_energy(i:Int, j:Int) = 0
  def ml_energy = 0
  def ul_energy = 0
  def sbase_energy = 0
  def ss_energy(i:Int, j:Int) = 0
  def dl_dangle_dg(dangle:Byte, i:Byte, j:Byte) = 0
  def dr_dangle_dg(i:Byte, j:Byte, dangle:Byte) = 0
}
*/

// Zuker folding (Minimum Free Energy)
// ----------------------------------------------------------------------------
// Based on http://gapc.eu/grammar/adpfold.gap (gapc-2012.07.23/grammar/adpf.gap)
// See p.147 of "Parallelization of Dynamic Programming Recurrences in Computational Biology"
// Same coefficients as: http://www.tbi.univie.ac.at/~ivo/RNA/ (with parameters -noLP -d2)

trait ZukerSig extends Signature {
  type Alphabet = Char
  type SSeq = (Int,Int) // subsequence = subword
  def stackpairing(s:SSeq):Boolean

  // XXX: what if it's not Int bit int => position
  def sadd(lb:Int, e:Answer) : Answer
  def cadd(x:Answer, e:Answer) : Answer
  def dlr(lb:SSeq, e:Answer, rb:SSeq) : Answer
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
  def nil(d:Dummy) : Answer
}

trait ZukerMFE extends ZukerSig {
  type Answer = Int
  def size:Int
  def in(x:Int):Alphabet
  def basepairing(i:Int, j:Int):Boolean = {
    if (j<=i+1) false
    else (in(i),in(j-1)) match {
      case ('a','u') | ('u','a') | ('u','g') | ('g','c') | ('g','u') | ('c','g') => true
      case _ => false
    }
  }

  // Signature implementation
  def stackpairing(s:SSeq):Boolean = { val (i,j)=s; (i+3 < j) && basepairing(i,j) && basepairing(i+1,j-1) }

  // XXX: missing a lot of loops here
  // XXX: but on the other side the loops are implicit in gapc !!
  // XXX: read more in librna/rnalib.c, it seems we could get valuable information there
  def sadd(lb:Int, e:Answer) = e
  def cadd(x:Answer, e:Answer) = x + e
  def dlr(lb:SSeq, e:Answer, rb:SSeq) = e + LibRNA.ext_mismatch_energy(lb._1, rb._2, size) + LibRNA.termau_energy(lb._1, rb._2)
  def sr(lb:Int, e:Answer, rb:Int) = e + LibRNA.sr_energy(lb, rb)
  def hl(lb:Int, f1:Int, x:SSeq, f2:Int, rb:Int) = LibRNA.hl_energy(x._1,x._2) + LibRNA.sr_energy(lb, rb)
  def bl(lb:Int, f1:Int, x:SSeq, e:Answer, f2:Int, rb:Int) = e + LibRNA.bl_energy(lb,f1,f2,rb,x._2-x._1) + LibRNA.sr_energy(lb, rb)
  def br(lb:Int, f1:Int, e:Answer, x:SSeq, f2:Int, rb:Int) = e + LibRNA.br_energy(lb,f1,f2,rb,x._2-x._1) + LibRNA.sr_energy(lb, rb)
  def il(f1:Int, f2:Int, r1:SSeq, x:Answer, r2:SSeq, f3:Int, f4:Int) = x + LibRNA.il_energy(r1._1, r1._2, r2._1, r2._2) + LibRNA.sr_energy(f1, f4)
  def ml(lb:Int, f1:Int, x:Answer, f2:Int, rb:Int) = {
    LibRNA.ml_energy + LibRNA.ul_energy + x + LibRNA.termau_energy(f1, f2) +
    LibRNA.sr_energy(lb, rb) + LibRNA.ml_mismatch_energy(f1, f2)
  }
  def app(c1:Answer, c:Answer) = c1 + c
  def ul(c1:Answer) = LibRNA.ul_energy + c1
  def addss(c1:Answer, e:SSeq) = c1 + LibRNA.ss_energy(e._1,e._2)
  def ssadd(e:SSeq, x:Answer) = LibRNA.ul_energy + x + LibRNA.ss_energy(e._1,e._2)
  def nil(d:Dummy) = 0

  override val h = max[Answer] _
}

trait ZukerPrettyPrint extends ZukerSig {
  type Answer = String

  def stackpairing(s:SSeq):Boolean = true
  private def dots(s:SSeq,c:Char='.') = (0 until s._2-s._1).map{_=>c}.mkString

  def sadd(lb:Int, e:Answer) = "."+e
  def cadd(x:Answer, e:Answer) = x+e
  def dlr(lb:SSeq, e:Answer, rb:SSeq) = dots(lb,'_')+e+dots(rb,'_')
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
  def nil(d:Dummy) = ""
}

trait ZukerGrammar extends ADPParsers with ZukerSig {
  def BASE = eli
  def LOC = seq(1,-1)
  def REGION = seq _

  val struct:Tabulate = tabulate("st",(
      BASE   ~ struct ^^ { case (b,s) => sadd(b,s) }
    | dangle ~ struct ^^ { case (d,s) => cadd(d,s) }
    | empty           ^^ nil
    ) aggregate h);

  lazy val dangle = LOC ~ closed ~ LOC ^^ { case ((l,e),r) => dlr(l,e,r) }
  val closed:Tabulate = tabulate("cl", (stack | hairpin | leftB | rightB | iloop | multiloop) filter stackpairing aggregate h)

  lazy val stack   = BASE ~ closed ~ BASE ^^ { case ((l,e),r) => sr(l,e,r) }
  lazy val hairpin = BASE ~ BASE ~ REGION(3,-1) ~ BASE ~ BASE ^^ { case ((((lb,f1),x),f2),rb) => hl(lb,f1,x,f2,rb) }
  lazy val leftB   = BASE ~ BASE ~ REGION(1,30) ~ closed ~ BASE ~ BASE ^^ { case (((((lb,f1),x),e),f2),rb) => bl(lb,f1,x,e,f2,rb) } aggregate h
  lazy val rightB  = BASE ~ BASE ~ closed ~ REGION(1,30) ~ BASE ~ BASE ^^ { case (((((lb,f1),e),x),f2),rb) => br(lb,f1,e,x,f2,rb) } aggregate h
  lazy val iloop   = BASE ~ BASE ~ REGION(1,30) ~ closed ~ REGION(1,30) ~ BASE ~ BASE ^^ { case ((((((f1,f2),r1),x),r2),f3),f4) => il(f1,f2,r1,x,r2,f3,f4) } aggregate h

  lazy val multiloop = BASE ~ BASE ~ ml_comps ~ BASE ~ BASE ^^ { case ((((bl,f1),x),f2),br) => ml(bl,f1,x,f2,br) }
  val ml_comps:Tabulate = tabulate("ml",(
      BASE ~ ml_comps ^^ { case(b,s) => sadd(b,s) }
    | (dangle ^^ ul) ~ ml_comps1 ^^ { case(c1,c) => app(c1,c) }
    ) aggregate h)
  val ml_comps1:Tabulate = tabulate("ml1",(
      BASE ~ ml_comps ^^ { case(b,s) => sadd(b,s) }
    | (dangle ^^ ul) ~ ml_comps1 ^^ { case(c1,c) => app(c1,c) }
    | (dangle ^^ ul)
    | (dangle ^^ ul) ~ REGION(1,-1) ^^ { case(c1,e) => addss(c1,e) }
    ) aggregate h)

  val axiom = struct
}

object Zuker extends App {
  object mfe extends ZukerGrammar with ZukerMFE //with CodeGen
  object pretty extends ZukerGrammar with ZukerPrettyPrint
  def parse(s:String) = {
    LibRNA.setParams("src/librna/vienna/rna_turner2004.par")
    LibRNA.setSequence(s);
    val res=mfe.parse(s.toArray);
    val (score,bt) = mfe.backtrack(s.toArray).head;
    println("Score     : "+score);
    println("Backtrack : "+bt);
    println("Result    : "+pretty.build(s.toArray,bt));
    LibRNA.clear; res
  }

  println("Build JNI > sbt librna")
  println("Run using > sbt 'run-main v4.examples.Zuker'")
  // Having separate instances of sbt is required due to issue described in
  // http://codethesis.com/sites/default/index.php?servlet=4&content=2
  println("Coefficients are WRONG! Fix computations involving LibRNA")


  println(parse("guacgucaguacguacgugacugucagucaac"))

  // References for guacgucaguacguacgugacugucagucaac
  // GAPC  : -970   ((((((....)))))).((((.....))))..
  // Vienna: -9.50  ((((((....)))))).(((((...)))))..
}
