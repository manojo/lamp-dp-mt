package reflect

import scala.reflect.runtime.{universe => u}
import scala.reflect.runtime.universe.Expr
import scala.tools.reflect.Eval

trait ADPParsers extends CodeGen { this:Signature =>
  // Input is a "global" value, used during the whole running time of algorithm
  private var input: Input = null
  def in(k:Int):Alphabet = input(k % size) // to deal with cyclic
  def size:Int = input.size

  def parse(p:Parser[Answer])(in:Input):List[Answer] = {
    input = in;
    lazy val hh = h.eval
    val res = if (cyclic) hh( ((0 until size).flatMap{ x => p(x,size+x) }).toList )
              else if (window>0) hh( ((0 to size-window).flatMap{ x => p(x,window+x) }).toList )
              else p(0,size)
    input = null; res
  }

  // Memoization through tabulation
  import scala.collection.mutable.HashMap
  def tabulate(name:String, p: => Parser[Answer]) = new Parser[Answer] {
    val map = tabs.getOrElseUpdate(name,new HashMap[Subword,List[Answer]])
    rules += ((name,this))

    lazy val inner = p
    def apply(sw: Subword) = sw match {
      case (i,j) if(i <= j) => map.getOrElseUpdate(if(cyclic) (i%size, j%size) else sw, inner(sw))
      case _ => List()
    }
    def tree = PRule(name)
    override def makeTree = inner.tree
  }

  abstract class Parser[T] extends (Subword => List[T]) with Treeable { inner =>
    def apply(sw: Subword): List[T]

    // Mapper. Equivalent of ADP's <<< operator.
    // To separate left and right hand side of a grammar rule
    def ^^[U](f: Expr[Function1[T,U]])(implicit tag: u.TypeTag[U]) = this.map(f)
    private def map[U](f: Expr[Function1[T,U]])(implicit tag: u.TypeTag[U]) = new Parser[U] {
      lazy val ff = f.eval
      def apply(sw:Subword) = inner(sw) map ff
      def tree = PMap(f,inner.tree,tag)
    }

    // Or combinator. Equivalent of ADP's ||| operator.
    // In ADP semantics we concatenate the results of the parse
    // of 'this' with the parse of 'that'
    def |(that:Parser[T]) = or(that)
    private def or (that:Parser[T]) = new Parser[T] {
      def apply(sw: Subword) = inner(sw)++that(sw)
      def tree = POr(inner.tree, that.tree)
    }

    // Aggregate combinator.
    // Takes a function which modifies the list of a parse. Usually used
    // for max or min functions (but can also be a prettyprint).
    def aggregate(h: Expr[Function1[List[T],List[T]]]) = new Parser[T] {
      lazy val hh = h.eval
      def apply(sw: Subword) = hh(inner(sw))
      def tree = PAggr(h,inner.tree)
    }

    // Filter combinator.
    // Yields an empty list if the filter does not pass.
    def filter (p: Expr[Function1[Subword,Boolean]]) = new Parser[T] {
      lazy val pp=p.eval
      def apply(sw: Subword) = if(pp(sw)) inner(sw) else List[T]()
      def tree = PFilter(p, inner.tree)
    }

    // Concatenate combinator.
    // Parses a concatenation of string left~right with length(left) in [lL,lU]
    // and length(right) in [rL,rU], lU,rU=0 means unbounded (infinity).
    private def concat[U](lL:Int, lU:Int, rL:Int, rU:Int)(that:Parser[U]) = new Parser[(T,U)] {
      def apply(sw: Subword) = sw match {
        case (i,j) if i<j =>
          val min_k = if (rU==0) i+lL else Math.max(i+lL,j-rU)
          val max_k = if (lU==0) j-rL else Math.min(j-rL,i+lU)
          for(
            k <- (min_k to max_k).toList;
            x <- inner((i,k));
            y <- that((k,j))
          ) yield((x,y))
        case _ => List()
      }
      def tree = PConcat(inner.tree, that.tree, (lL,lU,rL,rU))
    }

    def ~~~ [U](that:Parser[U]) = concat(0,0,0,0)(that)
    def ~~+ [U](that:Parser[U]) = concat(0,0,1,0)(that)
    def +~~ [U](that:Parser[U]) = concat(1,0,0,0)(that)
    def +~+ [U](that:Parser[U]) = concat(1,0,1,0)(that)

    def *~~ [U](lMin:Int, rRange:Pair[Int,Int], that:Parser[U]) = concat(lMin,0,rRange._1,rRange._2)(that)
    def ~~* [U](lRange:Pair[Int,Int], rMin:Int, that:Parser[U]) = concat(lRange._1,lRange._2,rMin,0)(that)
    def *~* [U](lMin:Int, rMin:Int, that: => Parser[U]) = concat(lMin,0,rMin,0)(that)

    def ~~ [U](lRange:Pair[Int,Int], rRange:Pair[Int,Int], that:Parser[U]) = concat(lRange._1,lRange._2,rRange._1,rRange._2)(that)

    def -~~ [U](that:Parser[U]) = concat(1,1,0,0)(that)
    def ~~- [U](that:Parser[U]) = concat(0,0,1,1)(that)
  }

  def empty = new Parser[Dummy] {
    def tree = PTerminal{(i:Var,j:Var) => (List(i.eq(j,0)),"empty")}
    def apply(sw:Subword) = sw match { case (i,j) => if (i==j) List(new Dummy) else Nil }
  }
  def el = new Parser[Alphabet] {
    def tree = PTerminal{(i:Var,j:Var) => (List(i.eq(j,1)),"in["+i+"]")}
    def apply(sw:Subword) = sw match { case (i,j) => if(i+1==j) List(in(i)) else Nil }
  }
  def eli = new Parser[Int] {
    def tree = PTerminal{(i:Var,j:Var) => (List(i.eq(j,1)),""+i)}
    def apply(sw:Subword) = sw match { case (i,j) => if(i+1==j) List(i) else Nil }
  }
  def seq(min:Int, max:Int) = new Parser[(Int,Int)] {
    def tree = PTerminal{(i:Var,j:Var) => (List(i.leq(j,min),(j.leq(i,max))),"in["+i+","+j+"]")}
    def apply(sw:Subword) = sw match { case (i,j) => if (i+min<=j && (max==0 || i+max>=j)) List((i,j)) else Nil }
  }
}

trait LexicalParsers extends ADPParsers { this:Signature =>
  override type Alphabet = Char
  def char = el
  def chari = eli
  def charf(f: Expr[Function1[Char,Boolean]]) = el filter u.reify {
    println(f)
    lazy val ff=f.eval
    (sw:Subword) => sw match {
      case(i,j) if(i+1==j) => ff(in(i))
      case _ => false
    }
  }
  def digit: Parser[Int] = (charf(u.reify{(c:Char)=>c.isDigit})) ^^ u.reify{ (c:Char)=>(c-'0').toInt }
}
