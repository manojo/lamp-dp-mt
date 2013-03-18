package v4.report
import v4._

trait FPGACodegen extends CodeGen with SeqAlignGrammar with SmithWatermanAlgebra{

//  val seq1 = "CGATTACA"
//  val seq2 = "CCCATTAGAG"
  override val tps=(manifest[Alphabet],manifest[Answer])

  val is = scala.collection.mutable.Set[Int]()
  val js = scala.collection.mutable.Set[Int]()

  def computeDomains[T](p: Parser[T]): Unit = p match {
    case Terminal(min,max,_) => is ++= Set(min,max); js ++= Set(min,max)
    case Filter(p,_) => computeDomains(p)
    case Aggregate(p,_) => computeDomains(p)
    case Map(p,_) => computeDomains(p)
    case Or(l,r) => computeDomains(l); computeDomains(r)
    case c@Concat(l,r,1) => computeDomains(l); computeDomains(r); is ++= Set(c.indices._1, c.indices._2)
    case c@Concat(l,r,2) => computeDomains(l); computeDomains(r); js ++= Set(c.indices._3, c.indices._4)
    case p:Tabulate => ()
  }

  def getRulesFor[T](p: Parser[T], i: Int, j: Int): Option[Parser[T]] = p match {
    case el1 => if(i > 0) Some(el1) else None
    case el2 => if(j > 0) Some(el2) else None
    case empty => if(i == 0 && j == 0) Some(empty) else None
    case t@Terminal(_,_,_) => Some(t)
    case Filter(p,f) => getRulesFor(p,i,j).map{ p2 => Filter(p2,f)}
    case Aggregate(p,h) => getRulesFor(p,i,j).map{ p2 => Aggregate(p2,h)}
    case Map(p,f) => getRulesFor(p,i,j).map{ p2 => Map(p2,f)}
    case Or(l,r) => (getRulesFor(l,i,j), getRulesFor(r,i,j)) match {
      case (None, None) => None
      case (x@Some(_), None) => x
      case (None, y@Some(_)) => y
      case (Some(x), Some(y)) => Some(Or(x,y))
    }
    case c@Concat(l,r,t) => (getRulesFor(l,i,j), getRulesFor(r,i,j)) match {
      case (None, _) | (_, None) => None
      case (Some(x), Some(y)) => Some(new Concat(x,y,t) { override lazy val indices=c.indices })
    }
    case p:Tabulate => Some(p)
  }

  /*
  def prettyPrint[T](p: Parser[T]):String = p match{
    case el1 => "Seq1[i]"
    case el2 => if(j > 0) Some(el2) else None
    case empty => if(i == 0 && j == 0) Some(empty) else None
    case t : Terminal => Some(t)
    case Filter(p,f) => getRulesFor(p,i,j).map{ p2 => Filter(p2,f)}
    case Aggregate(p,h) => getRulesFor(p,i,j).map{ p2 => Aggregate(p2,h)}
    case Map(p,f) => getRulesFor(p,i,j).map{ p2 => Map(p2,f)}
    case Or(l,r) => (getRulesFor(l,i,j), getRulesFor(r,i,j)) match {
      case (None, None) => None
      case (x : Some, None) => x
      case (None, y : Some) => y
      case (Some(x), Some(y)) => Some(Or(x,y))
    }
    case c@Concat(l,r,t) => (getRulesFor(l,i,j), getRulesFor(r,i,j)) match {
      case (None, _) | (_, None) => None
      case (Some(x), Some(y)) => Some(new Concat(x,y,t) { override lazy val indices=c.indices })
    }
    case p:Tabulate => Some(p)
  }
  */

  override def genFun[T,U](f0:T=>U):String = "fun(<>)"


}


object SWat2 extends SeqAlignGrammar with SmithWatermanAlgebra with FPGACodegen with App{

  println("Hi!")

/*  SWat2.analyze
  SWat2.computeDomains(SWat2.axiom.inner)
  //is -= -1; js -= -1
  val(sortedis, sortedjs) = ((is - (-1)).toArray.sorted,  (js - (-1)).toArray.sorted)
  println(is); println(js)
  println((sortedis, sortedjs))

  println("case")

  for(i <- 0 until sortedis.length;
      j <- 0 until sortedjs.length
  ){
    print("{ |")
    print(  "i >= " + sortedis(i) + (if(i == sortedis.length -1) "" else "; i < " + sortedis(i+1)))
    print("; j >= " + sortedjs(j) + (if(j == sortedjs.length -1) "" else "; j < " + sortedjs(j+1)))
    print("} : ")
    println(getRulesFor(axiom, sortedis(i), sortedjs(j))))
  }
  println("esac;")
*/
  analyze
  println(
    genTab(axiom)
  )
}




