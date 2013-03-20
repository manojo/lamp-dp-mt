package v4.fpga
import v4._

// MMAlpha code generator
// See: http://www.irisa.fr/cosi/ALPHA/index.html
//
// Restriction that apply: (we may relax some later)
// - Two-track grammar (TTParsers)
// - We only care about result (aka no backtrack)
// - We have at most 1 rule in the grammar (axiom)
// - That rule _always_ generate some result (aka tabulate.alwaysValid=true)
// - No nested aggregation
// - Only serial dependencies, aka access M[i-k,j-l] with k,l bounded
// XXX: shall we encode them somewhere ?

trait FPGACodeGen extends CodeGen with TTParsers { this:Signature=>
  // Avoid CUDA to automatically kick-in when mixing CodeGen
  override def parse(in1:Input,in2:Input,ps:ParserStyle=psBottomUp):List[Answer] = super.parse(in1,in2,ps)
  override def backtrack(in1:Input,in2:Input,ps:ParserStyle=psBottomUp):List[(Answer,Trace)] = super.backtrack(in1,in2,ps)
  // ---- END ----

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
        case _ => sys.error("Does not appear in TTParsers")
      }
    case t:Tabulate => ()
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

  override def gen:String = {
    analyze; val rs=rulesOrder.map{n=>rules(n)}
    // Split the domain in tiles where different set of parsers apply
    computeDomains(axiom.inner) //for (r<-rs) computeDomains(r.inner)
    val(ix, jx) = ((is - (-1)).toArray.sorted,  (js - (-1)).toArray.sorted)

    //println(ix.toList); println(jx.toList)

    println("case")
    for(i <- 0 until ix.length; j <- 0 until jx.length){
      print("{ |")
      print(  "i >= " + ix(i) + (if(i == ix.length -1) "" else "; i < " + ix(i+1)))
      print("; j >= " + jx(j) + (if(j == jx.length -1) "" else "; j < " + jx(j+1)))
      print("} : ")
      getRulesFor(axiom.inner, ix(i), jx(j)) match {
        case Some(p) => println(genTab(tabulate("tab"+i+"_"+j,p))) // XXX: use a Tabulation -> Parser transform => XXX: use custom codegen instead
        case _ => sys.error("No parser applies")
      }
      //println(getRulesFor(axiom, ix(i), jx(j)))
    }
    println("esac;")
    ""
  }

}
