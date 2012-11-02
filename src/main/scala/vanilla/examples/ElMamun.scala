package vanilla.examples

import vanilla._

/**
 * El Mamoun's "oldest" DP problem
 */
trait Bill extends Signature{
  case class Add(l: Answer, c: Alphabet, r: Answer)
  case class Mul(l: Answer, c: Alphabet, r: Answer)

  def f(i: Int): Answer
  def add(a: Add): Answer
  def mul(m: Mul): Answer
}

trait BuyerAlgebra extends Bill{
  type Answer = Int
  type Alphabet = Char

  def f(i: Int) = i
  def add(a: Add) = a.l + a.r
  def mul(m: Mul) = m.l * m.r

  def h(l :List[Answer]) = l match{
    case Nil => Nil
    case _ => l.min::Nil
  }
}

trait SellerAlgebra extends Bill{
  type Answer = Int
  type Alphabet = Char

  def f(i: Int) = i
  def add(a: Add) = a.l + a.r
  def mul(m: Mul) = m.l * m.r

  def h(l :List[Answer]) = l match{
    case Nil => Nil
    case _ => l.max::Nil
  }
}

trait BillGrammar extends LexicalParsers with SellerAlgebra{
  def plus = charf(_ == '+')
  def times = charf(_ == '*')

  def billGrammar: Parser[Int] = ((
    charf(_.isDigit) ^^ readDigit
  | (billGrammar ~~- plus ~~~ billGrammar) ^^ {case ((a1,c),a2) => add(Add(a1,c,a2))}
  | (billGrammar ~~- times ~~~ billGrammar) ^^ {case ((a1,c),a2) => mul(Mul(a1,c,a2))}
  ) aggregate h).tabulate
}

object ElMamun extends BillGrammar with App{
  def input = "1+2*3*4+5"
  println(billGrammar(0,input.length))
}
