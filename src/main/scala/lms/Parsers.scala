package lms

import scala.virtualization.lms.common._

trait Sig{
  type Alphabet
  type Answer

  val mAlph: Manifest[Alphabet]
  val mAns : Manifest[Answer]

  //  def h(l: List[Answer]) : List[Answer]
  //  val cyclic = false // cyclic problem
  //  val window = 0     // windowing size, 0=disabled
}

trait Parsers extends ArrayOps with MyListOps with NumericOps with IfThenElse
                 with LiftNumeric with Equal with BooleanOps with OrderingOps
                 with MathOps with HackyRangeOps with TupleOps with MiscOps{this: Sig =>

  //DSL related type aliases and info
  type Input = Rep[Array[Alphabet]]

  abstract class Parser[T:Manifest] extends ((Rep[Int], Rep[Int]) => Rep[List[T]]){inner =>

    def filter(p: Rep[T] => Rep[Boolean]) = parser_filter(this, p)

    def ^^[U:Manifest](f: Rep[T] => Rep[U]) = this.map(f)
    private def map[U:Manifest](f: Rep[T] => Rep[U]) = parser_map(this, f)

    def |(that: => Parser[T]) = or(that)
    private def or(that: => Parser[T]) = parser_or(inner, that)

    def aggregate[U:Manifest](h: Rep[List[T]] => Rep[List[U]]) = parser_aggregate(inner, h)
    def aggfold(z: Rep[T], f: (Rep[T], Rep[T]) => Rep[T]) = parser_aggfold(inner, z, f)

    // Concatenate combinator.
    // Parses a concatenation of string left~right with length(left) in [lL,lU]
    // and length(right) in [rL,rU], lU,rU=0 means unbounded (infinity).
    private def concat[U:Manifest](lL:Rep[Int], lU:Rep[Int], rL:Rep[Int], rU:Rep[Int])(that: => Parser[U]) =
      parser_concat(inner, lL,lU,rL,rU, that)

    def ~~~ [U:Manifest](that: => Parser[U]) = concat(0,0,0,0)(that)
    def ~~+ [U:Manifest](that: => Parser[U]) = concat(0,0,1,0)(that)
    def +~~ [U:Manifest](that: => Parser[U]) = concat(1,0,0,0)(that)
    def +~+ [U:Manifest](that: => Parser[U]) = concat(1,0,1,0)(that)

    def *~~ [U:Manifest](lMin:Rep[Int], rRange:Pair[Int,Int], that: => Parser[U]) = concat(lMin,0,rRange._1,rRange._2)(that)
    def ~~* [U:Manifest](lRange:Pair[Rep[Int],Rep[Int]], rMin:Rep[Int], that: => Parser[U]) = concat(lRange._1,lRange._2,rMin,0)(that)
    def *~* [U:Manifest](lMin:Rep[Int], rMin:Rep[Int], that: => Parser[U]) = concat(lMin,0,rMin,0)(that)

    def ~~ [U:Manifest](lRange:Pair[Rep[Int],Rep[Int]], rRange:Pair[Rep[Int],Rep[Int]], that: => Parser[U]) = concat(lRange._1,lRange._2,rRange._1,rRange._2)(that)

    def -~~ [U:Manifest](that: => Parser[U]) = concat(1,1,0,0)(that)
    def ~~- [U:Manifest](that: => Parser[U]) = concat(0,0,1,1)(that)
  }


  def parser_filter[T:Manifest](inner: Parser[T], p: Rep[T] => Rep[Boolean]) :  Parser[T]
  def parser_map[T:Manifest, U:Manifest](inner: Parser[T], f: Rep[T] => Rep[U]) : Parser[U]
  def parser_or[T:Manifest](inner: Parser[T], that: => Parser[T]): Parser[T]
  def parser_aggregate[T:Manifest,U:Manifest](inner: Parser[T], h: Rep[List[T]] => Rep[List[U]]) : Parser[U]
  def parser_aggfold[T:Manifest](inner: Parser[T], z: Rep[T], f: (Rep[T],Rep[T]) => Rep[T]) : Parser[T]
  def parser_concat[T:Manifest, U:Manifest](inner: Parser[T], lL:Rep[Int], lU:Rep[Int], rL:Rep[Int], rU:Rep[Int], that: => Parser[U]): Parser[(T,U)]
  def tabulate(inner: Parser[Answer], name:String, mat: Rep[Array[Array[Answer]]]) : Parser[Answer]
  def tabulate2(inner: Parser[Answer], name:String, mat: Rep[Array[Array[Answer]]],
    z: Rep[Answer], f:(Rep[Answer], Rep[Answer]) => Rep[Answer]) : Parser[Answer]



  /*************** simple parsers below *****************/

   def el(in: Input)(implicit mAlph: Manifest[Alphabet]) = new Parser[Alphabet] {
    def apply(i: Rep[Int], j : Rep[Int]) = {
      if(i+1==j) List(in(i)) else List()
    }
  }

  def eli(in: Input) = new Parser[Int] {
    def apply(i: Rep[Int], j : Rep[Int]) =
      if(i+1==j) List(i) else List()
  }
}

trait LexicalParsers extends Parsers {this: Sig =>

  type Alphabet = Char
  val mAlph = manifest[Char]

  def char(in: Input) = new Parser[Char] {
    def apply(i: Rep[Int], j : Rep[Int]) =
      if(i+1==j) List(in(i)) else List()
  }

  def charf(in: Input, f: Rep[Char] => Rep[Boolean]): Parser[Char] =
    char(in).filter(f)
}

trait ParsersExp extends Parsers with ArrayOpsExp with MyListOpsExp with LiftNumeric
    with NumericOpsExp with IfThenElseExp with EqualExp with BooleanOpsExp
    with OrderingOpsExp with MathOpsExp with HackyRangeOpsExp
    with TupleOpsExp with ListToGenTransform{this: Sig =>


  def parser_filter[T:Manifest](inner: Parser[T], p: Rep[T] => Rep[Boolean]) :  Parser[T] =
    FilterParser(inner,p)
  def parser_map[T:Manifest, U:Manifest](inner: Parser[T], f: Rep[T] => Rep[U]) : Parser[U] =
    MapParser(inner,f)
  def parser_or[T:Manifest](inner: Parser[T], that: => Parser[T]): Parser[T] =
    OrParser(inner, () => that)
  def parser_aggregate[T:Manifest,U:Manifest](inner: Parser[T], h: Rep[List[T]] => Rep[List[U]]) : Parser[U] =
    AggregateParser(inner,h)
  def parser_aggfold[T:Manifest](inner: Parser[T], z: Rep[T], f: (Rep[T],Rep[T]) => Rep[T]) : Parser[T] =
    AggregateFold(inner, z, f)
  def parser_concat[T:Manifest, U:Manifest](inner: Parser[T], lL:Rep[Int], lU:Rep[Int], rL:Rep[Int], rU:Rep[Int], that: => Parser[U]): Parser[(T,U)] =
    ConcatParser(inner, lL, lU, rL, rU, () => that)
  def tabulate(inner: Parser[Answer],name:String, mat: Rep[Array[Array[Answer]]]) =
    TabulatedParser(inner, name, mat)(mAns)
  def tabulate2(inner: Parser[Answer], name:String, mat: Rep[Array[Array[Answer]]],
    z: Rep[Answer], f:(Rep[Answer], Rep[Answer]) => Rep[Answer]) =
    TabulatedParser2(inner, name, mat, z, f)(mAns)

  // Memoization through tabulation
  import scala.collection.mutable.HashSet

  val productions = new HashSet[String]


  /*** case classes for matching on Parsers */

  case class FilterParser[T:Manifest](inner: Parser[T], p: Rep[T] => Rep[Boolean]) extends Parser[T]{
    def apply(i: Rep[Int], j: Rep[Int]) = inner(i,j) filter p
  }

  case class MapParser[T:Manifest, U:Manifest](inner: Parser[T], f: Rep[T] => Rep[U]) extends Parser[U]{
    def apply(i: Rep[Int], j: Rep[Int]) = inner(i,j) map f
  }

  case class OrParser[T:Manifest](inner: Parser[T], that: () => Parser[T]) extends Parser[T]{
    def apply(i: Rep[Int], j: Rep[Int]) = inner(i,j) ++ that()(i,j)
  }

  case class AggregateParser[T:Manifest, U:Manifest](inner: Parser[T], h: Rep[List[T]] => Rep[List[U]]) extends Parser[U]{
    def apply(i: Rep[Int], j: Rep[Int]) = h(inner(i,j))
  }

  case class AggregateFold[T:Manifest](inner: Parser[T], z: Rep[T], f: (Rep[T],Rep[T]) => Rep[T]) extends Parser[T]{
    def apply(i: Rep[Int], j: Rep[Int]) = {
      val tmp = inner(i,j)
      List(list_fold(tmp,z,f))
    }
  }

  case class ConcatParser[T:Manifest, U:Manifest](inner: Parser[T], lL:Rep[Int], lU:Rep[Int], rL:Rep[Int], rU:Rep[Int], that: () => Parser[U]) extends Parser[(T,U)]{
    def apply(i: Rep[Int], j: Rep[Int]) = if(i<j){
      val min_k = if (rU==0) i+lL else Math.max(i+lL,j-rU)
      val max_k = if (lU==0) j-rL else Math.min(j-rL,i+lU)
      (for(
        k <- (min_k until max_k+1).toList;
        x <- inner(i,k);
        y <- that()(k,j)
      ) yield((x,y)))

    } else List()
  }

  /**
   * an opti-concat parser is a better concat
   */
   case class OptiConcatParser[T:Manifest, U:Manifest](inner: Parser[T], lL:Rep[Int], lU:Rep[Int], rL:Rep[Int], rU:Rep[Int], that: () => Parser[U])
     extends Parser[(T,U)]{
     def apply(i: Rep[Int], j: Rep[Int]) = if(i<j){
       val min_k = if (rU==0) i+lL else Math.max(i+lL,j-rU)
       val max_k = if (lU==0) j-rL else Math.min(j-rL,i+lU)
       for(k <- (min_k until max_k+1).toList)
         yield((inner(i,k).head,that()(k,j).head))
     } else List()
    }


    /*
     * tabulation parser
     */
   case class TabulatedParser(inner: Parser[Answer], name: String,
     mat: Rep[Array[Array[Answer]]])(implicit val mAns: Manifest[Answer]) extends Parser[Answer]{
     def apply(i: Rep[Int], j: Rep[Int]) = {
       //if(i <= j){
         if(!(productions contains(name)) /*|| mat(i)(j) == null*/){
           productions += name
           mat(i)(j) = inner(i,j).head //we expect one element
           productions -= name
           //val a = mat(i)
           //List(a(j))
         }
         // else {
           val tmp = mat(i)
           List(tmp(j))
         //}
       //} else List()
     }
   }

    /*
     * tabulation parser2
     */
   case class TabulatedParser2(inner: Parser[Answer], name: String,
     mat: Rep[Array[Array[Answer]]], z: Rep[Answer],
     f: (Rep[Answer], Rep[Answer]) => Rep[Answer])(implicit val mAns: Manifest[Answer]) extends Parser[Answer]{
     def apply(i: Rep[Int], j: Rep[Int]) = {
       if(!(productions contains(name)) /*|| mat(i)(j) == null*/){
         productions += name

         val tmp = inner(i,j)
         var s = z
         transform(tmp).apply{
          x : Rep[Answer] => s = f(s,x)
         }
         mat(i)(j) = s //we expect one element
         productions -= name
       }
       List(mat(i).apply(j))
     }
   }

  /*
   * an extractor for MParser: to force the match of a MapParser(ConcatParser)
   */
   object MParser{
    def unapply[T:Manifest,U:Manifest,V:Manifest](mp: MapParser[(U,V),T]) : Option[(ConcatParser[U,V], (Rep[(U,V)] => Rep[T]))] = mp.inner match {
      case c: ConcatParser[U,V] =>
        Some((c, mp.f))
      case _ => None
    }
   }

   //bottomup parsing
   def bottomUp(in: Input, p :  => Parser[Answer], costMatrix: Rep[Array[Array[Answer]]])(implicit mAlph: Manifest[Alphabet], mA: Manifest[Answer]) : Rep[Answer] = {
     /*(0 until in.length + 1).foreach{j =>
       (0 until j+1).foreach{i =>
         //println((j-i,j))
         val a = costMatrix(j-i)
         a(j) = p(j-i,j).head
       }
     }*/
     (1 until in.length + 1).foreach{l =>
       (0 until in.length + 1 -l).foreach{i =>
         val j = i+l
         val tempres = p(i,j).head
         val a = costMatrix(i);a(j) = tempres
       }
     }
     val temp = costMatrix(0);temp(in.length)
   }

  //bottomup parsing with ListToGen transform
/*  def bottomUp2(in: Input, p :  => TabulatedParser,
    costMatrix: Rep[Array[Array[Answer]]], z: Rep[Answer])(implicit mAlph: Manifest[Alphabet], mA: Manifest[Answer]) : Rep[Answer] = {
    (1 until in.length + 1).foreach{l =>
      (0 until in.length + 1 -l).foreach{i =>
        val j = i+l

        var s = z
        val genned = transform(p(i,j))
        genned{x : Rep[Answer] => s = x}

        val a = costMatrix(i);a(j) = s
      }
    }
    val temp = costMatrix(0);temp(in.length)
  }
*/

  /**
   * transform and optimize some trees y'all\
   * TabulatedParser(inner: Parser[T], name: String, mat: Rep[Array[Array[List[T]]]])
   * ConcatParser(inner: Parser[T], lL:Rep[Int], lU:Rep[Int], rL:Rep[Int], rU:Rep[Int], that: () => Parser[U])
   * AggregateParser(inner: Parser[S], h: Rep[List[T]] => Rep[List[U]])
   * OrParser(inner: Parser[T], that: () => Parser[S])
   * MapParser(inner: Parser[S], f: Rep[T] => Rep[U])
   * FilterParser(inner: Parser[T], p: (Rep[Int], Rep[Int]) => Rep[Boolean])
   */

  def transform(p: TabulatedParser): TabulatedParser = p match {
    case t@TabulatedParser(inner, n, m: Rep[Array[Array[Answer]]] @unchecked) =>
     TabulatedParser(transform(inner)(t.mAns), n, m)(t.mAns)
    case _ => p
  }

  def transform[T:Manifest](p: Parser[T]): Parser[T] = {
   p match{
     case MParser((ConcatParser(inner,lL,lU,rL,rU,that), f)) =>
       //scala.Console.println("Map Concat parser match")
       new Parser[T]{
         def apply(i: Rep[Int], j: Rep[Int]) = if(i<j){
           val min_k = if (rU==0) i+lL else Math.max(i+lL,j-rU)
           val max_k = if (lU==0) j-rL else Math.min(j-rL,i+lU)
           for(
             k <- ((min_k until max_k+1).toList)
           ) yield(f(inner(i,k).head,that()(k,j).head))
         } else List()
       }
     case ConcatParser(inner,lL,lU,rL,rU,that) =>
       val transformed = transform(that())
       OptiConcatParser(transform(inner),lL,lU,rL,rU,() => transformed)
     case OrParser(p,q) =>
       //scala.Console.println("Or Parser match")
       OrParser(transform(p), () => transform(q()))
     case AggregateParser(p,h: (Rep[List[T]] => Rep[List[T]]) @unchecked) =>
       //scala.Console.println("Aggregate Parser match")
       AggregateParser(transform(p),h)
     case AggregateFold(p,z,f @unchecked) =>
       //scala.Console.println("Aggregate Parser match")
       AggregateFold(transform(p),z,f)
     case FilterParser(p,f) =>
       //scala.Console.println("FilterParser match")
       FilterParser(transform(p), f)
     case _ => p
   }
  }

}