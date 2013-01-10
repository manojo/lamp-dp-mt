package v4.examples
import v4._

// Nussinov RNA folding
trait PairingSig extends Signature {
  def nil(a: Unit): Answer
  def left(c: Alphabet, a: Answer): Answer
  def right(a: Answer, c: Alphabet): Answer
  def pair(l: Alphabet, a: Answer, r: Alphabet): Answer
  def split(l: Answer, r: Answer): Answer
}

trait PairingAlgebra extends PairingSig {
  type Answer = Int

  def nil(a: Unit) = 0
  def left(c: Alphabet,a: Answer) = a
  def right(a: Answer, c:Alphabet) = a
  def pair(l: Alphabet, a: Answer, r: Alphabet) = a+1
  def split(l: Answer, r: Answer) = l + r

  override val h = max[Answer] _
}

/*
trait PrettyPrintAlgebra extends PairingSig {
  type Answer = (String,String)
  type Alphabet = Char

  def nil(a:Unit) = ("","")
  def left(c: Alphabet,a: Answer) = ("."+a._1, c+a._2)
  def right(a: Answer, c:Alphabet) = (a._1+".", a._2 + c)
  def pair(l: Alphabet, a: Answer, r: Alphabet) = ("("+a._1+")", l+a._2+r)
  def split(l: Answer, r: Answer) = (l._1+r._1, l._2+r._2)
}
*/

// Combining two algebrae: done manually for now
trait PrettyPairingAlgebra extends PairingSig {
  type Answer = (Int, String)

  def nil(a: Unit) = (0, "")
  def left(c: Alphabet,a: Answer) = (a._1, "."+a._2)
  def right(a: Answer, c:Alphabet) = (a._1, a._2+".")
  def pair(l: Alphabet, a: Answer, r: Alphabet) = (a._1 + 1, "("+a._2+")")
  def split(l: Answer, r: Answer) = (l._1 + r._1, l._2 + r._2)

  override val h = (l:List[Answer]) => l match {
    case Nil => Nil
    case _ => l.maxBy(_._1)::Nil
  }
}

trait NussinovGrammar extends LexicalParsers with PrettyPairingAlgebra {
  val basePairs = List(('a','u'),('u','a'),('g','u'),('u','g'),('c','g'),('g','c'))
  def isBasePair(a: Char, b: Char) = basePairs contains (a,b)

  val s:Tabulate = tabulate("s",(
    empty    ^^ nil
  | s ~ char ^^ right
  | s ~ t    ^^ split
  ) aggregate h)

  val t:Tabulate = tabulate("t",
    ((char ~ s ~ char)
      filter {case (i,j) => isBasePair(in(i),in(j-1))}) ^^ pair
  )

  val axiom=s
}

object Nussinov extends NussinovGrammar with App {
  println(parse("guaugu"))
  println(parse("acguacguacguacguacguacgu"))


  def testSeq(s:String) = {
    println(s)
    println(parse(s))
    println
  }
  testSeq("ccuuuuucaaagg")
  testSeq("guacgucaguacguacgugacugucagucaac")
  testSeq("aaaaaggaaacuccucuuu")
  testSeq("uucuccucaggaaga")
  testSeq("aaaaaagggaaaagaacaaaggagacucuucuccuuuuucaaaggaagaggagacucuuucaaaaaucccucuuuu")
  testSeq("gccaaccucgugca")
  testSeq("ggccaaccucgugcaa")
  testSeq("guugcucagcacgcguaaga")
  // PART 2
  testSeq("gggcgcucaaccgagucagcagugcaauauagggccc")
  testSeq("augggcgcucaacucuccgugaauuugaaugagucagcagugcaauauagggcccucauc")
  testSeq("accacuccucauuugacuuauaggcucagaauuaguagaccacaguucacugugaaagga")
  testSeq("uugcccuaugucaaacauaugucgcaaagcacacgucguauucaccacgaucaaccaggg")
  testSeq("ccgaugccagcgucugcgccuucgccuaagggggagaagaagcucucccauaacggcaug")


}
