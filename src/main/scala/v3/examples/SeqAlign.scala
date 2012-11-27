package v3.examples
import v3._

// Sequence alignment problem
// We also want to pretty-print the two sequences aligned
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

trait SeqAlignGrammar extends TTParsers with SeqAlignSignature {
  private def prettyGap(sw:Subword,in:Function1[Int,Char]):(String,String) = {
    val g=(sw._1 until sw._2).toList; (g.map{x=>in(x)}.mkString(""),g.map{x=>"-"}.mkString(""))
  }

  def align(s1:String,s2:String) = parse(alignment)(s1.toArray,s2.toArray)
  val alignment: Parser[Answer] = tabulate("M",(
    empty                       ^^ { _ => (0,".",".") }
  | seq1 ++~ alignment          ^^ { case (g,(score,s1,s2)) => val (g1,g2)=prettyGap(g,in1); (gap(score,g),s1+g1,s2+g2) }
  |          alignment ~++ seq2 ^^ { case ((score,s1,s2),g) => val (g1,g2)=prettyGap(g,in2); (gap(score,g),s1+g2,s2+g1) }
  | el1  -~~ alignment ~~- el2  ^^ { case (c1,((score,s1,s2),c2)) => (score+pair(c1,c2),s1+c1, s2+c2) }
  ) aggregate h)
}

// User program
object SeqAlign extends App {
  // Smith-Waterman
  object SWat extends SeqAlignGrammar with SmithWatermanAlgebra
  // Needleman-Wunsch
  object NWun extends SeqAlignGrammar with NeedlemanWunschAlgebra

  val seq1 = "GATTACA"
  val seq2 = "CCCATTAGAG"

  // Usage
  val ((swScore,sw1,sw2),swBt) = SWat.align(seq1,seq2).head
  println("\nSmith-Waterman alignment  \n--------------------------\nScore: "+swScore+"\nSeq1: "+sw1+"\nSeq2: "+sw2+"\n")
  println(SWat.gen)

  val ((nwScore,nw1,nw2),nwBt) = NWun.align(seq1,seq2).head
  println("\nNeedleman-Wunsch alignment\n--------------------------\nScore: "+nwScore+"\nSeq1: "+nw1+"\nSeq2: "+nw2+"\n")
  println(NWun.gen)
}
