package v3.examples
import v3._

// El Mamoun's "oldest" DP problem
trait Bill extends Signature {
  def add(l: Answer, r: Answer): Answer
  def mul(l: Answer, r: Answer): Answer
}

// Algebrae
trait BuyerAlgebra extends Bill {
  override type Answer = Int

  def add(l: Answer, r: Answer) = l + r
  def mul(l: Answer, r: Answer) = l * r
  def h(l :List[Answer]) = l match {
    case Nil => Nil
    case _ => l.min::Nil
  }
}

trait SellerAlgebra extends Bill {
  override type Answer = Int

  def add(l: Answer, r: Answer) = l + r
  def mul(l: Answer, r: Answer) = l * r
  def h(l :List[Answer]) = l match {
    case Nil => Nil
    case _ => l.max::Nil
  }
}

// Common grammar
trait BillGrammar extends LexicalParsers with Bill {
  override type Answer = Int
  override type Alphabet = Char

  def plus = charf(_ == '+')
  def times = charf(_ == '*')

  val billGrammar: Parser[Int] = tabulate("M",(
    digit
  | (billGrammar ~~- plus ~~~ billGrammar) ^^ { case ((a1,c),a2) => add(a1,a2) }
  | (billGrammar ~~- times ~~~ billGrammar) ^^ { case ((a1,c),a2) => mul(a1,a2) }
  ) aggregate h)

  def parse(in:String):List[(Answer,Backtrack)] = parse(billGrammar)(in)
}

// User program
object ElMamun extends App {
  object buyer extends BillGrammar with BuyerAlgebra
  object seller extends BillGrammar with SellerAlgebra

  val input = "1+2*3*4+5"
  println
  println("Buyer : "+buyer.parse(input).head)
  println(buyer.gen)
  println
  println("Seller: "+seller.parse(input).head)
  println(buyer.gen)
}
