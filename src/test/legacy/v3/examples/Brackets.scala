package v3.examples
import v3._

// Correct parenthesization problem.
// Also examplifies the windowing
trait BracketsSignature extends Signature {
  type Answer = Int
  override type Alphabet = Char
}

trait BracketsAlgebra extends BracketsSignature {
  override val h = max[Answer] _
}

object Brackets extends LexicalParsers with BracketsAlgebra {
  def areBrackets(sw: Subword) = sw match {
    case(i,j) => j > i+1 && in(i) == '(' && in(j-1) == ')'
  }

  val axiom:Tabulate = tabulate("M",(
      digit
    | (char -~~ axiom ~~- char).filter(areBrackets _) ^^ { case (c1,(i,c2)) => i }
    | axiom +~+ axiom ^^ { case (x,y) => x+y }
    // Sum all digits of the string
    //| (char -~~ axiom) ^^ { case (c,i) => i }
    //| (axiom ~~- char) ^^ { case (i,c) => i }
  ) aggregate h)

  // Limits the size of the problem to 8 at most
  override val window = 8

  def main(args: Array[String]) = {
    val str = "(((3)))((2))(1)((6))((((8))))(3)((4))"
    println("Parse result = "+parse(str))
    printBT(backtrack(str))
    println(gen)
  }
}
