package vanilla

trait Signature {
  type Alphabet // input type
  type Answer   // output type

  def h(l: List[Answer]) : List[Answer]
}

trait ADPParsers { this:Signature =>
  type Subword = (Int, Int)
  type Input = Array[Alphabet]

  // Input is a "global" value, used during the whole running time of algorithm
  def input: Input

  // A simple variable generator that sequentially issues free variables
  class FreeVar(v0:Char) {
    private var v=v0;
    def get:String = { var r=""+v; v=(v+1).toChar; r }
    def dup=new FreeVar(v0)
  }

  // Tree structure for recurrences generation
  abstract class PTree {
    // 1. Assign to each node its bounds (i,j)
    // 2. Collect all the conditions from the tree and its content body
    // Given bounds [i,j] and a FreeVar generator, returns a list of conditions/loops and the body of the operator
    def gen(i:String,j:String,g:FreeVar):(List[String],String) = (Nil,toString)
    def emit(d:(List[String],String)):String = d match { case (cs,b) => cs.map{x=>x+" { "}.mkString("")+b+cs.map{x=>" } "}.mkString("") }
    def emit:String = emit(gen("i","j",new FreeVar('k')))
  }
  case class PTerminal[T](f:(String,String) => (String,String)) extends PTree { // f must return (condition||null, body)
    override def gen(i:String,j:String,g:FreeVar) = { var (c,b)=f(i,j); (if(c==null)Nil else List("if ("+c+")"),b) }
  }
  case class PAggr[T,U](h: List[T] => List[U], p: PTree) extends PTree {
    override def gen(i:String,j:String,g:FreeVar) = { val (c,b)=p.gen(i,j,g); (c, "Best("+b+")") }
  }
  case class POr(l: PTree, r: PTree) extends PTree {
    override def gen(i:String,j:String,g:FreeVar) = (Nil, emit(l.gen(i,j,g.dup))+" ++ "+emit(r.gen(i,j,g.dup)))
  }
  case class PMap[T,U](f: T => U, p: PTree) extends PTree {
    override def gen(i:String,j:String,g:FreeVar) = { val (c,b)=p.gen(i,j,g); (c, "Map("+b+")") }
  }
  case class PFilter(f: Subword => Boolean, p: PTree) extends PTree {
    override def gen(i:String,j:String,g:FreeVar) = { val (c,b)=p.gen(i,j,g); (c, "Filter("+b+")") } // XXX: this translates to an if
  }
  case class PRule(name:String) extends PTree {
    override def gen(i:String,j:String,g:FreeVar) = (Nil, name+"["+i+","+j+"]")
  }
  case class PConcat(l: PTree, r: PTree, indices:(Int,Int,Int,Int)) extends PTree {
    override def gen(i:String,j:String,g:FreeVar) = {

      // XXX: optimize for stupid condition verifications, use (char,delta) to encode incides possibly


      def bf1(f:Int, l:Int, u:Int) = "if ("+i+"+"+(f+l)+"<="+j+(if(u>0)" && "+i+"+"+(f+u)+">="+j else "")+")"
      val (c,k) = indices match {
        // low=up in at least one side
        case (0,0,0,0) => val k0=g.get; ("for ("+i+"<="+k0+"<="+j+")", k0)
        case (iL,iU,0,0) if (iL==iU) => ("if ("+i+"+"+iL+"<"+j+")", i+"+"+iL)
        case (0,0,jL,jU) if (jL==jU) => ("if ("+i+"+"+jL+"<"+j+")", j+"-"+jL)
        case (iL,iU,jL,jU) if (iL==iU && jL==jU) => ("if ("+i+"+"+(iL+jL)+"=="+j+")", i+"+"+iL)
        case (iL,iU,jL,jU) if (iL==iU) => (bf1(iL,jL,jU), i+"+"+iL)
        case (iL,iU,jL,jU) if (jL==jU) => (bf1(jL,iL,iU), j+"-"+jL)
        // most general case
        case (iL,iU,jL,jU) =>
          val min_k = if (jU==0) i+"+"+iL else "max("+i+"+"+iL+","+j+"-"+jU+")"
          val max_k = if (iU==0) j+"-"+jL else "min("+j+"-"+jL+","+i+"+"+iU+")"
          // we might want to simplify if min_k==i || max_k==j
          val k0=g.get; ("int min_"+k0+"="+min_k+",max_"+k0+"="+max_k+"; for(min_"+k0+"<="+k0+"<=max_"+k0+")", k0)
      }
      val (lc,lb) = l.gen(i,k,g)
      val (rc,rb) = r.gen(k,j,g)
      (c :: lc ::: rc, lb+" ~ "+rb)
    }
  }

  // Memoization through tabulation
  import scala.collection.mutable.HashMap
  val tabs = new HashMap[String,HashMap[Subword,List[Answer]]]
  val rules = new HashMap[String,Parser[Answer]]
  def tabulate(name:String, inner:Parser[Answer]) = new Parser[Answer] {
    val map = tabs.getOrElseUpdate(name,new HashMap[Subword,List[Answer]])
    rules += ((name,this))

    def apply(sw: Subword) = sw match {
      case (i,j) if(i <= j) => map.getOrElseUpdate(sw, inner(sw))
      case _ => List()
    }
    def tree = PRule(name)
    override def makeTree = inner.tree
  }

  def gen:String = {
    println("------------ rules ------------")
    for((n,p) <- rules) {
      println( n+"[i,j] => "+p.asInstanceOf[Parser[Any]].makeTree.emit )
    }
    println("------------- end -------------")
    "Hash maps: "+tabs.size
  }

  abstract class Parser[T] extends (Subword => List[T]) { inner =>
    def apply(sw: Subword): List[T]
    def tree : PTree
    def makeTree = tree

    // Mapper. Equivalent of ADP's <<< operator.
    // To separate left and right hand side of a grammar rule
    def ^^[U](f: T => U) = this.map(f)
    private def map[U](f: T => U) = new Parser[U]{
      def apply(sw:Subword) = inner(sw) map f
      def tree = PMap(f,inner.tree)
    }

    // Or combinator. Equivalent of ADP's ||| operator.
    // In ADP semantics we concatenate the results of the parse
    // of 'this' with the parse of 'that'
    def |(that: => Parser[T]) = or(that)
    private def or (that: => Parser[T]) = new Parser[T]{
      def apply(sw: Subword) = inner(sw)++that(sw)
      def tree = POr(inner.tree, that.tree)
    }

    // Aggregate combinator.
    // Takes a function which modifies the list of a parse. Usually used
    // for max or min functions (but can also be a prettyprint).
    def aggregate[U](h: List[T] => List[U]) = new Parser[U]{
      def apply(sw: Subword) = h(inner(sw))
      def tree = PAggr(h,inner.tree)
    }

    // Concatenate combinator.
    // Parses a concatenation of string left~right with length(left) in [lL,lU]
    // and length(right) in [rL,rU], lU,rU=0 means unbounded (infinity).
    private def concat[U](lL:Int, lU:Int, rL:Int, rU:Int)(that: => Parser[U]) = new Parser[(T,U)] {
      def apply(sw: Subword) = sw match {
        case (i,j) if i<j =>
          val min_k = if (rU==0) i+lL else Math.max(i+lL,j-rU)
          val max_k = if (lU==0) j-rL else Math.min(j-rL,i+lU)
          for(
            k <- (min_k to max_k).toList;
            x <- inner((i,k));
            y <- that((k,j))
          ) yield((x,y))
        case _ => List[(T,U)]()
      }
      def tree = PConcat(inner.tree, that.tree, (lL,lU,rL,rU))
    }

    def ~~~ [U](that: => Parser[U]) = concat(0,0,0,0)(that)
    def ~~+ [U](that: => Parser[U]) = concat(0,0,1,0)(that)
    def +~~ [U](that: => Parser[U]) = concat(1,0,0,0)(that)
    def +~+ [U](that: => Parser[U]) = concat(1,0,1,0)(that)

    def *~~ [U](lMin:Int, rRange:Pair[Int,Int], that: => Parser[U]) = concat(lMin,0,rRange._1,rRange._2)(that)
    def ~~* [U](lRange:Pair[Int,Int], rMin:Int, that: => Parser[U]) = concat(lRange._1,lRange._2,rMin,0)(that)
    def *~* [U](lMin:Int, rMin:Int, that: => Parser[U]) = concat(lMin,0,rMin,0)(that)

    def ~~ [U](lRange:Pair[Int,Int], rRange:Pair[Int,Int], that: => Parser[U]) = concat(lRange._1,lRange._2,rRange._1,rRange._2)(that)

    def -~~ [U](that: => Parser[U]) = concat(1,1,0,0)(that)
    def ~~- [U](that: => Parser[U]) = concat(0,0,1,1)(that)

    // Filter combinator.
    // Yields an empty list if the filter does not pass.
    def filter (p: Subword => Boolean) = new Parser[T] {
      def apply(sw: Subword) = if(p(sw)) inner(sw) else List[T]()
      def tree = PFilter(p, inner.tree)
    }
  }
}

trait LexicalParsers extends ADPParsers { this:Signature =>
  override type Alphabet = Char

  def char = new Parser[Char]{
    def apply(sw:Subword) = sw match {
      case (i, j) if(j == i+1) => List(input(i))
      case _ => List()
    }
    def tree = new PTerminal((i:String,j:String) => (i+"+1=="+j,"Char["+i+"]"))
  }

  def charf(f: Char => Boolean) = char filter {
    case(i,j) if(i+1 == j) => f(input(i))
    case _ => false
  }

  def digitParser: Parser[Int] = (char filter isDigit) ^^ readDigit
  def readDigit(c: Char) = (c - '0').toInt
  def isDigit(sw: Subword) = sw match {
    case(i,j) if(i+1 == j) => input(i).isDigit
    case _ => false
  }
}

/*** Example ***/

trait BracketsSignature extends Signature {
  def readDigit(c: Alphabet) : Answer
  def bracket(l: Alphabet, s: Answer, r: Alphabet) : Answer
  def split(s: Answer, t: Answer): Answer
}

trait BracketsAlgebra extends BracketsSignature {
  type Answer = Int
  override type Alphabet = Char

  def bracket(l: Char, s: Int, r: Char) = s
  def split(s: Int, t: Int) = s+t
  def h(l : List[Int]) = if(l.isEmpty) List() else List(l.max)
}

object HelloADP extends LexicalParsers with BracketsAlgebra {
  def input = "(((3)))(2)".toArray
  def bracketize(c:Char,s:String) = "("+c+","+s+")"

  def areBrackets(sw: Subword) = sw match {
    case(i,j) => input(i) == '(' && input(j-1) == ')'
  }

  val dummyParser = digitParser | digitParser
  val myParser: Parser[Int] = tabulate("M",
      digitParser
    | (char -~~ myParser ~~- char).filter(areBrackets _).^^{ case (c1,(i,c2)) => i}
    | myParser +~+ myParser ^^ {case (x,y) => x+y}
  )

  def main(args: Array[String]) = {
    println(myParser(0,input.length))
    println(gen)
  }
}
