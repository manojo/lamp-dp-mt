package v4.examples
import v4._

// Sequence alignment problem.
trait SeqAlignSig extends Signature {
  override type Alphabet = Char
  val gap: (Answer,(Int,Int))=>Answer
  val pair: (Alphabet,Answer,Alphabet)=>Answer
  val zro: Unit=>Answer
}

// Costing algebrae
trait SWatAlgGen extends SeqAlignSig {
  override type Answer = Int
  override val h = max[Int]
  val gap = new ((Answer,(Int,Int))=>Answer) with CFun {
    def apply(score:Int, g:(Int,Int)) = { val size=g._2-g._1; Math.max(0, score - (2+size)) }
    val (args,tpe) = (List(("score","Int"),("g","(Int,Int)")),"Int")
    val body = "int size=g._2-g._1; int s=score-(2+size); return s>0?s:0;"
  }
  val pair = new ((Alphabet,Answer,Alphabet)=>Answer) with CFun {
    def apply(a:Char,score:Int,b:Char) = score + (if (a==b) 10 else -3)
    val (args,tpe) = (List(("a","Char"),("score","Int"),("b","Char")),"Int")
    val body = "return score + (a==b?10:-3);"
  }
  val zro = new (Unit=>Int) with CFun {
    def apply(d:Unit):Int = 0
    val (args,tpe) = (Nil,"Int")
    val body = "return 0;"
  }
}

// Sequence alignment grammar
trait SeqAlignGrammarGen extends TTParsers with SeqAlignSig {
  val alignment:Tabulate = tabulate("M",(
    empty                         ^^ zro
  | seq1() -~ alignment           ^^ gap
  |           alignment ~- seq2() ^^ gap
  | el1    -~ alignment ~- el2    ^^ pair
  ) aggregate h,true)

  val axiom = alignment
}

// User program
object SeqAlignGen extends SeqAlignGrammarGen with SWatAlgGen with CodeGen with App {
  override val benchmark = true
  override val tps=(manifest[Alphabet],manifest[Answer])

  val seq1 = "CGATTACA".toArray
  val seq2 = "CCCATTAGAG".toArray

  // Usage
  //println(gen)
  val (swScore,swBt) = backtrack(seq1,seq2).head
  println("Smith-Waterman alignment\n- Score: "+swScore)
  printBT(List((swScore,swBt)))
}
