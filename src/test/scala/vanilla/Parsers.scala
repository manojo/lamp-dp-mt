package vanilla

trait Parsers{

  abstract class Parser[+T] extends ((Int, Int) => List[T]){inner =>

    def filter (p: (Int, Int) => Boolean) = FilterParser(this, p)

    def ^^[X>:T, U](f: X => U) = this.map(f)
    private def map[X>:T, U](f: X => U) = MapParser(this, f)

    def |[X>:T](that: => Parser[X]) = or(that)
    private def or[X>:T](that: => Parser[X]) = OrParser(inner, () => that)

    def aggregate[X>:T, U](h: List[X] => List[U]) = AggregateParser(inner, h)

    // Concatenate combinator.
    // Parses a concatenation of string left~right with length(left) in [lL,lU]
    // and length(right) in [rL,rU], lU,rU=0 means unbounded (infinity).
    private def concat[U](lL:Int, lU:Int, rL:Int, rU:Int)(that: => Parser[U]) =
      ConcatParser(inner, lL,lU,rL,rU, ()=>that)

    def ~~~ [U](that: => Parser[U]) = concat(0,0,0,0)(that)
    def ~~+ [U](that: => Parser[U]) = concat(0,0,1,0)(that)
    def +~~ [U](that: => Parser[U]) = concat(1,0,0,0)(that)
    def +~+ [U](that: => Parser[U]) = concat(1,0,1,0)(that)

    def *~~ [U](lMin:Int, rRange:Pair[Int,Int], that: => Parser[U]) = concat(lMin,0,rRange._1,rRange._2)(that)
    def ~~* [U](lRange:Pair[Int,Int], rMin:Int, that: => Parser[U]) = concat(lRange._1,lRange._2,rMin,0)(that)
    def *~* [U](lMin:Int, rMin:Int, that: => Parser[U]) = concat(lMin,0,rMin,0)(that)

    def ~~ [U:Manifest](lRange:Pair[Int,Int], rRange:Pair[Int,Int], that: => Parser[U]) = concat(lRange._1,lRange._2,rRange._1,rRange._2)(that)

    def -~~ [U:Manifest](that: => Parser[U]) = concat(1,1,0,0)(that)
    def ~~- [U:Manifest](that: => Parser[U]) = concat(0,0,1,1)(that)
  }

   //tabulation for Char parsers
   // Memoization through tabulation
  import scala.collection.mutable.HashSet

  val productions = new HashSet[String]
  def tabulate[T](inner: Parser[T],
    name:String, mat: Array[Array[List[T]]]
   ) = TabulatedParser(inner, name, mat)

   /*** case classes for matching on Parsers */

  case class FilterParser[+T](inner: Parser[T], p: (Int, Int) => Boolean) extends Parser[T]{
    def apply(i: Int, j: Int) = if(p(i,j)) inner(i,j) else List()
  }

  case class MapParser[+S<:T, T, +U](inner: Parser[S], f: T => U) extends Parser[U]{
    def apply(i: Int, j: Int) = inner(i,j) map f
  }

  case class OrParser[+S<:T, +T](inner: Parser[T], that: () => Parser[S]) extends Parser[T]{
    def apply(i: Int, j: Int) = inner(i,j) ++ that()(i,j)
  }

  case class AggregateParser[+S<:T, T, +U](inner: Parser[S], h: List[T] => List[U]) extends Parser[U]{
    def apply(i: Int, j: Int) = h(inner(i,j))
  }

  case class ConcatParser[X<:(T,U), +T, +U](inner: Parser[T], lL:Int, lU:Int, rL:Int, rU:Int, that: () => Parser[U]) extends Parser[X]{
    def apply(i: Int, j: Int) = if(i<j){
      val min_k = if (rU==0) i+lL else Math.max(i+lL,j-rU)
      val max_k = if (lU==0) j-rL else Math.min(j-rL,i+lU)
      (for(
        k <- (min_k until max_k+1).toList;
        x <- inner(i,k);
        y <- that()(k,j)
      ) yield((x,y))).asInstanceOf[List[X]]
    } else List()
  }

  /*
   * an extractor for MParser
   */
   object MParser{
    def unapply[X<:(T,U),T,U,V](c: ConcatParser[X,T,U]/*, f: (T,U)=>V*/): Option[ConcatParser[X,T,U]] =
      Some(c)
    //def unapply[X<:(T,U), +T, +U, +V](c: ConcatParser[X,T,U], f: (T,U) => V) : Option[( ConcatParser[X,T,U], (T,U) => V)] =
    //  Some((c,f))
   }

  case class TabulatedParser[T](inner: Parser[T], name: String,
    mat: Array[Array[List[T]]]) extends Parser[T]{
      def apply(i: Int, j: Int) =
        if(i <= j){
          if(!(productions contains(name)) || mat(i)(j).isEmpty){
            productions += name
            mat(i)(j) = inner(i,j)
            productions -= name
            val a = mat(i)
            a(j)
          } else {
            val tmp = mat(i)
            tmp(j)
          }
        } else List()
  }


  /*************** simple parsers below *****************/

/*   def el(in: Input) = new Parser[Alphabet] {
    def apply(i: Rep[Int], j : Rep[Int]) =
      if(i+1==j) List(in(i)) else Nil
  }

  def eli(in: Input) = new Parser[Int] {
    def apply(i: Rep[Int], j : Rep[Int]) =
      if(i+1==j) List(i) else Nil
  }
*/

//bottomup parsing
/*def bottomUp(in: Input, p : Parser[List[Char]], costMatrix: Rep[Array[Array[List[List[Char]]]]]) = {
  //initialising the cost matrix
  (0 until in.length + 1).foreach{i =>
    (0 until in.length + 1).foreach{j =>
      val a = costMatrix(i)
      a(j) = List()
    }
  }

  (0 until in.length + 1).foreach{j =>
    (0 until j+1).foreach{i =>
      //TODO: extend range ops for descending ranges
      val a = costMatrix(j-i)
      a(j) = p(j-i,j)
    }
  }
}*/

/**
 * transform and optimize some trees y'all\
 * TabulatedParser(inner: Parser[T], name: String, mat: Rep[Array[Array[List[T]]]])
 * ConcatParser(inner: Parser[T], lL:Rep[Int], lU:Rep[Int], rL:Rep[Int], rU:Rep[Int], that: () => Parser[U])
 * AggregateParser(inner: Parser[S], h: Rep[List[T]] => Rep[List[U]])
 * OrParser(inner: Parser[T], that: () => Parser[S])
 * MapParser(inner: Parser[S], f: Rep[T] => Rep[U])
 * FilterParser(inner: Parser[T], p: (Rep[Int], Rep[Int]) => Rep[Boolean])
 */

 def transform[T](p: Parser[T]): Parser[T] = p match{
    case TabulatedParser(inner, n, m : Array[Array[List[T]]]) =>
      TabulatedParser(transform(inner), n, m)
//    case MParser(c:ConcatParser[a,b,c]) => p

    case MapParser(ConcatParser(inner,lL,lU,rL,rU,that), f:(Any => T) @unchecked) =>
      println("Map parser match")
      new Parser[T]{
        def apply(i: Int, j: Int) = if(i<j){
          val min_k = if (rU==0) i+lL else Math.max(i+lL,j-rU)
          val max_k = if (lU==0) j-rL else Math.min(j-rL,i+lU)
          val temp = (for(
            k <- (min_k until max_k+1).toList;
            x <- inner(i,k);
            y <- that()(k,j)
          ) yield((x,y)))
          println(temp)
          println(temp.map(f))
          temp.map(f)
        } else List()
      }
    case OrParser(p,q) =>
      println("Or parser match")
      OrParser(transform(p), () => transform(q()))
    case AggregateParser(p,h:(List[T] => List[T]) @unchecked) =>
      println("Aggregate parser match")
      AggregateParser(transform(p),h)
    case FilterParser(p,f) => FilterParser(transform(p), f)
    case _ => p

 }

}

object MatMult extends Parsers{
  type Alphabet = (Int,Int)
  type Answer = (Int, Int, Int)
  type Input = Array[Alphabet]

  def single(i: (Int,Int)) = (i._1, 0, i._2)
  def mult(x: (Answer,Answer)) = x match {
    case (l,r) => (l._1, l._2 + r._2 + l._1 * l._3 * r._3 ,r._3)
  }

  def el(in: Input) = new Parser[Alphabet] {
    def apply(i: Int, j : Int) =
      if(i+1==j) List(in(i)) else List()
  }

  def myParser(in:Input) : Parser[Answer] = {
    val a : Array[Array[List[Answer]]] =
      Array.tabulate(in.length+1,in.length+1)((_,_) => Nil)

    lazy val p : Parser[Answer] = tabulate(
      (el(in) ^^ single
       | (p +~+ p) ^^ {(x: (Answer,Answer)) => mult(x)}
      ).aggregate{x : List[Answer]=> List(x.min)},
      "mat",
      a
    )
    p
  }

  def opti(in:Input) : Parser[Answer] = {
    val a : Array[Array[List[Answer]]] =
      Array.tabulate(in.length+1,in.length+1)((_,_) => Nil)

    lazy val p : Parser[Answer] = tabulate(
      (el(in) ^^ single
       | (p +~+ p) ^^ {(x: (Answer,Answer)) => mult(x)}
      ).aggregate{x : List[Answer]=> List(x.min)},
      "mat",
      a
    )
    transform(p).asInstanceOf[Parser[Answer]]
  }

  def main(args:Array[String]){
    val input = List((10,100),(100,5),(5,50)).toArray
    println(myParser(input)(0,input.length))
    val improved = opti(input)
    println(improved(0,input.length))
  }

}