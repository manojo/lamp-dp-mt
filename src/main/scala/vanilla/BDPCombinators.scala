package vanilla

trait BDPParsers { this: Signature =>
  type Subword = (Int, Int)
  type Input = Array[Alphabet]


  /**
   * tree structure which can be used for generating
   * recurrences
   */
  abstract class PTree
  case class Aggregate[T,U](h: List[T] => List[U], p: PTree) extends PTree
  case class Or(l: PTree, r: PTree) extends PTree
  case class Map[T,U](f: T => U, p: PTree) extends PTree

  //type info more to "please" the type system than any deeper meaning
  case class Concat(l: PTree, r: PTree, indices: (Int,Int,Int,Int)) extends PTree
  case class Filter(f: Subword => Boolean, p: PTree) extends PTree
  case class Production(name:String) extends PTree

  abstract class Terminal extends PTree
  case object SingleElem extends Terminal

  /*
   * the input is a "global" value, as in DP we need
   * the it during the whole running time of the algorithm
   */
  def input: Input

  /*
   * a global store which can be used to store parsers that
   * are productions. Used when transforming into a tree
   */
  val productionStore = new scala.collection.mutable.HashSet[Production]
  val prods2Parsers = new scala.collection.mutable.HashMap[Production,Parser[Any]]

  abstract class Parser[T] extends (Subword => List[T]) { inner =>
    def apply(sw: Subword): List[T]
    def makeTree : PTree

    /*
     * Mapper.
     * Equivalent of ADP's <<< operator.
     * To separate left and right hand side of a grammar rule
     */
    def map[U](f: T => U) = new Parser[U]{
      def apply(sw:Subword) = inner(sw) map f
      def makeTree = Map(f,inner.makeTree)
    }

    def ^^[U](f: T => U) = this.map(f)

    /*
     * Or combinator.
     * Equivalent of ADP's ||| operator.
     * In ADP semantics we concatenate the results of the parse
     * of 'this' with the parse of 'that'
     */
    def or (that: => Parser[T]) = new Parser[T]{
      def apply(sw: Subword) = inner(sw)++that(sw)
      def makeTree = Or(inner.makeTree, that.makeTree)
    }

    def |(that: => Parser[T]) = or(that)

    /*
     * Aggregate combinator.
     * Takes a function which modifies the list of a parse. Usually used
     * for max or min functions (but can also be a prettyprint).
     */
    def aggregate [U] (h: List[T] => List[U]) = new Parser[U]{
      def apply(sw: Subword) = h(inner(sw))
      def makeTree = Aggregate(h,inner.makeTree)
    }

    /*
     * Concatenate combinator.
     * Parses a concatenation of string left~right with length(left) in [lL,lU]
     * and length(right) in [rL,rU], lU,rU=0 means unbounded (infinity).
     */
    def concat[U](lL:Int, lU:Int, rL:Int, rU:Int)(that: => Parser[U]) = new Parser[(T,U)] {
      def apply(sw: Subword) = sw match {
        case (i,j) if i<j =>
          val min_k = if (rU==0) i+lL else Math.max(i+lL,j-rU)
          val max_k = if (lU==0) j-rL else Math.min(j-rL,i+lU)
          for(
            k <- (min_k to max_k).toList;
            x <- inner((i,k));
            y <- that((k,j))
          ) yield((x,y))
        case _ => List[(T,U)]()
      }
      def makeTree = Concat(inner.makeTree, that.makeTree, (lL,lU,rL,rU))
    }

    def ~~~ [U](that: => Parser[U]) = concat(0,0,0,0)(that)
    def ~~+ [U](that: => Parser[U]) = concat(0,0,1,0)(that)
    def +~~ [U](that: => Parser[U]) = concat(1,0,0,0)(that)
    def +~+ [U](that: => Parser[U]) = concat(1,0,1,0)(that)

    def *~~ [U](lMin:Int, rRange:Pair[Int,Int], that: => Parser[U]) = concat(lMin,0,rRange._1,rRange._2)(that)
    def ~~* [U](lRange:Pair[Int,Int], rMin:Int, that: => Parser[U]) = concat(lRange._1,lRange._2,rMin,0)(that)
    def *~* [U](lMin:Int, rMin:Int, that: => Parser[U]) = concat(lMin,0,rMin,0)(that)

    def ~~ [U](lRange:Pair[Int,Int], rRange:Pair[Int,Int], that: => Parser[U]) = concat(lRange._1,lRange._2,rRange._1,rRange._2)(that)

    def -~~ [U](that: => Parser[U]) = concat(1,1,0,0)(that)
    def ~~- [U](that: => Parser[U]) = concat(0,0,1,1)(that)

    /*
     * Filter combinator.
     * Yields an empty list if the filter does not pass.
     */
    def filter (p: Subword => Boolean) = new Parser[T]{
      def apply(sw: Subword) = if(p(sw)) inner(sw) else List[T]()
      def makeTree = Filter(p, inner.makeTree)
    }

    /*
     * Tabulation (or memoization).
     * Might provide information regarding the table dimensions
     * as a parameter at some point.
     * Also records this parser as a global production
     */
    def tabulate(name:String, costMatrix: Array[Array[List[T]]]) = {
      val p = new Parser[T]{

        def apply(sw: Subword) = sw match {
          case (i: Int, j: Int) if(i <= j) =>
            costMatrix(i)(j) match {
              case Nil =>
                println("matrix lookup failed at " + sw)
                costMatrix(i)(j) = inner(sw); costMatrix(i)(j)
              case xs =>
                println("matrix lookup succeeded at " + sw)
                xs
            }
          case _ => List()
        }

        def makeTree =
          if(productionStore contains Production(name))
            Production(name)
          else{
            productionStore += Production(name)
            inner.makeTree
          }
      }

      prods2Parsers += Production(name) -> p.asInstanceOf[Parser[Any]]
      p
    }
  }
}

trait LexicalParsersB extends BDPParsers { this: Signature =>
  type Alphabet = Char

  def char = new Parser[Char]{
    def apply(sw:Subword) = sw match {
      case (i, j) if(j == i+1) => List(input(i))
      case _ => List()
    }
    def makeTree = SingleElem
  }

  def charf(f: Char => Boolean) = char filter {
    case(i,j) if(i+1 == j) => f(input(i))
    case _ => false
  }

  def digitParser: Parser[Int] = (char filter isDigit) ^^ readDigit

  def readDigit(c: Char) = (c - '0').toInt

  def isDigit(sw: Subword) = sw match{
    case(i,j) if(i+1 == j) => input(i).isDigit
    case _ => false
  }
}

trait GenB extends BDPParsers {this: Signature =>

  import scala.collection.mutable.HashMap

  def gen(t: PTree): String = t match {
    case Production(name) => name+"[i,j]"
    //case CharT() => "char"
    case Or(l,r) => gen(l) + " ++ " + gen(r)
    case Map(f, Concat(l,r, (lL, lU, rL, rU))) =>
      val lgen = gen(l)
      val rgen = gen(r)
      lgen+ "k]" + " + " + "[k" + rgen // to replace with gen of f
    case Map(f, t) =>
      gen(t)
    case Aggregate(h,t) =>
      "min(" + gen(t) +")"
    case SingleElem => "Terminal"
    case _ => "no gen yet!"
  }

  def gen[T](p: Parser[T]): String = gen(p.makeTree)


  /**
   * Bottom up parsing strategy
   * returns Unit because it will just fill the matrices
   */
  def bottomUp = {
    import scala.collection.mutable.HashMap

    val prods2Trees = for((k,v) <- prods2Parsers) yield (k, v.makeTree)
    val costs = new HashMap[Production, HashMap[Subword, List[Answer]]]

    for(prod <- productionStore){costs(prod) = new HashMap[Subword, List[Answer]]}

    for(j <- 0 until input.length){
      for(i <- (0 until j).reverse){
        for((prod, tree) <- prods2Trees){
          costs(prod)((i,j)) = gen0(tree, i, j)(costs)
        }
      }
    }
    costs
  }

  def gen0(p: PTree, i: Int, j: Int)(implicit costs: HashMap[Production, HashMap[Subword,List[Answer]]]) : List[Answer] = p match{
    case p@Production(_) => costs(p)((i,j))
    //case CharT() => "char"
    case Or(l,r) => gen0(l,i,j) ++ gen0(r,i,j)
    case Map(f, Concat(l,r, (lL, lU, rL, rU))) =>
      val min_k = if (rU==0) i+lL else Math.max(i+lL,j-rU)
      val max_k = if (lU==0) j-rL else Math.min(j-rL,i+lU)
      (for(
        k <- (min_k to max_k).toList;
        x <- gen0(l,i,k);
        y <- gen0(r,k,j)
      ) yield(f((x,y).asInstanceOf[Nothing]))
      ).asInstanceOf[List[Answer]]
    case Map(f, t) =>
      (for(ans <- gen0(t,i,j))
        yield (f(ans.asInstanceOf[Nothing]))
      ).asInstanceOf[List[Answer]]
    case Aggregate(h,t) =>
      h(gen0(t,i,j).asInstanceOf[List[Nothing]]).asInstanceOf[List[Answer]]
    case SingleElem =>
      if(i+1 == j) List(input(i).asInstanceOf[Answer]) else List()
    case _ => throw new Error("no option chosen!")
  }

  def bottomUp[T](p: Parser[T], costMatrix: Array[Array[List[T]]]): Array[Array[List[T]]] = {
    for(i <- 0 to input.length){
      for(j <- 0 to input.length){
        costMatrix(i)(j) = List()
      }
    }

    for(j <- 0 to input.length){
      for(i <- (0 to j).reverse){
        println((i,j) + " : ")
        costMatrix(i)(j) = p((i,j))
      }
    }
    costMatrix
  }

}

/*** Example ***/

object HelloBDP extends LexicalParsersB with BracketsAlgebra{
  def input = "(((3)))(2)".toArray
  def bracketize(c:Char,s:String) = "("+c+","+s+")"

  def areBrackets(sw: Subword) = sw match {
    case(i,j) => input(i) == '(' && input(j-1) == ')'
  }

  val dummyParser = digitParser | digitParser
  val myParser: Parser[Int] = (
      digitParser
    | (char -~~ myParser ~~- char).filter(areBrackets _).^^{ case (c1,(i,c2)) => i}
    | myParser +~+ myParser ^^ {case (x,y) => x+y}
  ).tabulate("myParser", Array(Array(List())))

  def main(args: Array[String]) = {
    println(myParser(0,input.length))
  }
}