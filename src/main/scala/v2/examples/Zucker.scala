package v2.examples

import v2._

// Zucker folding
// --------------
// See p.147 of "Parallelization of Dynamic Programming Recurrences in Computational Biology"
// Correct coefficients can be obtained at: http://www.tbi.univie.ac.at/~ivo/RNA/
// Have a look in the *.par files of Vienna RNA (>250Kb plain text coefficients !)

trait ZuckerSig extends Signature {
  type Alphabet = Char
  type Answer = (Int, String)
}

trait ZuckerAlgebra extends ZuckerSig {
  def h(l :List[Answer]) = l match {
    case Nil => Nil
    case _ => l.maxBy(_._1)::Nil
  }

  def es(a:Int,b:Int):Int = -2 // stacking energy
  def eh(a:Int,b:Int):Int = 3 // hairpin loop energy
  def ebi(from:(Int,Int),to:(Int,Int)):Int = 2 + from._2-from._1 + to._2-to._1
}

trait ZuckerGrammar extends ADPParsers with ZuckerSig {
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

  ml_comps1 = sadd(BASE, ml_comps1) | app( ul(dangle) , ml_comps1) |
              ul(dangle) | addss( ul(dangle), REGION)  # h ;
*/
}

object Zucker extends App with ZuckerGrammar with ZuckerAlgebra {
  println("UNIMPLEMENTED")
}