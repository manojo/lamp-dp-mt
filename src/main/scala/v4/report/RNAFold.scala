package v4.report
import v4._

// Minimal example of RNA folding
// See v4.examples.RNAFold for more features.

object RNAFold extends ADPParsers with RNASignature with App {
  type Answer = Int
  override val h = min[Answer] _

  import librna.LibRNA._
  def hairpin(ij:(Int,Int)) = hl_energy(ij._1,ij._2-1)
  def stack(i:Int,s:Int,j:Int) = sr_energy(i,j) + s
  def iloop(ik:(Int,Int),s:Int,lj:(Int,Int)) = il_energy(ik._1,ik._2,lj._1-1,lj._2-1) + s

  lazy val Qp:Tabulate = tabulate("Qp",(
    seq(3,maxN)                ^^ hairpin
  | eli       ~ Qp ~ eli       ^^ stack
  | seq(1,30) ~ Qp ~ seq(1,30) ^^ iloop
  | eli       ~ QM ~ eli       ^^ {(i:Int,s:Int,j:Int) => s}
  ) filter basepairing aggregate h)
  lazy val QM:Tabulate = tabulate("QM",( Q ~ Q ^^ {(l:Int,r:Int) => l+r}) aggregate h filter(length(4)))
  lazy val Q:Tabulate = tabulate("Q",  ( Q ~ eli ^^ {(l:Int,r:Int) => l}
                                       | eli ~ Q ^^ {(l:Int,r:Int) => r}
                                       | QM | Qp ) aggregate h filter(length(2)))
  override val axiom = Q
  setParams("src/librna/vienna/rna_turner2004.par")
  println(backtrack(convert("ucaaaggaagaggagacucuuucaaaaauc")))
}
