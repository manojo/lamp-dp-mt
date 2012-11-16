package v2.examples

import v2._

// Nussinov
trait PairingSig extends Signature {
  case class Dummy

  def nil(a: Dummy): Answer
  def left(c: Alphabet, a: Answer): Answer
  def right(a: Answer, c: Alphabet): Answer
  def pair(l: Alphabet, a: Answer, r: Alphabet): Answer
  def split(l: Answer, r: Answer): Answer
}

trait PairingAlgebra extends PairingSig {
  type Answer = Int
  type Alphabet = Char

  def nil(a: Dummy) = 0
  def left(c: Alphabet,a: Answer) = a
  def right(a: Answer, c:Alphabet) = a
  def pair(l: Alphabet, a: Answer, r: Alphabet) = a+1
  def split(l: Answer, r: Answer) = l + r

  def h(l :List[Answer]) = l match {
    case Nil => Nil
    case _ => l.max::Nil
  }
}

/*
trait PrettyPAlgebra extends PairingSig {
  type Answer = (String,String)
  type Alphabet = Char

  def nil(a:Dummy) = ("","")
  def left(c: Alphabet,a: Answer) = ("."+a._1, c+a._2)
  def right(a: Answer, c:Alphabet) = (a._1+".", a._2 + c)
  def pair(l: Alphabet, a: Answer, r: Alphabet) = ("("+a._1+")", l+a._2+r)
  def split(l: Answer, r: Answer) = (l._1+r._1, l._2+r._2)

  def h(l :List[Answer]) = l
}
*/

/*
 * combining two algebrae: done manually for now
 */
trait PrettyPairingAlgebra extends PairingSig {
  type Answer = (Int, String)
  type Alphabet = Char

  def nil(a: Dummy) = (0, "")
  def left(c: Alphabet,a: Answer) = (a._1, "."+a._2)
  def right(a: Answer, c:Alphabet) = (a._1, a._2+".")
  def pair(l: Alphabet, a: Answer, r: Alphabet) = (a._1 + 1, "("+a._2+")")
  def split(l: Answer, r: Answer) = (l._1 + r._1, l._2 + r._2)

  def h(l :List[Answer]) = l match {
    case Nil => Nil
    case _ => l.maxBy(_._1)::Nil
  }
}

trait NussinovGrammar extends PrettyPairingAlgebra with LexicalParsers {
  def empty = new Parser[Dummy] {
    def apply(sw: Subword) = sw match {
      case (i,j) if i == j => List(new Dummy)
      case _ => List()
    }
    //def tree = PTerminal((i:Var,j:Var) => (List(i.e(j,0)),"empty"))
  }

  val basePairs = List(('a','u'),('u','a'),('g','u'),('u','g'),('c','g'),('g','c'))
  def isBasePair(a: Char, b: Char) = basePairs contains (a,b)

  def s: Parser[(Int,String)] = tabulate("s",(
    empty ^^ nil
  | (s ~~- char) ^^ {case (a,c) => right(a,c)}
  | (s ~~+ t) ^^{case (a,b) => split(a,b)}
  ) aggregate h)

  def t: Parser[(Int,String)] = tabulate("t",
    ((char -~~ s ~~- char)
      filter {case (i,j) => isBasePair(in(i),in(j-1))})
     ^^ {case (c1,(a,c2)) => pair(c1,a,c2)}
  )
}

object Nussinov extends NussinovGrammar with App {
  val input = "guaugu".toArray
  println(parse(s)(input))
  //println(gen)
}
