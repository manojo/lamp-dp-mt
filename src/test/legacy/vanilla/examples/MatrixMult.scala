package vanilla.examples

import vanilla._

/** Matrix multiplication */
trait MatrixSig extends Signature {
  type Alphabet = (Int,Int)

  case class Add(l: Answer, c: Alphabet, r: Answer)
  case class Mul(l: Answer, c: Alphabet, r: Answer)

  def single(i: (Int, Int)): Answer
  def mult(l: Answer, r: Answer): Answer

  // Helpers
  type Prod = (Int,Int,Int) // matrix product as (rows, cost, columns)
  def cmp(a:Prod, b:Prod):Boolean = (a,b) match { // returns true if a better than b
    case ((0,0,0),_) => false
    case (_,(0,0,0)) => true
    case _ => (a._2 < b._2)
  }
  def mul(a:Prod, b:Prod) = (a,b) match {
   case((r1,m1,c1),(r2,m2,c2)) => (r1, m1 + m2 + r1 * c1 * c2, c2)
  }
}

trait MatrixAlgebra extends MatrixSig {
  type Answer = Prod

  def single(i: (Int, Int)) = (i._1, 0, i._2)
  def mult(l: Answer, r: Answer) = mul(l,r)
  def h(a:Answer, b:Answer) = if (cmp(a,b)) a else b
  def z = (0,0,0)
}

trait PrettyPrintAlgebra extends MatrixSig {
  type Answer = String

  def single(i: (Int, Int)) = "|"+i._1+"x"+i._2+"|"
  def mult(l: Answer, r: Answer) = (l,r) match {
    case(s1,s2) => "("+s1+"*"+s2+")"
  }
  def h(a:Answer, b:Answer) = a+", "+b
  def z = ""
}

/** Combining two algebrae: done manually for now */
trait PrettyMatrixAlgebra extends MatrixSig {
  type Answer = (Prod, String)

  def single(i: (Int, Int)) = ((i._1, 0, i._2), "|"+i._1+"x"+i._2+"|")
  def mult(l: Answer, r: Answer) = (l,r) match {
    case((p1,s1),(p2,s2)) => (mul(p1,p2), "("+s1+"*"+s2+")")
  }

  def h(a:Answer, b:Answer) = if (cmp(a._1,b._1)) a else b
  def z = ((0,0,0),"")
}

trait MatrixGrammar extends ADPParsers with MatrixAlgebra with CodeGen {
  def aMatrix = new Parser[(Int,Int)] {
    def apply(sw: Subword) = sw match {
      case (i,j) if(i+1 == j) => List(input(i))
      case _ => List()
    }
    def tree = PTerminal((i:Var,j:Var) => (List(i.e(j,1)),"mat["+i+"]"))
  }

  def matrixGrammar: Parser[(Int,Int,Int)] = tabulate("M",(
    aMatrix ^^ single
  | (matrixGrammar +~+ matrixGrammar) ^^ { case (a1,a2) => mult(a1, a2) }
  ) fold(z,h))
}

object MatrixMult extends MatrixGrammar with App {
  def input = List((10,100),(100,5),(5,50)).toArray
  println(matrixGrammar(0,input.length))
  println(gen)
}


/*trait MatrixGrammarB extends BDPParsers with MatrixAlgebra {
  def aMatrix = new Parser[(Int,Int)]{
    def apply(sw: Subword) = sw match {
      case (i,j) if(i+1 == j) => List(input(i))
      case _ => List()
    }

    def makeTree = SingleElem
  }

  val costMatrix: Array[Array[List[Answer]]]
   = Array.ofDim(input.length + 1, input.length +1)

  val matrixGrammar: Parser[(Int,Int,Int)] = ((
    aMatrix ^^ single
  | (matrixGrammar +~+ matrixGrammar) ^^ {case (a1,a2) => mult(a1, a2)}
  ) aggregate h).tabulate("M", costMatrix)
}

object MatrixMultB extends MatrixGrammarB with GenB with App{
  def input = Array((10,100),(100,5),(5,50))
  val costs = bottomUp(matrixGrammar, costMatrix)

  //println(costs(0)(0))
  for(i <- 0 to input.length){
    for(j <- 0 to input.length){
      print(
        costs(i)(j) + " "
        //if(costs(i)(j).isEmpty) "empty  " else costs(i)(j).head + " "
      )
    }
    println()
  }

  println(matrixGrammar(0,input.length))
}*/
