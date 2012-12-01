package v3.examples
import v3._

// Convex polygon triangulation problem
trait TriangulationSignature extends Signature {
  override type Alphabet = Char // name of the vertex
}

trait TriangulationAlgebra extends TriangulationSignature {
  type Answer = (Int,Int,Int,String) // start, end, cost, pretty-print
  override val h = (l:List[Answer]) => if(l.isEmpty) List() else List(l.minBy(_._3))
}

object Triangulation extends LexicalParsers with TriangulationAlgebra {
  def edge(a:Int,b:Int):Int = (in(if(b==size)0 else a),in(if(b==size)a else b)) match {
    case ('a','d') | ('a','e') | ('b','d') => 1
    case _ => 2
  }

  // string concat with "-"
  def ccat(s1:String,s2:String) = s1+(if (s1!=""&&s2!="")"-" else "")+s2

  val triangulation: Tabulate = tabulate("M",(
    chari ^^ { i => (i,i+1,0,"") }
  | triangulation +~+ triangulation ^^ { case((a1,b1,c1,s1),(a2,b2,c2,s2)) =>
      val (s,c) = if (Math.abs(a1%size-b2%size)<=1) ("",0) else (in(a1)+""+in(b2%size), edge(a1,b2))
      ( a1, b2, c1+c2+c, ccat(ccat(s1,s2),s) )
    }
  ) aggregate h)

  val axiom=triangulation

  def main(args: Array[String]) = {
    println(parse("abcdef"))
    printBT(backtrack("abcdef"))
    println(gen)
  }
}
