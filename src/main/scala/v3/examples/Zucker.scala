package v3.examples
import v3._

// Zucker folding
// --------------
// See p.147 of "Parallelization of Dynamic Programming Recurrences in Computational Biology"
// Correct coefficients can be obtained at: http://www.tbi.univie.ac.at/~ivo/RNA/
// Have a look in the *.par files of Vienna RNA (>250Kb plain text coefficients !)
// Grammar from gapc/grammar2/adpfiupac.gap

trait ZuckerSig extends Signature {
  type Alphabet = Char
  type SSeq = (Int,Int) // subsequence = subword

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

trait ZuckerBasePairMax extends ZuckerSig {
  type Answer = Int

  def sadd(lb:SSeq, e:Answer) = e
  def cadd(x:Answer, e:Answer) = x + e
  def dlr(lb:SSeq, e:Answer, rb:SSeq) = e
  def sr(lb:SSeq, e:Answer, rb:SSeq) = e + 1
  def hl(lb:SSeq, f1:SSeq, x:SSeq, f2:SSeq, rb:SSeq) = 2
  def bl(bl:SSeq, f1:SSeq, x:SSeq, e:Answer, f2:SSeq, br:SSeq) = e + 2
  def br(bl:SSeq, f1:SSeq, e:Answer, x:SSeq, f2:SSeq, br:SSeq) = e + 2
  def il(f1:SSeq, f2:SSeq, r1:SSeq, x:Answer, r2:SSeq, f3:SSeq, f4:SSeq) = x + 2
  def ml(bl:SSeq, f1:SSeq, x:Answer, f2:SSeq, br:SSeq) = x + 2
  def app(c1:Answer, c:Answer) = c1 + c
  def ul(c1:Answer) = c1
  def addss(c1:Answer, e:SSeq) = c1
  def ssadd(e:SSeq, x:Answer) = x
  def nil(d:Dummy) = 0

  override val h = (l:List[Answer]) => if(l.isEmpty) List() else List(l.max)
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

  override val h = (l:List[Answer]) => l
}

/*
trait ZuckerAlgebra extends ZuckerSig {
  val h = (l :List[Answer]) => l match {
    case Nil => Nil
    case _ => l.maxBy(_._1)::Nil
  }

  def es(a:Int,b:Int):Int = -2 // stacking energy
  def eh(a:Int,b:Int):Int = 3 // hairpin loop energy
  def ebi(from:(Int,Int),to:(Int,Int)):Int = 2 + from._2-from._1 + to._2-to._1
}
*/
/*
  def w:Parser[Answer] = tabulate("W",
    empty ^^ { case x => (0,"??") }
  )

  def v:Parser[Answer] = tabulate("V",
    empty ^^ { case x => (0,"??") }
    // XXX: also include VBI
  )

  def freeEnergy:Parser[Answer] = tabulate("F",
    empty ^^ { case x => (0,"??") }
  )
*/

trait ZuckerGrammar extends ADPParsers with ZuckerSig {
/*
  tabulated { struct, closed, ml_comps, ml_comps1 }

  struct = sadd(BASE, struct) | cadd(dangle, struct) | nil(EMPTY) # h ;
  dangle = dlr(LOC, closed, LOC) ;
  closed = { stack | hairpin | leftB | rightB | iloop | multiloop } with stackpairing # h ;

  stack = sr(BASE, closed, BASE) ;
  hairpin = hl(BASE, BASE, { REGION with minsize(3) }, BASE, BASE) ;
  leftB = bl( BASE, BASE, REGION with maxsize(30), closed, BASE, BASE) # h ;
  rightB = br( BASE, BASE, closed, REGION with maxsize(30), BASE, BASE) # h ;
  iloop = il( BASE, BASE, REGION with maxsize(30), closed,
              REGION with maxsize(30), BASE, BASE) with iupac("accyy") # h ;

  multiloop = ml( BASE, BASE, ml_comps, BASE, BASE) ;
  ml_comps = sadd(BASE, ml_comps) | app( { ul(dangle) } , ml_comps1) # h ;
  ml_comps1 = sadd(BASE, ml_comps1) | app(  ul(dangle)  , ml_comps1) |
              ul(dangle) | addss( ul(dangle), REGION)  # h ;
*/
}

object Zucker extends App /*with ZuckerGrammar with ZuckerAlgebra*/ {
  println("UNIMPLEMENTED")
}