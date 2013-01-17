package v4.report
import v4._

trait RNAFoldSig extends RNASignature {
  def hairpin(ij:(Int,Int)):Answer
  def stack(i:Int,s:Answer,j:Int):Answer
  def iloop(ik:(Int,Int),s:Answer,lj:(Int,Int)):Answer
  def mloop(i:Int,s:Answer,j:Int):Answer
  def left(l:Answer,r:Int):Answer
  def right(l:Int,r:Answer):Answer
  def join(l:Answer,r:Answer):Answer
}

trait RNAFoldAlgebra extends RNAFoldSig {
  type Answer = Int
  import librna.LibRNA._ // indexing convention: first base,last base
  def hairpin(ij:(Int,Int)) = hl_energy(ij._1,ij._2-1) // Eh
  def stack(i:Int,s:Int,j:Int) = sr_energy(i,j) + s // Es
  def iloop(ik:(Int,Int),s:Int,lj:(Int,Int)) =
      il_energy(ik._1,ik._2,lj._1-1,lj._2-1) + s // Ei
  def mloop(i:Int,s:Int,j:Int) = s
  def left(l:Int,r:Int) = l
  def right(l:Int,r:Int) = r
  def join(l:Int,r:Int) = l+r
  override val h = min[Answer] _
}

trait RNAFoldPrettyPrint extends RNAFoldSig {
  type Answer = String
  override val energies=false
  private def dots(n:Int,c:Char='.') = (0 until n).map{_=>c}.mkString
  def hairpin(ij:(Int,Int)) = "("+dots(ij._2-ij._1-2)+")"
  def stack(i:Int,s:String,j:Int) = "("+s+")"
  def iloop(ik:(Int,Int),s:String,lj:(Int,Int)) =
      "("+dots(ik._2-1-ik._1)+s+dots(lj._2-1-lj._1)+")"
  def mloop(i:Int,s:String,j:Int) = "("+s+")"
  def left(l:String,r:Int) = l+"."
  def right(l:Int,r:String) = "."+r
  def join(l:String,r:String) = l+r
}

trait RNAFoldGrammar extends ADPParsers with RNAFoldSig {
  lazy val Qp:Tabulate = tabulate("Qp",(
    seq(3,maxN)        ^^ hairpin
  | eli   ~ Qp ~ eli   ^^ stack
  | seq() ~ Qp ~ seq() ^^ iloop
  | eli   ~ QM ~ eli   ^^ mloop
  ) filter basepairing aggregate h)

  lazy val QM:Tabulate = tabulate("QM",(Q ~ Q ^^ join) filter((i:Int,j:Int)=>i<=j+4) aggregate h)

  lazy val Q:Tabulate = tabulate("Q",(
    QM
  | Q ~ eli ^^ left
  | eli ~ Q ^^ right
  | Qp
  ) filter((i:Int,j:Int)=>i<=j+2) aggregate h)

  override val axiom = Q
}

object RNAFold extends App {
  object fold extends RNAFoldGrammar with RNAFoldAlgebra
  object pretty extends RNAFoldGrammar with RNAFoldPrettyPrint

  val seq="aaaaaagggaaaagaacaaaggagacucuucuccuuuuucaaaggaagagg"

  val (score,bt) = fold.backtrack(seq.toArray).head
  val res = pretty.build(seq.toArray,bt)
  println("Folding : "+res+" (%5.2f)".format(score/100.0));
}
