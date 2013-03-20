package v4.fpga
import v4._

trait SeqSig extends Signature {
  type Alphabet = Char
  def start(x:Unit):Answer
  def gap1(g:Char,a:Answer):Answer
  def gap2(a:Answer,g:Char):Answer
  def pair(c1:Alphabet,a:Answer,c2:Alphabet):Answer
}

trait SWat extends SeqSig {
  type Answer = Int
  override val h = max[Int] _
  def start(x:Unit) = 0
  def gap1(g:Char,a:Int) = Math.max(0, a-3)
  def gap2(a:Int,g:Char) = Math.max(0, a-3)
  def pair(c1:Char,a:Int,c2:Char) = if (c1==c2) a+10 else Math.max(0,a-3)
}

trait PrettyPrint extends SeqSig {
  type Answer = (String,String)
  def start(x:Unit) = (".",".")
  def gap1(g:Char,a:Answer) = (a._1+g,a._2+"-")
  def gap2(a:Answer,g:Char) = (a._1+"-",a._2+g)
  def pair(c1:Char,a:Answer,c2:Char) = (a._1+c1,a._2+c2)
}

trait SeqAlignGrammar extends TTParsers with SeqSig {
  val axiom:Tabulate = tabulate("M",(
    empty               ^^ start
  | el1 -~ axiom        ^^ gap1
  |        axiom ~- el2 ^^ gap2
  | el1 -~ axiom ~- el2 ^^ pair
  ) aggregate h,true)
}

object SeqAlign extends SeqAlignGrammar with SWat with FPGACodeGen with App {
  override val tps=(manifest[Alphabet],manifest[Answer])

  // Testing Scala parsers
  object pretty extends SeqAlignGrammar with PrettyPrint
  val s1 = "CGATTACA".toArray
  val s2 = "CCCATTAGAG".toArray
  val (score,bt) = backtrack(s1,s2).head
  val (a1,a2) = pretty.build(s1,s2,bt)
  println("- Score: "+score)
  println("- Seq1: "+a1+"\n- Seq2: "+a2+"\n")

  // Generating MMAlpha code
  println(gen)
}
