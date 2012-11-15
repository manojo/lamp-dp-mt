package v2.examples

import v2._

// Smith-Waterman sequence alignment
trait SWatSignature extends Signature {
  def gap(size:Int):Int
  def pair(a:Alphabet,b:Alphabet):Int
}

trait SWatAlgebra extends SWatSignature {
  override type Alphabet = Char
  type Answer = (Int,String,String) // score, string1, string2
  def h(l:List[Answer]) = if(l.isEmpty) List() else List(l.maxBy(_._1))

  private val open = 2
  private val extend = 1
  def gap(size:Int) = open + (size-1) * extend
  def pair(a:Char,b:Char) = if (a==b) 3 else -1
}

// ------------------------------------------------------------------------------------------

// Two-tracks combinators
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

    // duplicated
    def apply(sw: Subword): List[T]
    def ^^[U](f: T => U) = this.map(f)
    private def map[U](f: T => U) = new Parser[U] { def apply(sw:Subword) = inner(sw) map f }
    def |(that: => Parser[T]) = or(that)
    private def or (that: => Parser[T]) = new Parser[T] { def apply(sw: Subword) = inner(sw)++that(sw) }
    def aggregate[U](h: List[T] => List[U]) = new Parser[U] { def apply(sw: Subword) = h(inner(sw)) }
    def filter (p: Subword => Boolean) = new Parser[T] { def apply(sw: Subword) = if(p(sw)) inner(sw) else List[T]() }
    // duplicated end

    def concat1[U](l:Int,u:Int)(that: => Parser[U]) = new Parser[(T,U)] {
      def apply(sw: Subword) = sw match {
        case (i,j) => 
          val i0 = if (l==0) 0 else Math.max(i-l,0)
          for(
            k <- (i0 to i-u).toList;
            x <- inner.apply2((i,j),k);
            y <- that((k,j))
          ) yield((x,y))
        case _ => List[(T,U)]()
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
        case _ => List[(T,U)]()
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
}

// ------------------------------------------------------------------------------------------

object SWatApp extends App with TTParsers with SWatAlgebra {
  class Dummy
  def empty = new Parser[Dummy] { def apply(sw:Subword) = if (sw._1==0 && sw._2==0) List(new Dummy) else List() }
  def char1 = new Parser[Char] { def apply(sw:Subword) = if (0 < sw._1) List(in1(sw._1-1)) else List() }
  def char2 = new Parser[Char] { def apply(sw:Subword) = if (0 < sw._2) List(in2(sw._2-1)) else List() }

  // non-empty string
  def gap1 = new Parser[(Int,Int)] {
    def apply(sw:Subword) = List() // should never be called
    override def apply2(sw:Subword, k:Int) = if (0 < sw._1) List((k,sw._1)) else List()
    //def apply(sw:Subword) = if (0 < sw._1) List(sw._1) else List()
  }
  def gap2 = new Parser[(Int,Int)] {
    def apply(sw:Subword) = List() // should never be called
    override def apply2(sw:Subword, k:Int) = if (0 < sw._1) List((k,sw._2)) else List()
    //def apply(sw:Subword) = if (0 < sw._2) List(sw._2) else List()
  }


  def prettyGap(sw:Subword,in:Function1[Int,Char]):(String,String) = {
    val g=(sw._1 until sw._2).toList; (g.map{x=>in(x)}.mkString(""),g.map{x=>"-"}.mkString(""))
  }

  // Needleman-Wunsch
  def alignment: Parser[Answer] = tabulate("M",(
    empty                         ^^ { _ => (0,".",".") } // zero
  | gap1  ++~ alignment           ^^ { case (g,(score,s1,s2)) => val (g1,g2) = prettyGap(g,in1); (score-gap(g._2-g._1),s1+g1,s2+g2) } // for k=1..i : M(i-k,j) - gap(k)
  |           alignment ~++ gap2  ^^ { case ((score,s1,s2),g) => val (g1,g2) = prettyGap(g,in2); (score-gap(g._2-g._1),s1+g2,s2+g1) } // for k=1..j : M(i,j-k) - gap(k)
  | char1 -~~ alignment ~~- char2 ^^ { case (c1,((score,s1,s2),c2)) => (score+pair(c1,c2),s1+c1, s2+c2) } // M(i-1,j-1) + pair(in1(i),in2(j))
  ) aggregate h)

  def align(s1:String,s2:String) = parse(alignment)(s1.toArray,s2.toArray)

  val (score,s1,s2) = align("GATTACA","CCCATTAGAG").head
  println("Score: "+score+"\nSeq1: "+s1+"\nSeq2: "+s2)

  // C implementation:
  //   _max_loop(k,1,i,  _cost(i-k,j) - p_gap(k),                  BT(DIR_UP,k)   ) <<-- gap top
  //   _max_loop(k,1,j,  _cost(i,j-k) - p_gap(k),                  BT(DIR_LEFT,k) ) <<-- gap left
  //   _max(             _cost(i-1,j-1) + p_cost(_ini(i),_inj(j)), BT(DIR_DIAG,1) ) <<-- pair
}

/*
> module TTCombinators where
> import Array

Lexical parsers
----------------
> type Subword  = (Int,Int) -- equivalent
> type Parser b = Subword -> [b] -- equivalent

> region, uregion :: Parser (Int,Int)
> uregion (i,j) = [(i,j)| i <= j]
> region (i,j)  = [(i,j)| i < j]

> xbase', ybase' :: Array Int Char -> Parser Char
> xbase' x (i,j)   = [x!j| i+1 == j]
> ybase' y (i,j)   = [y!j| i+1 == j]

> empty' :: Int -> Int -> Parser ()
> empty' m n (i,j)   = [()| i == m && j == n]

Parser combinators
-------------------
> infix 5 ...
> infixr 6 |||
> infixl 7 +~, -~, ~+, ~-
> infix 8 <<<

> (q ||| r) (i,j) = q (i,j) ++ r (i,j)

> (f <<< q) (i,j) = [f s | s <- q (i,j)] -- unchanged ^^
> (f ><< q) (i,j) = [f | s <- q (i,j)] -- map without parameter ^^^

> (q +~ r) m (i,j) = [s t | k <- [i..m], s <- q (i,k), t <- r (k,j)] -- new operator
> (q ~+ r) n (i,j) = [s t | k <- [j..n], s <- q (i,k), t <- r (j,k)] -- new operator

> (q -~ r) m (i,j) = [s t | i < m, s <- q (i,i+1), t <- r (i+1,j)] -- new operator
> (q ~- r) n (i,j) = [s t | j < n, s <- q (i,j+1), t <- r (j,j+1)] -- new operator

-- missing general case where we want to iterate over 2 indices

> (q ... h) (i,j) = h (q (i,j))

> axiom q  = q (0,0)

Tabulation
-----------
> table      :: Int -> Int -> Parser b -> Parser b
> table m n q = (!) $ array ((0,0),(m,n))
>                     [((i,j),q (i,j)) | i<- [0..m], j<- [0..n]]

Create array from List
-----------------------
> mk :: [a] -> Array Int a
> mk xs = array (1,n) (zip [1..n] xs) where n = length xs

Bind input
-----------
> bindParserCombinators inpX inpY = (x, y, xbase, ybase, empty, (+~~), (~~+), (-~~), (~~-), tabulated) where
>   x         = mk inpX
>   y         = mk inpY
>   (_,m)     = bounds x
>   (_,n)     = bounds y
>   xbase     = xbase' x
>   ybase     = ybase' y
>   empty     = empty' m n
>   infixl 7 +~~, -~~, ~~+, ~~-
>   (+~~) q r = (q +~ r) m
>   (~~+) q r = (q ~+ r) n
>   (-~~) q r = (q -~ r) m
>   (~~-) q r = (q ~- r) n
>   tabulated = table m n

> bindSpezialCombinators x y = ((++~), (~++)) where
>   (++~) q r (i,j) = [s t | k <- [i+1..m], s <- q (i,k), t <- r (k,j)]
>   (~++) q r (i,j) = [s t | k <- [j+1..n], s <- q (i,k), t <- r (j,k)]
>   (_,m)           = bounds x
>   (_,n)           = bounds y

--------------------------------------------------------------------------------
> module NeedlemanWunsch where

The signature:
> data Alignment = Nil                    |
>                  D  Subword Alignment   |
>                  I  Alignment Subword   |
>                  R  Char Alignment Char
>                                            deriving (Eq, Show)

Algebra type:
> type NW_Algebra alph1 alph2 answer = (
>   answer,                             -- nil
>   alph2 -> answer -> answer,          -- d
>   answer -> alph2 -> answer,          -- i
>   alph1 -> answer -> alph1 -> answer, -- r
>   [answer] -> [answer]                -- h
>   )

Affine gap score algebra:
> affine :: a -> a-> NW_Algebra Char Subword Int
> affine _ _ = (nil, d, i, r, h) where
>  nil         = 0
>  d (i,j) s   = s + open + extend * (j-i)
>  i   s (i,j) = s + open + extend * (j-i)
>  r a s b     = s + w a b
>  h []        = []
>  h l         = [maximum l]
>
>  -- simple definitions for open, extend and w:
>  open   = (-15)
>  extend = (-1)
>  w a b  = if a==b then 4 else -3

The yield grammar:
> nw_alignments alg inpX inpY = axiom alignment where
>   (nil, d, i, r, h)    = alg x y
>
>   alignment  = tabulated (
>                 nil ><< empty                           |||
>                 d   <<< region ++~ alignment            |||
>                 i   <<<            alignment ~++ region |||
>                 r   <<< xbase  -~~ alignment ~~- ybase  ... h)

Bind input:
>   infixl 7 +~~, -~~, ~~+, ~~-
>   (x, y, xbase, ybase, empty, (+~~), (~~+), (-~~), (~~-), tabulated)
>     = bindParserCombinators inpX inpY

>   infixl 7 ++~,  ~++
>   ((++~), (~++)) = bindSpezialCombinators x y
*/
