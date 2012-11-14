package v2.examples

import v2._

// Convex polygon triangulation problem
trait TriangulationSignature extends Signature {
  def edgeCost(v1:Char, v2:Char):Int
}

trait TriangulationAlgebra extends TriangulationSignature {
  override val cyclic = true
  override type Alphabet = Char // name of the vertex

  type Answer = (Int,Int,Int,String) // (start, end, cost, pretty-print)
  def h(l:List[Answer]) = if(l.isEmpty) List() else List(l.minBy(_._3))
}

object TriangulationApp extends LexicalParsers with TriangulationAlgebra {

  def edgeCost(v1:Char, v2:Char):Int = (v1,v2) match {
    case (a,b) if (a==b) => -100 // should not be used
    case ('a','d') | ('a','e') | ('b','d') => 1
    case ('d','a') | ('e','a') | ('d','b') => 1
    case _ => 2
  }

  def triangle = new Parser[Answer] {
    def apply(sw:Subword) = sw match { // we need to use in() instead of input for cyclic
      case (i,j) if(j == i+2) => List((i,j, edgeCost(in(i),in(j)), in(i)+""+in(j) ))
      case (i,j) => List()
    }
  }

  val size = input.size
  def triangulation: Parser[Answer] = tabulate("M",(
    chari ^^ { i => (i,i+1,0,"") }
  | triangulation +~+ triangulation ^^ { case((a1,b1,c1,s1),(a2,b2,c2,s2)) => // assert((a2-b1)%size==0);
      val (s,c) = if (Math.abs(a1%size-b2%size)<=1) ("",0) else (in(a1)+""+in(b2), edgeCost(in(a1),in(b2)))
      (a1,b2,c1+c2+c,s1+s2+s)
    }
  ) aggregate h)

  // XXX: this should be moved as argument of the parse function
  def input = "abcdef".toArray

  def main(args: Array[String]) = {
    println(parse(triangulation))
    //println(gen)
  }
}
