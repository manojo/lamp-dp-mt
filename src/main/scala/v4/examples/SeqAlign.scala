package v4.examples
import v4._

// -----------------------------------------------
// Sequence alignment problem.
// -----------------------------------------------
// Demonstrates two algebrae for the same problem.

// +--------------------------------------------------------+
// | This example is VERY BAD as the sequences are computed |
// | in the forward computation (and eat additional space). |
// | See v4.report.SeqAlign for the correct way to do it.   |
// +--------------------------------------------------------+

trait SeqAlignSignature extends Signature {
  override type Alphabet = Char
  type Answer = (Int,String,String) // score, sequence1, sequence2

  def gap(current:Int, g:(Int,Int)):Int
  def pair(a:Alphabet,b:Alphabet):Int
}

// Smith-Waterman algebra
trait SmithWatermanAlgebra extends SeqAlignSignature {
  private val open = -3
  private val extend = -1

  def gap(score:Int, g:(Int,Int)) = { val size=g._2-g._1; Math.max(0, score + ( open + (size-1) * extend )) }
  def pair(a:Char,b:Char) = if (a==b) 10 else -3
  override val h = (l:List[Answer]) => if(l.isEmpty) Nil else List(l.maxBy(_._1))
}

// Needleman-Wunsch algebra
trait NeedlemanWunschAlgebra extends SeqAlignSignature {
  private val open = -15
  private val extend = -1

  def gap(score:Int, g:(Int,Int)) = { val size=g._2-g._1; score + ( open + (size-1) * extend ) }
  def pair(a:Char,b:Char) = if (a==b) 4 else -3
  override val h = (l:List[Answer]) => if(l.isEmpty) Nil else List(l.maxBy(_._1))
}

// Sequence alignment grammar
trait SeqAlignGrammar extends TTParsers with SeqAlignSignature {
  private def prettyGap(sw:Subword,in:Function1[Int,Char]):(String,String) = {
    val g=(sw._1 until sw._2).toList; (g.map{x=>in(x)}.mkString(""),g.map{x=>"-"}.mkString(""))
  }

  import scala.language.implicitConversions
  implicit def toCharArray(s:String):Array[Char] = s.toArray

  def align(s1:String,s2:String) = parse(s1,s2)
  def trace(s1:String,s2:String) = backtrack(s1,s2)
  val alignment:Tabulate = tabulate("M",(
    empty                       ^^ { _ => (0,".",".") }
  | seq() -~ alignment          ^^ { case (g,(score,s1,s2)) => val (g1,g2)=prettyGap(g,in1); (gap(score,g),s1+g1,s2+g2) }
  |          alignment ~- seq() ^^ { case ((score,s1,s2),g) => val (g1,g2)=prettyGap(g,in2); (gap(score,g),s1+g2,s2+g1) }
  | el1   -~ alignment ~- el2   ^^ { case (c1,((score,s1,s2),c2)) => (score+pair(c1,c2),s1+c1, s2+c2) }
  ) aggregate h)

  val axiom = alignment
}

// User program
object SeqAlign extends App {
  object SWat extends SeqAlignGrammar with SmithWatermanAlgebra   // Smith-Waterman
  object NWun extends SeqAlignGrammar with NeedlemanWunschAlgebra // Needleman-Wunsch
  val seq1 = "CGATTACA"
  val seq2 = "CCCATTAGAG"

  // Usage
  val (swScore,sw1,sw2) = SWat.align(seq1,seq2).head
  println("Smith-Waterman alignment\n- Score: "+swScore+"\n- Seq1: "+sw1+"\n- Seq2: "+sw2+"\n")
  val bt = SWat.trace(seq1,seq2)
  Utils.printBT(bt)
  println("Needleman-Wunsch score : "+NWun.build(seq1.toArray,seq2.toArray,bt.head._2)._1)
  println("--------------------------------------------\n")
  val (nwScore,nw1,nw2) = NWun.align(seq1,seq2).head
  println("Needleman-Wunsch alignment\n- Score: "+nwScore+"\n- Seq1: "+nw1+"\n- Seq2: "+nw2+"\n")
}
