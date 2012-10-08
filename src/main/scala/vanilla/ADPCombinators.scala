package vanilla
import scala.util.parsing.combinator.Parsers

trait Signature{
  type Answer
  type Alphabet

  def h(l: List[Answer]) : List[Answer]
}

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

  def h(l :List[Answer]) = l.max::Nil
}