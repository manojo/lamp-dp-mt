package v4.examples
import v4._

// Smith-Waterman with affine gap cost

trait SWatSig extends Signature {
  type Alphabet = Char
  val start : Unit=>Answer
  val zero1 : Int => Answer
  val zero2 : Int => Answer
  val open1 : (Alphabet,Answer)=>Answer
  val open2 : (Answer,Alphabet)=>Answer
  val ext1 : (Alphabet,Answer)=>Answer
  val ext2 : (Answer,Alphabet)=>Answer
  val pair : (Alphabet,Answer,Alphabet)=>Answer
}

trait SWatAlgebra extends SWatSig {
  type Answer = Int
  override val h = max[Int] _
  private val open = -3
  private val ext = -1
  val start = cfun1((x:Unit) => 0, "","return 0;")
  val open1 = cfun2((c1:Alphabet,a:Answer) => Math.max(0, a+open), "c1,a", "return a>3 ? a-3 : 0;")
  val open2 = cfun2((a:Answer,c2:Alphabet) => Math.max(0, a+open), "a,c2", "return a>3 ? a-3 : 0;")
  val ext1 = cfun2((c1:Alphabet,a:Answer)=> Math.max(0, a+ext), "c1,a", "return a>1 ? a-1 : 0;")
  val ext2 = cfun2((a:Answer,c2:Alphabet)=> Math.max(0, a+ext), "a,c2", "return a>1 ? a-1 : 0;")
  val pair = cfun3((c1:Char,a:Answer,c2:Char) => Math.max(0, a + (if (c1==c2) 10 else -3)), "c1,a,c2","return a + (c1==c2 ? 10 : -3);")
  val zero1 = cfun1((p:Int) => 0, "p","return 0;")
  val zero2 = cfun1((p:Int) => 0, "p","return 0;")
}

trait SWatGrammar extends TTParsers with SWatSig {
  val axiom:Tabulate = tabulate("M",(
    empty                 ^^ start
  | el1   -~ axiom ~- el2 ^^ pair
  | g1
  | g2
  ) aggregate h,true)

  val g1:Tabulate = tabulate("g1",(
    empty1       ^^ zero1
  | el1 -~ axiom ^^ open1
  | el1 -~ g1    ^^ ext1
  ) aggregate h,true)

  val g2:Tabulate = tabulate("g2",(
    empty2       ^^ zero2
  | axiom ~- el2 ^^ open2
  | g2    ~- el2 ^^ ext2
  ) aggregate h,true)
}

object SWatAffine extends SWatGrammar with SWatAlgebra with CodeGen {
  override val tps = (manifest[Alphabet],manifest[Answer])
  override val benchmark = true
  override val bottomUp = true

  backtrack(Utils.genDNA(1024),Utils.genDNA(1024))
}
