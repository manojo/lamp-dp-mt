package v4.fpga
import v4._

trait FPGACodeGen extends CodeGen with TTParsers { this:Signature=>
  val is = scala.collection.mutable.Set[Int]()
  val js = scala.collection.mutable.Set[Int]()

  def computeDomains[T](p: Parser[T]): Unit = p match {
    case Terminal(min,max,_) => is ++= Set(min,max); js ++= Set(min,max)
    case Filter(p,_) => computeDomains(p)
    case Aggregate(p,_) => computeDomains(p)
    case Map(p,_) => computeDomains(p)
    case Or(l,r) => computeDomains(l); computeDomains(r)
    case c@Concat(l,r,t) => computeDomains(l); computeDomains(r); val x=c.indices;
      t match {
        case 1 => is ++= Set(x._1, x._2)
        case 2 => js ++= Set(x._3, x._4)
        case _ => // XXX
      }
    case p:Tabulate => ()
  }

  def getRulesFor[T](p: Parser[T], i: Int, j: Int): Option[Parser[T]] = p match {
    case t@Terminal(_,_,_) => t match {
      case `el1` => if(i > 0) Some(t) else None
      case `el2` => if(j > 0) Some(t) else None
      case `empty` => if(i == 0 && j == 0) Some(t) else None
      case _ => Some(t)
    }
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
