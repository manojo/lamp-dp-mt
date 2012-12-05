package v3.examples
import v3._

// Zucker folding (Minimum Free Energy)
// ----------------------------------------------------------------------------
// Based on http://gapc.eu/grammar/adpfold.gap (gapc-2012.07.23/grammar/adpf.gap)
// See p.147 of "Parallelization of Dynamic Programming Recurrences in Computational Biology"
// Same coefficients as: http://www.tbi.univie.ac.at/~ivo/RNA/ (with parameters -noLP -d2)

trait ZuckerSig extends Signature {
  type Alphabet = Char
  type SSeq = (Int,Int) // subsequence = subword
  def stackpairing(s:SSeq):Boolean = true

  def sadd(lb:SSeq, e:Answer) : Answer
  def cadd(x:Answer, e:Answer) : Answer
  def dlr(lb:SSeq, e:Answer, rb:SSeq) : Answer
  def sr(lb:SSeq, e:Answer, rb:SSeq) : Answer
  def hl(lb:SSeq, f1:SSeq, x:SSeq, f2:SSeq, rb:SSeq) : Answer
  def bl(bl:SSeq, f1:SSeq, x:SSeq, e:Answer, f2:SSeq, br:SSeq) : Answer
  def br(bl:SSeq, f1:SSeq, e:Answer, x:SSeq, f2:SSeq, br:SSeq) : Answer
  def il(f1:SSeq, f2:SSeq, r1:SSeq, x:Answer, r2:SSeq, f3:SSeq, f4:SSeq) : Answer
  def ml(bl:SSeq, f1:SSeq, x:Answer, f2:SSeq, br:SSeq) : Answer
  def app(c1:Answer, c:Answer) : Answer
  def ul(c1:Answer) : Answer
  def addss(c1:Answer, e:SSeq) : Answer
  def ssadd(e:SSeq, x:Answer) : Answer
  def nil(d:Dummy) : Answer
}

trait ZuckerMFE extends ZuckerSig {
  type Answer = Int

  /*
  import librna.LibRNA
  def ul_energy() = LibRNA.ul_energy
  def ml_energy() = LibRNA.ml_energy
  def hl_energy(x:SSeq) = LibRNA.hl_energy(x._1,x._2)
  def ss_energy(e:SSeq) = LibRNA.ss_energy(e._1,e._2)
  */

  // energy functions (to implement)
  def ul_energy() = 0
  def ml_energy() = 0
  def hl_energy(x:SSeq) = 0
  def ss_energy(e:SSeq) = 0

  def sr_energy(bl:SSeq, br:SSeq) = 0
  def bl_energy(x:SSeq, f2:SSeq) = 0
  def br_energy(f1:SSeq, x:SSeq) = 0
  def il_energy(r1:SSeq, r2:SSeq) = 0
  def termau_energy(lb:SSeq, rb:SSeq) = 0
  def ext_mismatch_energy(lb:SSeq, rb:SSeq) = 0
  def ml_mismatch_energy(f1:SSeq, f2:SSeq) = 0

  def in(x:Int):Alphabet
  def basepairing(i:Int, j:Int):Boolean = {
    if (j<=i+1) false
    else (in(i),in(j-1)) match {
      case ('a','u') | ('u','a') | ('u','g') | ('g','c') | ('g','u') | ('c','g') => true
      case _ => false
    }
  }

  // Signature implementation
  override def stackpairing(s:SSeq):Boolean = { val (i,j)=s; (i+3 < j) && basepairing(i,j) && basepairing(i+1,j-1) }

  def sadd(lb:SSeq, e:Answer) = e
  def cadd(x:Answer, e:Answer) = x + e
  def dlr(lb:SSeq, e:Answer, rb:SSeq) = e + ext_mismatch_energy(lb, rb) + termau_energy(lb, rb)
  def sr(lb:SSeq, e:Answer, rb:SSeq) = e + sr_energy(lb, rb)
  def hl(lb:SSeq, f1:SSeq, x:SSeq, f2:SSeq, rb:SSeq) = hl_energy(x) + sr_energy(lb, rb)
  def bl(bl:SSeq, f1:SSeq, x:SSeq, e:Answer, f2:SSeq, br:SSeq) = e + bl_energy(x, f2) + sr_energy(bl, br)
  def br(bl:SSeq, f1:SSeq, e:Answer, x:SSeq, f2:SSeq, br:SSeq) = e + br_energy(f1, x) + sr_energy(bl, br)
  def il(f1:SSeq, f2:SSeq, r1:SSeq, x:Answer, r2:SSeq, f3:SSeq, f4:SSeq) = x + il_energy(r1, r2) + sr_energy(f1, f4)
  def ml(bl:SSeq, f1:SSeq, x:Answer, f2:SSeq, br:SSeq) = {
    ml_energy() + ul_energy() + x + termau_energy(f1, f2) + sr_energy(bl, br) + ml_mismatch_energy(f1, f2)
  }
  def app(c1:Answer, c:Answer) = c1 + c
  def ul(c1:Answer) = ul_energy() + c1
  def addss(c1:Answer, e:SSeq) = c1 + ss_energy(e)
  def ssadd(e:SSeq, x:Answer) = ul_energy() + x + ss_energy(e)
  def nil(d:Dummy) = 0

  override val h = min[Answer] _
}

trait ZuckerPrettyPrint extends ZuckerSig {
  type Answer = String

  private def dots(s:SSeq) = (0 until s._2-s._1).map{_=>"."}.mkString
  def sadd(lb:SSeq, e:Answer) = "."+e
  def cadd(x:Answer, e:Answer) = x+e
  def dlr(lb:SSeq, e:Answer, rb:SSeq) = e
  def sr(lb:SSeq, e:Answer, rb:SSeq) = "("+e+")"
  def hl(lb:SSeq, f1:SSeq, x:SSeq, f2:SSeq, rb:SSeq) = "(("+dots(x)+"))"
  def bl(bl:SSeq, f1:SSeq, x:SSeq, e:Answer, f2:SSeq, br:SSeq) = "(("+dots(x)+e+"))"
  def br(bl:SSeq, f1:SSeq, e:Answer, x:SSeq, f2:SSeq, br:SSeq) = "(("+e+dots(x)+"))"
  def il(f1:SSeq, f2:SSeq, r1:SSeq, x:Answer, r2:SSeq, f3:SSeq, f4:SSeq) = "(("+dots(r1)+x+dots(r2)+"))"
  def ml(bl:SSeq, f1:SSeq, x:Answer, f2:SSeq, br:SSeq) = "(("+x+"))"
  def app(c1:Answer, c:Answer) = c1+c
  def ul(c1:Answer) = c1
  def addss(c1:Answer, e:SSeq) = c1+dots(e)
  def ssadd(e:SSeq, x:Answer) = dots(e)+x
  def nil(d:Dummy) = ""
}

trait ZuckerGrammar extends ADPParsers with ZuckerMFE {
  def BASE = seq(1,1)
  def LOC = BASE // XXX: implement the difference
  def REGION = seq _ // XXX: no more restrictions? (like nonempty)

  def struct:Tabulate = tabulate("st",(
      BASE   -~~ struct ^^ { case (b,s) => sadd(b,s) }
    | dangle ~~~ struct ^^ { case (d,s) => cadd(d, s) }
    | empty             ^^ nil
    ) aggregate h);

  def dangle = LOC ~~~ closed ~~~ LOC ^^ { case ((l,e),r) => dlr(l,e,r) }
  def closed:Tabulate = tabulate("cl",(
    (stack | hairpin | leftB | rightB | iloop | multiloop) filter stackpairing
    ) aggregate h)

  def stack = BASE ~~~ closed ~~~ BASE ^^ { case ((l,e),r) => sr(l,e,r) }
  def hairpin = BASE ~~~ BASE ~~~ REGION(3,0) ~~~ BASE ~~~ BASE ^^ { case ((((lb,f1),x),f2),rb) => hl(lb,f1,x,f2,rb) }
  def leftB = BASE ~~~ BASE ~~~ REGION(0,30) ~~~ closed ~~~ BASE ~~~ BASE ^^ { case (((((lb,f1),x),e),f2),rb) => bl(lb,f1,x,e,f2,rb) } aggregate h
  def rightB = BASE ~~~ BASE ~~~ closed ~~~ REGION(0,30) ~~~ BASE ~~~ BASE ^^ { case (((((lb,f1),e),x),f2),rb) => br(lb,f1,e,x,f2,rb) } aggregate h
  def iloop = BASE ~~~ BASE ~~~ REGION(0,30) ~~~ closed ~~~ REGION(0,30) ~~~ BASE ~~~ BASE ^^ { case ((((((f1,f2),r1),x),r2),f3),f4) => il(f1,f2,r1,x,r2,f3,f4) } aggregate h

  def multiloop = BASE ~~~ BASE ~~~ ml_comps ~~~ BASE ~~~ BASE ^^ { case((((bl,f1),x),f2),br) => ml(bl,f1,x,f2,br) }
  def ml_comps:Tabulate = tabulate("ml",(
      BASE ~~~ ml_comps ^^ { case(b,s) => sadd(b,s) }
    | (dangle ^^ ul) ~~~ ml_comps1 ^^ { case(c1,c) => app(c1,c) }
    ) aggregate h)
  def ml_comps1:Tabulate = tabulate("m1",(
      BASE ~~~ ml_comps ^^ { case(b,s) => sadd(b,s) }
    | (dangle ^^ ul) ~~~ ml_comps1 ^^ { case(c1,c) => app(c1,c) }
    | dangle ^^ ul
    | (dangle ^^ ul) ~~~ REGION(0,0) ^^ { case(c1,e) => addss(c1,e) }
    ) aggregate h)
  /*
  tabulated { struct, closed, ml_comps, ml_comps1 }

  struct = sadd(BASE, struct) | cadd(dangle, struct) | nil(EMPTY) # h ;
  dangle = dlr(LOC, closed, LOC) ;
  closed = { stack | hairpin | leftB | rightB | iloop | multiloop } with stackpairing # h ;

  stack = sr(BASE, closed, BASE) ;
  hairpin = hl(BASE, BASE, { REGION with minsize(3) }, BASE, BASE) ;
  leftB = bl( BASE, BASE, REGION with maxsize(30), closed, BASE, BASE) # h ;
  rightB = br( BASE, BASE, closed, REGION with maxsize(30), BASE, BASE) # h ;
  iloop = il( BASE, BASE, REGION with maxsize(30), closed, REGION with maxsize(30), BASE, BASE) # h ;

  multiloop = ml( BASE, BASE, ml_comps, BASE, BASE) ;
  ml_comps = sadd(BASE, ml_comps) | app( { ul(dangle) } , ml_comps1) # h ;
  ml_comps1 = sadd(BASE, ml_comps1) | app(  ul(dangle)  , ml_comps1) |
              ul(dangle) | addss( ul(dangle), REGION)  # h ;
  */
}

object Zucker extends App /*with ZuckerGrammar with ZuckerAlgebra*/ {
  println("UNIMPLEMENTED")
}
