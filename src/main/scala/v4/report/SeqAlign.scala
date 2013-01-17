package v4.report
import v4._

trait SeqAlignSignature extends Signature {
  type Alphabet = Char

  def start(x:Unit):Answer
  def gap1(g:(Int,Int),a:Answer):Answer
  def gap2(a:Answer,g:(Int,Int)):Answer
  def pair(c1:Alphabet,a:Answer,c2:Alphabet):Answer
}

trait SmithWatermanAlgebra extends SeqAlignSignature {
  type Answer = Int
  override val h = max[Int] _
  private val open = -3
  private val extend = -1
  def start(x:Unit) = 0
  def gap1(g:(Int,Int),a:Answer) = gap2(a,g)
  def gap2(a:Answer,g:(Int,Int)) = { val size=g._2-g._1; Math.max(0, a + ( open + (size-1) * extend )) }
  def pair(c1:Alphabet,a:Answer,c2:Alphabet) = a + (if (c1==c2) 10 else -3)
}

trait NeedlemanWunschAlgebra extends SeqAlignSignature {
  type Answer = Int
  override val h = max[Int] _
  private val open = -15
  private val extend = -1
  def start(x:Unit) = 0
  def gap1(g:(Int,Int),a:Answer) = gap2(a,g)
  def gap2(a:Answer,g:(Int,Int)) = { val size=g._2-g._1; a + ( open + (size-1) * extend ) }
  def pair(c1:Alphabet,a:Answer,c2:Alphabet) = a + (if (c1==c2) 4 else -3)
}

trait SeqPrettyPrint extends SeqAlignSignature {
  type Answer = (String,String)
  private def gap(sw:(Int,Int)) = (sw._1 to sw._2).map{_=>"-"}.mkString
  def start(x:Unit) = (".",".")
  def gap1(g:(Int,Int),a:Answer) = (a._1+gap(g),a._2)
  def gap2(a:Answer,g:(Int,Int)) = (a._1,a._2+gap(g))
  def pair(c1:Char,a:Answer,c2:Char) = (a._1+c1,a._2+c2)
}

trait SeqAlignGrammar extends TTParsers with SeqAlignSignature {
  val alignment:Tabulate = tabulate("M",(
    empty                         ^^ start
  | seq1() -~ alignment           ^^ gap1
  |           alignment ~- seq2() ^^ gap2
  | el1    -~ alignment ~- el2    ^^ pair
  ) aggregate h)

  val axiom = alignment
}

object SeqAlign extends App {
  object SWat extends SeqAlignGrammar with SmithWatermanAlgebra   // Smith-Waterman
  object NWun extends SeqAlignGrammar with NeedlemanWunschAlgebra // Needleman-Wunsch
  object pretty extends SeqAlignGrammar with SeqPrettyPrint // pretty print
  val seq1 = "CGATTACA"
  val seq2 = "CCCATTAGAG"

  def align(s1:String,s2:String,g:SeqAlignGrammar) = {
    val (score,bt) = g.backtrack(s1.toArray,s2.toArray).head
    val (a1,a2) = pretty.build(s1.toArray,s2.toArray,bt)
    (score,a1,a2)
  }
//- Score: 51
//- Seq1: .--CGATTACA-
//- Seq2: .CCC-ATTAGAG

//- Score: -12
//- Seq1: .-CGATTACA-
//- Seq2: .CCCATTAGAG

  val (swScore,sw1,sw2) = align(seq1,seq2,SWat)
  println("Smith-Waterman alignment\n- Score: "+swScore+"\n- Seq1: "+sw1+"\n- Seq2: "+sw2+"\n")
  val (nwScore,nw1,nw2) = align(seq1,seq2,NWun)
  println("Needleman-Wunsch alignment\n- Score: "+nwScore+"\n- Seq1: "+nw1+"\n- Seq2: "+nw2+"\n")
}
