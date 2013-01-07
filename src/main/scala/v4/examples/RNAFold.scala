package v4.examples
import v4._

import librna.LibRNA

/*
object LibRNA { // Faking the library as there are SBT issues
  def setParams(s:String)
  def setSequence(s:String)
}
*/

// ----------------------------------------------------------------------------
// Folding algorithm from Unafold package in the function hybrid-ss-min
// Using the grammar described in paper "GPU accelerated RNA folding algorithm"

trait RNAFoldSig extends Signature {
  type Alphabet = Char

  def Eh(i:Int,j:Int) = LibRNA.hl_energy(i,j) // hairpin loop
  def Ei(i:Int,j:Int,k:Int,l:Int) = LibRNA.il_energy(i,j,k,l) // internal loop
  def Es(i:Int,j:Int) = LibRNA.sr_energy(i,j) // 2 stacked base pairs

  def hairpin(i:Int,j:Int):Answer
  def stack(i:Int,s:Answer,j:Int):Answer
  def iloop(ik:(Int,Int),s:Answer,lj:(Int,Int)):Answer
  def mloop(i:Int,s:Answer,j:Int):Answer
  def left(l:Answer,r:Int):Answer
  def right(l:Int,r:Answer):Answer
  def join(l:Answer,r:Answer):Answer
}

trait RNAFoldAlgebra extends RNAFoldSig {
  type Answer = Int
  override val h = min[Answer] _
  def hairpin(i:Int,j:Int) = Eh(i,j-1)
  def stack(i:Int,s:Int,j:Int) = Es(i,j) + s
  def iloop(ik:(Int,Int),s:Int,lj:(Int,Int)) = Ei(ik._1,lj._2-1,ik._2-1,lj._1) + s
  def mloop(i:Int,s:Int,j:Int) = s
  def left(l:Int,r:Int) = l
  def right(l:Int,r:Int) = r
  def join(l:Int,r:Int) = l+r
}

trait RNAFoldPrettyPrint extends RNAFoldSig {
  type Answer = String
  private def dots(n:Int,c:Char='.') = (0 until n).map{_=>c}.mkString
  def hairpin(i:Int,j:Int) = "("+dots(j-i-2)+")"
  def stack(i:Int,s:String,j:Int) = "("+s+")"
  def iloop(ik:(Int,Int),s:String,lj:(Int,Int)) = "(."+s+".)"
  def mloop(i:Int,s:String,j:Int) = "("+s+")"
  def left(l:String,r:Int) = l+"."
  def right(l:Int,r:String) = "."+r
  def join(l:String,r:String) = l+r
}

trait RNAFoldGrammar extends ADPParsers with RNAFoldSig {
  def pair(i:Int, j:Int):Boolean = if (j<=i+1) false else (in(i),in(j-1)) match {
    case ('a','u') | ('u','a') | ('u','g') | ('g','c') | ('g','u') | ('c','g') => true
    case _ => false
  }

  val seq2=seq(2,maxN)

  lazy val Qp:Tabulate = tabulate("Qp",(
    seq(3,maxN)      ^^ hairpin
  | eli ~ Qp ~ eli   ^^ stack
  | seq2 ~ Qp ~ seq2 ^^ iloop
  | eli ~ QM  ~ eli  ^^ mloop
  ) filter pair aggregate h)

  lazy val QM:Tabulate = tabulate("QM",(Q ~ Q ^^ join) filter((i:Int,j:Int)=>i<=j+4) aggregate h)

  lazy val Q:Tabulate = tabulate("Q",(
    QM
  | eli ~ Q ^^ right
  | Q ~ eli ^^ left
  | Qp
  ) filter((i:Int,j:Int)=>i<=j+2) aggregate h)

  override val axiom = Qp
}

object RNAFold extends App {
  object fold extends RNAFoldGrammar with RNAFoldAlgebra
  object pretty extends RNAFoldGrammar with RNAFoldPrettyPrint

  def parse(s:String) = {
    LibRNA.setParams("src/librna/vienna/rna_turner2004.par")
    LibRNA.setSequence(s);
    val (score,bt) = fold.backtrack(s.toArray).head;
    val res = pretty.build(s.toArray,bt)
    LibRNA.clear; (score,bt,res)
  }

  val (score,bt,res)=parse("aaaaaagggaaaagaacaaaggagacucuucuccuuuuucaaaggaagaggagacucuuucaaaaaucccucuuuu")
  println("Score     : "+score);
  println("Backtrack : "+bt);
  println("Result    : "+res);

  // Sequence : aaaaaagggaaaagaacaaaggagacucuucuccuuuuucaaaggaagaggagacucuuucaaaaaucccucuuuu
  // Reference: ((((.(((((...(((.((((((((....)))))))))))...(((((((....))))))).....))))).)))) (-24.5)
  // Our      : ((((.(((((.......((((((((....))))))))......(((((((....))))))).....))))).)))) (-21.8)
}
