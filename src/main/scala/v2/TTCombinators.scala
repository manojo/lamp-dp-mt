package v2.examples

import v2._

// Two-tracks combinators: subword := (end_in1, end_in2)
// Main difference with ADP parsers is the concat operators and
// the two inputs. Otherwise everything is very similar.
// We shall look forward merging/reusing.
trait TTParsers extends CodeGen { this:Signature =>
  override val twotracks = true
  private var input1: Input = null
  private var input2: Input = null
  def in1(k:Int):Alphabet = input1(k)
  def in2(k:Int):Alphabet = input2(k)
  def size1:Int = input1.size
  def size2:Int = input2.size

  def parse(p:Parser[Answer])(in1:Input,in2:Input):List[Answer] = {
    input1=in1; input2=in2; val res=p(size1,size2); input1=null; input2=null; res
  }

  // Memoization through tabulation
  import scala.collection.mutable.HashMap
  def tabulate(name:String, inner:Parser[Answer]) = new Parser[Answer] {
    val map = tabs.getOrElseUpdate(name,new HashMap[Subword,List[Answer]])
    rules += ((name,this))
    def apply(sw: Subword) = map.getOrElseUpdate(sw, inner(sw))
    def tree = PRule(name)
    override def makeTree = inner.tree
  }

  abstract class Parser[T] extends (Subword => List[T]) with Treeable { inner =>
    def apply2(sw:Subword, k:Int): List[T] = apply(sw)

    // ========================== duplicated from ADPParsers.Parsers
    def ^^[U](f: T => U) = this.map(f)
    private def map[U](f: T => U) = new Parser[U] {
      def apply(sw:Subword) = inner(sw) map f
      def tree = PMap(f,inner.tree)
    }
    def |(that: => Parser[T]) = or(that)
    private def or (that: => Parser[T]) = new Parser[T] {
      def apply(sw: Subword) = inner(sw)++that(sw)
      def tree = POr(inner.tree, that.tree)
    }
    def aggregate(h: List[T] => List[T]) = new Parser[T] {
      def apply(sw: Subword) = h(inner(sw))
      def tree = PAggr(h,inner.tree)
    }
    def filter (p: Subword => Boolean) = new Parser[T] {
      def apply(sw: Subword) = if(p(sw)) inner(sw) else List[T]()
      def tree = PFilter(p, inner.tree)
    }
    // ========================== duplicated end

    def concat1[U](l:Int,u:Int)(that: => Parser[U]) = new Parser[(T,U)] {
      def tree = PConcatTT(inner.tree,that.tree,false,(l,u))
      def apply(sw: Subword) = sw match {
        case (i,j) =>
          val i0 = if (l==0) 0 else Math.max(i-l,0)
          for(
            k <- (i0 to i-u).toList;
            x <- inner.apply2((i,j),k);
            y <- that((k,j))
          ) yield((x,y))
        case _ => List()
      }
    }
    def ++~ [U](that: => Parser[U]) = concat1(0,1)(that)
    def +~~ [U](that: => Parser[U]) = concat1(0,0)(that)
    def -~~ [U](that: => Parser[U]) = concat1(1,1)(that)

    def concat2[U](l:Int,u:Int)(that: => Parser[U]) = new Parser[(T,U)] {
      def tree = PConcatTT(inner.tree,that.tree,true,(l,u))
      def apply(sw: Subword) = sw match {
        case (i,j) =>
          val j0 = if (l==0) 0 else Math.max(j-l,0)
          for(
            k <- (j0 to j-u).toList;
            x <- inner((i,k));
            y <- that.apply2((i,j),k)
          ) yield((x,y))
        case _ => List()
      }
    }
    def ~++ [U](that: => Parser[U]) = concat2(0,1)(that)
    def ~~+ [U](that: => Parser[U]) = concat2(0,0)(that)
    def ~~- [U](that: => Parser[U]) = concat2(1,1)(that)
  }

  def empty = new Parser[Dummy] {
    def tree = PTerminal{(i:Var,j:Var) => (List(zero.leq(i,1),zero.leq(j,1)),"empty")}
    def apply(sw:Subword) = sw match { case (i,j) => if(i==0 && j==0) List(new Dummy) else Nil }
  }
  def el1 = new Parser[Alphabet] {
    def tree = PTerminal{(i:Var,j:Var) => (List(zero.leq(i,1)),"in1["+i.add(-1)+"]")}
    def apply(sw:Subword) = sw match { case (i,j) => if(0 < i) List(in1(i-1)) else Nil }
  }
  def el2 = new Parser[Alphabet] {
    def tree = PTerminal{(i:Var,j:Var) => (List(zero.leq(j,1)),"in2["+j.add(-1)+"]")}
    def apply(sw:Subword) = sw match { case (i,j) => if(0 < j) List(in2(j-1)) else Nil }
  }
  // non-empty string, return (start,end)
  def seq1 = new Parser[(Int,Int)] {
    def tree = PTerminal{(i:Var,j:Var) => (List(zero.leq(i,1)),"seq1[??k??,"+i+"]")}
    def apply(sw:Subword) = Nil // should never be called
    override def apply2(sw:Subword, k:Int) = sw match { case (i,j) => if (0 < i) List((k,i)) else Nil }
  }
  def seq2 = new Parser[(Int,Int)] {
    def tree = PTerminal{(i:Var,j:Var) => (List(zero.leq(j,1)),"seq2[??k??,"+j+"]")}
    def apply(sw:Subword) = Nil // should never be called
    override def apply2(sw:Subword, k:Int) = sw match { case (i,j) => if (0 < j) List((k,j)) else Nil }
  }
}
