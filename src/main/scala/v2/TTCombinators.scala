package v2.examples

import v2._

// Two-tracks combinators
// Main difference with ADP parsers is the concat operators and
// the two inputs. Otherwise everything is very similar.
// We shall look forward merging/reusing.
trait TTParsers { this:Signature =>
  type Subword = (Int, Int) // (end_in1, end_in2)
  type Input = Array[Alphabet]

  private var input1: Input = null
  private var input2: Input = null
  def in1(k:Int):Alphabet = input1(k)
  def in2(k:Int):Alphabet = input2(k)
  def size1:Int = input1.size
  def size2:Int = input2.size

  import scala.collection.mutable.HashMap
  val tabs = new HashMap[String,HashMap[Subword,List[Answer]]]
  val rules = new HashMap[String,Parser[Answer]]
  def tabulate(name:String, inner:Parser[Answer]) = new Parser[Answer] {
    val map = tabs.getOrElseUpdate(name,new HashMap[Subword,List[Answer]])
    rules += ((name,this))
    def apply(sw: Subword) = map.getOrElseUpdate(sw, inner(sw))
  }

  abstract class Parser[T] { inner =>
    def apply2(sw:Subword, k:Int): List[T] = apply(sw)

    // --- duplicated from ADPParsers.Parsers
    def apply(sw: Subword): List[T]
    def ^^[U](f: T => U) = this.map(f)
    private def map[U](f: T => U) = new Parser[U] { def apply(sw:Subword) = inner(sw) map f }
    def |(that: => Parser[T]) = or(that)
    private def or (that: => Parser[T]) = new Parser[T] { def apply(sw: Subword) = inner(sw)++that(sw) }
    def aggregate[U](h: List[T] => List[U]) = new Parser[U] { def apply(sw: Subword) = h(inner(sw)) }
    def filter (p: Subword => Boolean) = new Parser[T] { def apply(sw: Subword) = if(p(sw)) inner(sw) else List[T]() }
    // --- duplicated end

    def concat1[U](l:Int,u:Int)(that: => Parser[U]) = new Parser[(T,U)] {
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

  def parse(p:Parser[Answer])(in1:Input,in2:Input):List[Answer] = {
    input1=in1; input2=in2;
    val res=p(size1,size2)
    input1=null; input2=null; res
  }

  def empty = new Parser[Dummy] { def apply(sw:Subword) = if (sw._1==0 && sw._2==0) List(new Dummy) else List() }
  def el1 = new Parser[Alphabet] { def apply(sw:Subword) = if (0 < sw._1) List(in1(sw._1-1)) else List() }
  def el2 = new Parser[Alphabet] { def apply(sw:Subword) = if (0 < sw._2) List(in2(sw._2-1)) else List() }

  // non-empty string, return (start,end)
  def seq1 = new Parser[(Int,Int)] {
    def apply(sw:Subword) = List() // should never be called
    override def apply2(sw:Subword, k:Int) = if (0 < sw._1) List((k,sw._1)) else List()
  }
  def seq2 = new Parser[(Int,Int)] {
    def apply(sw:Subword) = List() // should never be called
    override def apply2(sw:Subword, k:Int) = if (0 < sw._1) List((k,sw._2)) else List()
  }
}
