package lms

import scala.virtualization.lms.common._

trait GeneratorParsers extends ArrayOps with NumericOps with IfThenElse
                 with LiftNumeric with Equal with BooleanOps with OrderingOps
                 with MathOps with HackyRangeOps with TupleOps with MiscOps
                 with GeneratorOps{this: Sig =>

  //DSL related type aliases and info
  type Input = Rep[Array[Alphabet]]

  abstract class Parser[T:Manifest] extends ((Rep[Int], Rep[Int]) => Generator[T]){inner =>

    //def filter (p: (Rep[Int], Rep[Int]) => Rep[Boolean]) = FilterParser(this, p)

    def ^^[U:Manifest](f: Rep[T] => Rep[U]) = this.map(f)
    private def map[U:Manifest](f: Rep[T] => Rep[U]) = MapParser(this, f)

    def |(that: => Parser[T]) = or(that)
    private def or(that: => Parser[T]) = OrParser(inner, () => that)

//    def aggregate[U:Manifest](h: Rep[List[T]] => Rep[List[U]]) = AggregateParser(inner, h)
/*    def aggfold(z: Rep[T], f: (Rep[T], Rep[T]) => Rep[T]) = {
      AggregateFold(inner, z, f)
    }
*/
    // Concatenate combinator.
    // Parses a concatenation of string left~right with length(left) in [lL,lU]
    // and length(right) in [rL,rU], lU,rU=0 means unbounded (infinity).
    private def concat[U:Manifest](lL:Rep[Int], lU:Rep[Int], rL:Rep[Int], rU:Rep[Int])(that: => Parser[U]) =
      ConcatParser(inner, lL,lU,rL,rU, ()=>that)

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

  // Memoization through tabulation
  import scala.collection.mutable.HashSet

  val productions = new HashSet[String]
  def tabulate(inner: Parser[Answer],
    name:String, mat: Rep[Array[Answer]], len: Rep[Int]
   ) = TabulatedParser(inner, name, mat, len)(mAns)

   /*** case classes for matching on Parsers */

  /*case class FilterParser[T:Manifest](inner: Parser[T], p: (Rep[Int], Rep[Int]) => Rep[Boolean]) extends Parser[T]{
    def apply(i: Rep[Int], j: Rep[Int]) = inner(i,j)if(p(i,j)) inner(i,j) else List()
  }*/

  case class MapParser[T:Manifest, U:Manifest](inner: Parser[T], f: Rep[T] => Rep[U]) extends Parser[U]{
    def apply(i: Rep[Int], j: Rep[Int]) = inner(i,j) map f
  }

  case class OrParser[T:Manifest](inner: Parser[T], that: () => Parser[T]) extends Parser[T]{
    def apply(i: Rep[Int], j: Rep[Int]) = inner(i,j) ++ that()(i,j)
  }

/*  case class AggregateParser[T:Manifest, U:Manifest](inner: Parser[T], h: Rep[List[T]] => Rep[List[U]]) extends Parser[U]{
    def apply(i: Rep[Int], j: Rep[Int]) = h(inner(i,j))
  }
*/
/*  case class AggregateFold[T:Manifest](inner: Parser[T], z: Rep[T], f: (Rep[T],Rep[T]) => Rep[T]) extends Parser[T]{
    def apply(i: Rep[Int], j: Rep[Int]) = {
      val tmp = inner(i,j)
      List(list_fold(tmp,z,f))
    }
  }
*/
  case class ConcatParser[T:Manifest, U:Manifest](inner: Parser[T], lL:Rep[Int], lU:Rep[Int], rL:Rep[Int], rU:Rep[Int], that: () => Parser[U]) extends Parser[(T,U)]{
    def apply(i: Rep[Int], j: Rep[Int]) = cond((i < j), {
    //  println(unit("when do we get in"))
    //  println((i,j))
      val min_k = if (rU==0) i+lL else Math.max(i+lL,j-rU)
      val max_k = if (lU==0) j-rL else Math.min(j-rL,i+lU)
    //  println(unit("min and max"))
    //  println((min_k,max_k))
      range(min_k, max_k+1).flatMap{ k=>
        inner(i,k).flatMap{x =>
          that()(k,j).map{y => (x,y)}
        }
      }
    }, emptyGen()
    )
  }

  /**
   * an opti-concat parser is a better concat
   */
/*   case class OptiConcatParser[T:Manifest, U:Manifest](inner: Parser[T], lL:Rep[Int], lU:Rep[Int], rL:Rep[Int], rU:Rep[Int], that: () => Parser[U])
     extends Parser[(T,U)]{
     def apply(i: Rep[Int], j: Rep[Int]) = if(i<j){
       val min_k = if (rU==0) i+lL else Math.max(i+lL,j-rU)
       val max_k = if (lU==0) j-rL else Math.min(j-rL,i+lU)
       for(k <- (min_k until max_k+1).toList)
         yield((inner(i,k).head,that()(k,j).head))
     } else List()
    }
*/

  /*
   * an extractor for MParser: to force the match of a MapParser(ConcatParser)
   */
/*   object MParser{
    def unapply[T:Manifest,U:Manifest,V:Manifest](mp: MapParser[(U,V),T]) : Option[(ConcatParser[U,V], (Rep[(U,V)] => Rep[T]))] = mp.inner match {
      case c: ConcatParser[U,V] =>
        Some((c, mp.f))
      case _ => None
    }
   }
*/

  case class TabulatedParser(inner: Parser[Answer], name: String,
    mat: Rep[Array[Answer]], len: Rep[Int])(implicit val mAns: Manifest[Answer]) extends Parser[Answer]{
    def apply(i: Rep[Int], j: Rep[Int]) = {
      val tmpgen = new Generator[Answer]{
        def apply(f: Rep[Answer] => Rep[Unit]) = {
          if(!(productions contains(name))){
            productions += name
            val gen = inner(i,j).map{x: Rep[Answer] =>
            //  println(unit("storing in a matrix"))
            //  println((i,j))
            //  println(i * (len + 1) + j)
              mat(i * (len + 1) + j) = x
              x
            }
            gen(f)
            productions -= name
            unit(())
          }else{
           // println(unit("it be there already!"))
           // println((i,j))
           // println(i * (len + 1) + j)
            val tmp = elGen(mat(i * (len + 1) + j))
            tmp(f)
          }
        }
      }

      cond(i < j, tmpgen, emptyGen())
    }
  }

  /*************** simple parsers below *****************/

   def el(in: Input)(implicit mAlph: Manifest[Alphabet]) = new Parser[Alphabet] {
    def apply(i: Rep[Int], j : Rep[Int]) = {
      cond((i+1==j), elGen(in(i)) , emptyGen())
    }
  }

  def eli(in: Input) = new Parser[Int] {
    def apply(i: Rep[Int], j : Rep[Int]) =
      cond((i+1==j), elGen(i) , emptyGen())
  }
//bottomup
  // parsing
  def bottomUp(in: Input, p :  => TabulatedParser, costMatrix: Rep[Array[Answer]]
    , z : Rep[Answer], f:(Rep[Answer], Rep[Answer]) => Rep[Answer])(implicit mAlph: Manifest[Alphabet], mA: Manifest[Answer]) : Rep[Answer] = {
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

        var s = z
        p(i,j){x : Rep[Answer] =>
          s = f(x,s)
        }
//        println(unit("storing again!"))
//        println((i,j))
//        println(i * (in.length + 1) + j)
//        println(s)
        costMatrix(i * (in.length + 1) + j) = s
      }
    }
    val temp = costMatrix(0 * (in.length + 1) + in.length)
    temp
  }

/**
 * transform and optimize some trees y'all\
 * TabulatedParser(inner: Parser[T], name: String, mat: Rep[Array[Array[List[T]]]])
 * ConcatParser(inner: Parser[T], lL:Rep[Int], lU:Rep[Int], rL:Rep[Int], rU:Rep[Int], that: () => Parser[U])
 * AggregateParser(inner: Parser[S], h: Rep[List[T]] => Rep[List[U]])
 * OrParser(inner: Parser[T], that: () => Parser[S])
 * MapParser(inner: Parser[S], f: Rep[T] => Rep[U])
 * FilterParser(inner: Parser[T], p: (Rep[Int], Rep[Int]) => Rep[Boolean])
 */

/* def transform(p: TabulatedParser): TabulatedParser = p match {
  case t@TabulatedParser(inner, n, m: Rep[Array[Array[Answer]]] @unchecked) =>
    TabulatedParser(transform(inner)(t.mAns), p.name, p.mat)(t.mAns)
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
*/
}

trait LexicalGenParsers extends GeneratorParsers {this: Sig =>

  type Alphabet = Char
  val mAlph = manifest[Char]

  def char(in: Input) = el(in) /*new Parser[Char] {
    def apply(i: Rep[Int], j : Rep[Int]) =
      if(i+1==j) List(in(i)) else List()
  }*/
}

trait GeneratorParsersExp extends GeneratorParsers with ArrayOpsExp /*with MyListOpsExp*/ with LiftNumeric
    with NumericOpsExp with IfThenElseExp with EqualExp with BooleanOpsExp
    with OrderingOpsExp with MathOpsExp with HackyRangeOpsExp
    with TupleOpsExp with GeneratorOpsExp{this: Sig =>}

