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

// User program
object SWatApp extends App {
  // Smith-Waterman parser
  object SWat extends MatchingParsers with SWatAlgebra {
    def addGap(cur:Int, g:(Int,Int)) = Math.max(0, cur - gap(g._2-g._1))
    def prettyGap(sw:Subword,in:Function1[Int,Char]):(String,String) = {
      val g=(sw._1 until sw._2).toList; (g.map{x=>in(x)}.mkString(""),g.map{x=>"-"}.mkString(""))
    }

    def alignment: Parser[Answer] = tabulate("M",(
      empty                         ^^ { _ => (0,".",".") } // zero
    | gap1  ++~ alignment           ^^ { case (g,(score,s1,s2)) => val (g1,g2)=prettyGap(g,in1); (addGap(score,g),s1+g1,s2+g2) }
    |           alignment ~++ gap2  ^^ { case ((score,s1,s2),g) => val (g1,g2)=prettyGap(g,in2); (addGap(score,g),s1+g2,s2+g1) }
    | char1 -~~ alignment ~~- char2 ^^ { case (c1,((score,s1,s2),c2)) => (score+pair(c1,c2),s1+c1, s2+c2) }
    ) aggregate h)

    def align(s1:String,s2:String) = parse(alignment)(s1.toArray,s2.toArray)
  }
  // XXX: implement Needleman-Wunsch parser

  // Usage

  val (score,seq1,seq2) = SWat.align("GATTACA","CCCATTAGAG").head
  println("\nSmith-Waterman alignment\n------------------------\nScore: "+score+"\nSeq1: "+seq1+"\nSeq2: "+seq2+"\n")

  // C implementation / generated code
  //   _max_loop(k,1,i,  _cost(i-k,j) - p_gap(k),                  BT(DIR_UP,k)   ) <<-- gap top
  //   _max_loop(k,1,j,  _cost(i,j-k) - p_gap(k),                  BT(DIR_LEFT,k) ) <<-- gap left
  //   _max(             _cost(i-1,j-1) + p_cost(_ini(i),_inj(j)), BT(DIR_DIAG,1) ) <<-- pair
}

/*
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
*/
