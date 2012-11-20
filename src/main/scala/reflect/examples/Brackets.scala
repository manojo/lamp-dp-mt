package reflect.examples

import reflect._

import scala.reflect.runtime.{universe => u}
import scala.reflect.runtime.universe.Expr
import scala.tools.reflect.Eval

// Correct parenthesization problem
// Also examplifies the windowing
trait BracketsSignature extends Signature {
  type Answer = Int
  override type Alphabet = Char
}

trait BracketsAlgebra extends BracketsSignature {
  val h = u.reify { (l:List[Int]) => if(l.isEmpty) List() else List(l.max) }
}

object Brackets extends LexicalParsers with BracketsAlgebra {
  def bracketize(c:Char,s:String) = "("+c+","+s+")"

  val areBrackets = u.reify {
    (sw: Subword) => sw match { case(i,j) => j > i+1 && in(i) == '(' && in(j-1) == ')' }
  }

  // If the parser does not tabulate, it must be a lazy val
  val myParser: Parser[Int] = tabulate("M",(
      digit
    | (char -~~ myParser ~~- char).filter(areBrackets) ^^ u.reify{ (x:(Char,(Int,Char))) => x._2._1 }
    //| ( charf(u.reify{(c:Char)=>c=='('}) -~~ myParser ~~- charf(u.reify{(c:Char)=>c==')'})) ^^ u.reify{ (x:(Char,(Int,Char))) => x._2._1 }
    | myParser +~+ myParser ^^ u.reify{ (x:(Int,Int)) => x._1+x._2 }
    // Digits sum in the string
    //| (char -~~ myParser) ^^ { case (c,i) => i }
    //| (myParser ~~- char) ^^ { case (i,c) => i }
  ) aggregate h)

  // Score of best valid subproblem of size exactely 8 := "(1)((6))"
  override val window = 8
  def main(args: Array[String]) = {
    println(parse(myParser)("(((3)))((2))(1)((6))((((8))))".toArray))
    println(gen)

    /*
    import scala.reflect.runtime.{universe => u}
    import scala.tools.reflect.Eval
    val ff:u.Expr[Function1[Int,Int]] = u.reify {
      (x:Int) => x*2
    }
    println(u showRaw ff)
    lazy val g = ff.eval
    println(g(3))
    println(g(5))
    */

  }
}
