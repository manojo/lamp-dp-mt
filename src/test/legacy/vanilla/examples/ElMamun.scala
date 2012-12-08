package vanilla.examples

import vanilla._

/**
 * El Mamoun's "oldest" DP problem
 */
trait Bill extends Signature {
  case class Add(l: Answer, c: Alphabet, r: Answer)
  case class Mul(l: Answer, c: Alphabet, r: Answer)

  def f(i: Int): Answer
  def add(a: Add): Answer
  def mul(m: Mul): Answer
}

trait BuyerAlgebra extends Bill {
  type Answer = Int
  override type Alphabet = Char

  def f(i: Int) = i
  def add(a: Add) = a.l + a.r
  def mul(m: Mul) = m.l * m.r

  def h(l :List[Answer]) = l match{
    case Nil => Nil
    case _ => l.min::Nil
  }
}

trait SellerAlgebra extends Bill {
  type Answer = Int
  override type Alphabet = Char

  def f(i: Int) = i
  def add(a: Add) = a.l + a.r
  def mul(m: Mul) = m.l * m.r

  def h(a:Int, b:Int) = if (a>b) a else b
  def z = 0
}

trait BillGrammar extends LexicalParsers with SellerAlgebra with CodeGen{
  def plus = charf(_ == '+')
  def times = charf(_ == '*')

  def billGrammar: Parser[Int] = tabulate("M",(
    charf(_.isDigit) ^^ readDigit
  | (billGrammar ~~- plus ~~~ billGrammar) ^^ {case ((a1,c),a2) => add(Add(a1,c,a2))}
  | (billGrammar ~~- times ~~~ billGrammar) ^^ {case ((a1,c),a2) => mul(Mul(a1,c,a2))}
  ) fold(z,h) )
}

object ElMamun extends BillGrammar with App {
  def input = "1+2*3*4+5".toArray
  println(billGrammar(0,input.length))
  println(gen)
}
