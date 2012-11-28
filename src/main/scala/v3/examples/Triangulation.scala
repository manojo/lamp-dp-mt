package v3.examples
import v3._

// Convex polygon triangulation problem
trait TriangulationSignature extends Signature {
  override val cyclic = true
}

trait TriangulationAlgebra extends TriangulationSignature {
  override type Alphabet = Char // name of the vertex

  type Answer = (Int,Int,Int,String) // start, end, cost, pretty-print
  override val h = (l:List[Answer]) => if(l.isEmpty) List() else List(l.minBy(_._3))
}

object Triangulation extends LexicalParsers with TriangulationAlgebra {
  def edge(a:Int,b:Int):Int = (in(a),in(b)) match {
    case (a,b) if (a==b) => -1000 // should never happen
    case ('a','d') | ('a','e') | ('b','d') => 1
    case ('d','a') | ('e','a') | ('d','b') => 1
    case _ => 2
  }

  // string concat with "-"
  def ccat(s1:String,s2:String) = s1+(if (s1!=""&&s2!="")"-" else "")+s2

  val triangle = new Parser[Answer] {
    val tree = PTerminal{(_,_)=> (Nil,"triangle")}
    def apply(sw:Subword) = sw match { // we need to use in() instead of input for cyclic
      case (i,j) if(j == i+2) => List(((i,j, edge(i,j), in(i)+""+in(j) ),bt0))
      case (i,j) => List()
    }
  }

  val triangulation: Parser[Answer] = tabulate("M",(
    chari ^^ { i => (i,i+1,0,"") }
  | triangulation +~+ triangulation ^^ { case((a1,b1,c1,s1),(a2,b2,c2,s2)) => // assert((a2-b1)%size==0);
      val (s,c) = if (Math.abs(a1%size-b2%size)<=1) ("",0) else (in(a1)+""+in(b2), edge(a1,b2))
      ( a1, b2, c1+c2+c, ccat(ccat(s1,s2),s) )
    }
  ) aggregate h)

  def main(args: Array[String]) = {
    println(parse(triangulation)("abcdef"))
    println(gen)
  }
}
