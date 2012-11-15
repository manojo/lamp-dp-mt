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

  private val open = -2
  private val extend = -1
  def gap(size:Int) = open + (size-1) * extend
  def pair(a:Char,b:Char) = if (a==b) 1 else 0
}

object SWatApp extends App with LexicalParsers with SWatAlgebra {
  println("UNIMPLEMENTED")

/*
  Ideas:
  - define parsers on a single track
  - define a combinator that takes two single track parser and compute it into a 2-track parser
  - rework needed functions

  def pair
  def gap_left
  deg gap_top

C implementation:
#define p_kernel \
  _max_loop(k,1,i,  _cost(i-k,j) - p_gap(k),                  BT(DIR_UP,k)   ) \ <<- gap top
  _max_loop(k,1,j,  _cost(i,j-k) - p_gap(k),                  BT(DIR_LEFT,k) ) \ <<- gap left
  _max(             _cost(i-1,j-1) + p_cost(_ini(i),_inj(j)), BT(DIR_DIAG,1) ) <<-- pair

XXX: also implement general case where we search both directions / in limited range

*/
}

/*
> module TTCombinators where
> import Array

Lexical parsers
----------------
> type Subword  = (Int,Int)
> type Parser b = Subword -> [b]

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
