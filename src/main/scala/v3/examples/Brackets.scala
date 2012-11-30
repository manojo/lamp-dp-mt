package v3.examples
import v3._

// Correct parenthesization problem
// Also examplifies the windowing
trait BracketsSignature extends Signature {
  type Answer = Int
  override type Alphabet = Char
}

trait BracketsAlgebra extends BracketsSignature {
  //def h(l : List[Int]) = if(l.isEmpty) List() else List(l.max)
  override val h = max[Answer] _
}

object Brackets extends LexicalParsers with BracketsAlgebra {
  def bracketize(c:Char,s:String) = "("+c+","+s+")"

  def areBrackets(sw: Subword) = sw match {
    case(i,j) => j > i+1 && in(i) == '(' && in(j-1) == ')'
  }

  val myParser:Parser[Answer] = tabulate("M",(
      digit
    | (char -~~ myParser ~~- char).filter(areBrackets _).^^{ case (c1,(i,c2)) => i}
    | myParser +~+ myParser ^^ {case (x,y) => x+y}
    // Digits sum in the string
    //| (char -~~ myParser) ^^ { case (c,i) => i }
    //| (myParser ~~- char) ^^ { case (i,c) => i }
  ) aggregate h)

  // Score of best valid subproblem of size exactely 8 := "(1)((6))"
  override val window = 8
  def main(args: Array[String]) = {
    println(parse(myParser)("(((3)))((2))(1)((6))((((8))))"))
    println(gen)
  }
}