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
  def gap1(g:(Int,Int),a:Int) = gap2(a,g) // by symmetry
  def gap2(a:Int,g:(Int,Int)) =
    { val size=g._2-g._1; Math.max(0, a + ( open + (size-1)*extend )) }
  def pair(c1:Char,a:Int,c2:Char) = a + (if (c1==c2) 10 else -3)
}

trait NeedlemanWunschAlgebra extends SeqAlignSignature {
  type Answer = Int
  override val h = max[Int] _
  private val open = -15
  private val extend = -1
  def start(x:Unit) = 0
  def gap1(g:(Int,Int),a:Int) = gap2(a,g) // by symmetry
  def gap2(a:Int,g:(Int,Int)) =
    { val size=g._2-g._1; a + ( open + (size-1)*extend ) }
  def pair(c1:Char,a:Int,c2:Char) = a + (if (c1==c2) 4 else -3)
}

trait SeqPrettyPrint extends SeqAlignSignature {
  type Answer = (String,String)
  def in1(k:Int):Alphabet; def in2(k:Int):Alphabet // make it visible
  private def gap(sw:(Int,Int),in:Function1[Int,Char]) = {
    val g=(sw._1 until sw._2).toList
    (g.map{x=>in(x)}.mkString,g.map{x=>"-"}.mkString)
  }
  def start(x:Unit) = (".",".")
  def gap1(g:(Int,Int),a:Answer) =
    { val (g1,g2)=gap(g,in1); (a._1+g1,a._2+g2) }
  def gap2(a:Answer,g:(Int,Int)) =
    { val (g2,g1)=gap(g,in2); (a._1+g1,a._2+g2) }
  def pair(c1:Char,a:Answer,c2:Char) = (a._1+c1,a._2+c2)
}

trait SeqAlignGrammar extends TTParsers with SeqAlignSignature {
  val axiom:Tabulate = tabulate("M",(
    empty                   ^^ start
  | seq() -~ axiom          ^^ gap1
  |          axiom ~- seq() ^^ gap2
  | el1   -~ axiom ~- el2   ^^ pair
  ) aggregate h,true)
}

object SeqAlign extends App {
  object SWat extends SeqAlignGrammar with SmithWatermanAlgebra
  object NWun extends SeqAlignGrammar with NeedlemanWunschAlgebra
  object pretty extends SeqAlignGrammar with SeqPrettyPrint
  val seq1 = "CGATTACA"
  val seq2 = "CCCATTAGAG"

  def align(name:String,s1:String,s2:String,g:SeqAlignGrammar) = {
    val (score,bt) = g.backtrack(s1.toArray,s2.toArray).head
    val (a1,a2) = pretty.build(s1.toArray,s2.toArray,bt)
    println(name+" alignment\n- Score: "+score)
    println("- Seq1: "+a1+"\n- Seq2: "+a2+"\n")
  }
  align("Smith-Waterman",seq1,seq2,SWat)
  align("Needleman-Wunsch",seq1,seq2,SWat)
}
