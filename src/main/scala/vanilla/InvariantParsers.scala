package vanilla

trait InvariantParsers{

  abstract class Parser[T] extends ((Int, Int) => List[T]){inner =>

    def filter (p: (Int, Int) => Boolean) = FilterParser(this, p)

    def ^^[U](f: T => U) = this.map(f)
    private def map[U](f: T => U) = MapParser(this, f)

    def |(that: Parser[T]) = or(that)
    private def or(that: Parser[T]) = OrParser(inner, that)

    def aggregate[U](h: List[T] => List[U]) = AggregateParser(inner, h)

    // Concatenate combinator.
    // Parses a concatenation of string left~right with length(left) in [lL,lU]
    // and length(right) in [rL,rU], lU,rU=0 means unbounded (infinity).
    private def concat[U](lL:Int, lU:Int, rL:Int, rU:Int)(that: => Parser[U]) =
      ConcatParser(inner, lL,lU,rL,rU, that)

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

    override def toString = "Unknown"
  }

   //tabulation for Char parsers
   // Memoization through tabulation
  import scala.collection.mutable.HashSet

  val productions = new HashSet[String]
  def tabulate[T](inner: => Parser[T],
    name:String, mat: Array[Array[T]]
   ) = TabulatedParser(() => inner, name, mat)

   /*** case classes for matching on Parsers */

  case class FilterParser[T](inner: Parser[T], p: (Int, Int) => Boolean) extends Parser[T]{
    def apply(i: Int, j: Int) = if(p(i,j)) inner(i,j) else List()
    override def toString = "Filter("+inner+")"
  }

  case class MapParser[T, U](inner: Parser[T], f: T => U) extends Parser[U]{
    def apply(i: Int, j: Int) = inner(i,j) map f
    override def toString = "Map("+inner+")"
  }

  case class OrParser[T](inner: Parser[T], that: Parser[T]) extends Parser[T]{
    def apply(i: Int, j: Int) = inner(i,j) ++ that(i,j)
    override def toString = "Or("+inner+","+that+")"
  }

  case class AggregateParser[T, U](inner: Parser[T], h: List[T] => List[U]) extends Parser[U]{
    def apply(i: Int, j: Int) = h(inner(i,j))
    override def toString = "Aggregate("+inner+")"
  }

  case class ConcatParser[T, U](inner: Parser[T], lL:Int, lU:Int, rL:Int, rU:Int, that: Parser[U]) extends Parser[(T,U)]{
    def apply(i: Int, j: Int) = if(i<j){
      val min_k = if (rU==0) i+lL else Math.max(i+lL,j-rU)
      val max_k = if (lU==0) j-rL else Math.min(j-rL,i+lU)
      (for(
        k <- (min_k until max_k+1).toList;
        x <- inner(i,k);
        y <- that(k,j)
      ) yield((x,y)))
    } else List()
    override def toString = "Concat("+inner+","+that+")"
  }

  /**
   * an opti-concat parser is a better concat
   */
  case class OptiConcatParser[T, U](inner: Parser[T], lL:Int, lU:Int, rL:Int, rU:Int, that: Parser[U])
    extends Parser[(T,U)]{
      def apply(i: Int, j: Int) = if(i<j){
        val min_k = if (rU==0) i+lL else Math.max(i+lL,j-rU)
        val max_k = if (lU==0) j-rL else Math.min(j-rL,i+lU)
        for(k <- (min_k until max_k+1).toList)
          yield((inner(i,k).head,that(k,j).head))
      } else List()
      override def toString = "OptiConcat("+inner+","+that+")"
    }

  /*
   * an extractor for MParser: to force the match of a MapParser(ConcatParser)
   */
   object MParser{
    def unapply[T,U,V](mp: MapParser[(U,V),T]) : Option[(ConcatParser[U,V], (U,V)=>T)] = mp.inner match {
      case c: ConcatParser[U,V] => Some((c, {(x,y) => mp.f((x,y))}))
      case _ => None
    }
   }

   /*
    * an extractor for OptiConcatParser: to force the match of a MapParser(ConcatParser)
    */
/*   object OCParser{
    def unapply[T,U](cp: OptiConcatParser[T,U]) : Option[OptiConcatParser[U,V]] = cp match {
      case c: OptiConcatParser[T,U] => Some(c)
      case _ => None
    }
   }
*/
  case class TabulatedParser[T](inner: () => Parser[T], name: String,
    mat: Array[Array[T]]) extends Parser[T]{
      def apply(i: Int, j: Int) =
        if(i <= j){
          if(!(productions contains(name)) || mat(i)(j) == null){
            productions += name
            val temp = inner()(i,j)
            if(!temp.isEmpty){mat(i)(j) = temp.head} //we expect one element in inner(i,j)
            productions -= name
            val a = mat(i)
            List(a(j))
          } else {
            val tmp = mat(i)
            List(tmp(j))
          }
        } else List()

      override def toString = name
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

/**
 * transform and optimize some trees y'all\
 * TabulatedParser(inner: Parser[T], name: String, mat: Rep[Array[Array[List[T]]]])
 * ConcatParser(inner: Parser[T], lL:Rep[Int], lU:Rep[Int], rL:Rep[Int], rU:Rep[Int], that: () => Parser[U])
 * AggregateParser(inner: Parser[S], h: Rep[List[T]] => Rep[List[U]])
 * OrParser(inner: Parser[T], that: () => Parser[S])
 * MapParser(inner: Parser[S], f: Rep[T] => Rep[U])
 * FilterParser(inner: Parser[T], p: (Rep[Int], Rep[Int]) => Rep[Boolean])
 */

 def asString[T](p: TabulatedParser[T]): String = p.name + "("+p.inner()+")"

 def transform[T](p: TabulatedParser[T]): Parser[T] = {
  val transformed = transform(p.inner())
  TabulatedParser(() => transformed, p.name, p.mat)
 }

 def transform[T](p: Parser[T]): Parser[T] = {
  p match{
  //MapParser(ConcatParser is sort of a special case)
  //of parser, so no need to transform it OptiConcatParser
  //FOR NOW
    case MParser((ConcatParser(inner,lL,lU,rL,rU,that), f)) =>
      println("Map Concat Parser match")
      new Parser[T]{
        def apply(i: Int, j: Int) = if(i<j){
          val min_k = if (rU==0) i+lL else Math.max(i+lL,j-rU)
          val max_k = if (lU==0) j-rL else Math.min(j-rL,i+lU)
          for(k <- (min_k until max_k+1).toList)
            yield(f(inner(i,k).head,that(k,j).head))
        } else List()
        override def toString = "Optimized"
      }
    case ConcatParser(inner,lL,lU,rL,rU,that) =>
      println("ConcatParser match")
      OptiConcatParser(transform(inner),lL,lU,rL,rU,transform(that))
    case OrParser(p,q) =>
      println("Or parser match")
      OrParser(transform(p), transform(q))
    case AggregateParser(p,h:(List[T] => List[T])) =>
      println("Aggregate parser match")
      AggregateParser(transform(p),h)
    case FilterParser(p,f) => FilterParser(transform(p), f)
    case _ => p
  }
}

}

object InvariantMatMult extends InvariantParsers{
  type Alphabet = (Int,Int)
  type Answer = (Int, Int, Int)
  type Input = Array[Alphabet]

  //bottomup parsing
  def bottomUp[T](in: Input, p :  => Parser[T], costMatrix: Array[Array[T]]) : T = {
    (0 until in.length + 1).foreach{j =>
      (0 until j+1).foreach{i =>
        println((j-i,j))
        val a = costMatrix(j-i)
        a(j) = p(j-i,j).head
      }
    }
    costMatrix(0)(in.length)
  }

  def single(i: (Int,Int)) = (i._1, 0, i._2)
  def mult(x: (Answer,Answer)) = x match {
    case (l,r) => (l._1, l._2 + r._2 + l._1 * l._3 * r._3 ,r._3)
  }

  def el(in: Input) = new Parser[Alphabet] {
    def apply(i: Int, j : Int) =
      if(i+1==j) List(in(i)) else List()
  }

  def myParser(in:Input) : Answer = {
    val a : Array[Array[Answer]] =
      Array.ofDim(in.length+1,in.length+1)

    lazy val p : TabulatedParser[Answer] = tabulate(
      (el(in) ^^ single
       | (p +~+ p) ^^ {(x: (Answer,Answer)) => mult(x)}
      ).aggregate{x : List[Answer]=> if(x.isEmpty) x else List(x.min)},
      "mat",
      a
    )
    p

    println("String rep of parser")
    println(asString(p))

    val res = bottomUp(in, p ,a)
    println("the resulting array is : ")
    for(i <- 0 to in.length){
      for(j <- 0 to in.length){
        if(a(i)(j) == null){
          print("( 0, 0, 0) ")
        }else{
          print(a(i)(j) + " ")
        }
      }
      println()
    }
    res
  }

  def opti(in:Input) : Answer = {
    val a : Array[Array[Answer]] =
      Array.ofDim(in.length+1,in.length+1)

    lazy val p : TabulatedParser[Answer] = tabulate(
      (el(in) ^^ single
       | (p +~+ p) ^^ {(x: (Answer,Answer)) => mult(x)}
      ).aggregate{x : List[Answer]=> if(x.isEmpty) x else List(x.min)},
      "mat",
      a
    )

    //transform(p)(0, in.length).head
    val transfo = transform(p).asInstanceOf[TabulatedParser[Answer]]
    println("String rep of parser")
    println(asString(transfo))
    val res = bottomUp(in, transfo, a)
    println("the resulting array is : ")
    for(i <- 0 to in.length){
      for(j <- 0 to in.length){
        if(a(i)(j) == null){
          print("( 0, 0, 0) ")
        }else{
          print(a(i)(j) + " ")
        }
      }
      println()
    }
    res
  }

  def main(args:Array[String]){
    val input = List((10,100),(100,5),(5,50)).toArray
    println(myParser(input))//(0,input.length))
    val improved = opti(input)
    println(improved)
  }
}
