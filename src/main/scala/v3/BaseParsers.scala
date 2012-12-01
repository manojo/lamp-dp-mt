package v3

trait BaseParsers extends CodeGen { this:Signature =>
  type Input = Array[Alphabet]
  type Subword = (Int, Int)
  type Backtrack = (Int,List[Int]) // (rule_id, indices)
  type BTItem = (Subword,Answer,Backtrack)

  val bt0 = (0,Nil) // default initial backtrack

  // Memoization through tabulation
  import scala.collection.mutable.HashMap
  val tabs = new HashMap[String,HashMap[Subword,List[(Answer,Backtrack)]]]
  var reset:(()=>Unit) = () => { /*printTabs*/ }

  override type Tabulation=Tabulate
  def tabulate(name:String, inner: => Parser[Answer]) = new Tabulate(name,inner)
  class Tabulate(name:String, inner: => Parser[Answer]) extends Parser[Answer] with TreeRoot {
    val map = tabs.getOrElseUpdate(name,new HashMap[Subword,List[(Answer,Backtrack)]])
    reset = { val r0=reset; () => { r0(); map.clear; } }
    rules += ((name,this))

    override def makeTree = inner.tree
    val tree = PRule(name)

    private def get(sw:Subword) = { if (!twotracks) assert(sw._1<=sw._2); map.getOrElseUpdate(sw, inner(sw).map{case(c,(r,b))=>(c,(id+r,b))}) }

    def apply(sw: Subword) = get(sw) map {x=>(x._1,bt0)}
    override def apply2(sw:Subword,bt:Backtrack) = get(sw) map { case (c,b) => (c,List((sw,c,b))) } 

    override def reapply(sw:Subword,bt:Backtrack) = map.get(sw) match {
      case Some(v) => v.head._1
      case _ => apply(sw).head._1 // XXX: are we sure we do not trigger subcomputations?
    }

    def build(sw:Subword, bt:Backtrack) = inner.reapply(sw,bt)

    def backtrack(sw:Subword) = countMap(get(sw), (e:(Answer,Backtrack),n:Int)=>backtrack0(n,Nil,List((sw,e._1,e._2))).map{x=>(e._1,x)} ).flatten
    private def countMap[T,U](ls:List[T],f:((T,Int)=>U)):List[U] = ls.groupBy(x=>x).map{ case(e,l)=>f(e,l.length) }.toList
    private def backtrack0(mult:Int,tail:List[(Subword,Backtrack)],pending:List[BTItem]):List[List[(Subword,Backtrack)]] = pending match {
      case Nil => List(tail)
      case (sw,score,(rule,bt))::ps =>
        val res = inner.apply2(sw, (rule-id,bt)).filter{case(r,l)=>r==score}.map{case(r,l)=>l}.take(mult)
        countMap(res,(pl:List[BTItem],mul:Int)=>backtrack0(mul,(sw,(rule,bt))::tail, pl:::ps)  ).flatten
    }

    // XXX: fix backtrack in TT parsers
    // XXX: How to pretty print/execute efficiently a backtrack ?
    // XXX: use a 2nd argument to mapper => 2nd grammar? match maps by function name?? (signature)
    // --------------------------------------------------
/*
Ideas for a pretty printer:
keep a List/HashMap of processed elements (aka pretty-printed)
when adding a new element along backtrack
1. forall elements inside that map, filter(contained in current).sort(along word length)
2. matching_name+"("+ sorted subwords +")"
Use a function that take an integer and a list of Answers and combine them into a new answer
*/
    // --------------------------------------------------

  }

  // Aggregate on T a (T,U) list, wrt to multiplicity and order
  def aggr[T,U](l:List[(T,U)], h: List[T] => List[T]):List[(T,U)] = {
    val a=l.toArray; var start=0
    h(l.map(_._1)).map { b => val i=a.indexWhere({x=>x._1==b},start); val r=a(i); a(i)=a(start); start=start+1; r }
  }

  // Mapper. Equivalent of ADP's <<< operator.
  // To separate left and right hand side of a grammar rule
  def p_map[T,U](inner:Parser[T], f: T => U) = new Parser[U] {
    val tree = PMap(f,inner.tree)
    def apply(sw:Subword) = inner(sw) map { case (s,b) => (f(s),b) }
    override def apply2(sw:Subword,bt:Backtrack) = inner.apply2(sw,bt) map { case (s,b) => (f(s),b) }
    override def reapply(sw:Subword, bt:Backtrack) = f(inner.reapply(sw,bt))
  }

  // Or combinator. Equivalent of ADP's ||| operator.
  // In ADP semantics we concatenate the results of the parse
  // of 'this' with the parse of 'that'
  def p_or[T](inner:Parser[T], that: Parser[T]) = new Parser[T] {
    val tree = POr(inner.tree, that.tree)
    def apply(sw: Subword) = inner(sw) ++ that(sw).map{case(t,(r,b))=>(t,(r+inner.tree.alt,b))}
    override def apply2(sw:Subword,bt:Backtrack) = bt match {
      case (r,idx) => var a = inner.tree.alt-1; if (r<=a) inner.apply2(sw,(r,idx)) else that.apply2(sw,(r-a,idx)) 
    }
    override def reapply(sw:Subword, bt:Backtrack) = bt match {
      case (r,idx) => var a = inner.tree.alt-1; if (r<=a) inner.reapply(sw,(r,idx)) else that.reapply(sw,(r-a,idx)) 
    }
  }

  // Aggregate combinator.
  // Takes a function which modifies the list of a parse. Usually used
  // for max or min functions (but can also be a prettyprint).
  def p_aggr[T](inner:Parser[T], h: List[T] => List[T]) = new Parser[T] {
    val tree = PAggr(h,inner.tree)
    def apply(sw: Subword) = aggr(inner(sw),h)
    override def apply2(sw:Subword,bt:Backtrack) = aggr(inner.apply2(sw,bt),h)
    override def reapply(sw:Subword, bt:Backtrack) = inner.reapply(sw,bt)
  }

  // Filter combinator.
  // Yields an empty list if the filter does not pass.
  def p_filter[T](inner:Parser[T], p: Subword => Boolean) = new Parser[T] {
    val tree = PFilter(p, inner.tree)
    def apply(sw: Subword) = if(p(sw)) inner(sw) else List[(T,Backtrack)]()
    override def apply2(sw:Subword,bt:Backtrack) = inner.apply2(sw,bt) // filter must have matched at apply
    override def reapply(sw:Subword, bt:Backtrack) = inner.reapply(sw,bt) // filter must have matched at apply
  }

  // Concatenate combinator.
  // Parses a concatenation of string left~right with length(left) in [lL,lU]
  // and length(right) in [rL,rU], lU,rU=0 means unbounded (infinity).
  def p_concat[T,U](inner:Parser[T], that: Parser[U], indices:(Int,Int,Int,Int)) = new Parser[(T,U)] {
    val tree = PConcat(inner.tree, that.tree, indices)
    private def bt(bl:Backtrack,br:Backtrack,k:Int):Backtrack = {
      (bl._1 * that.tree.alt + br._1, bl._2 ::: (if (tree.bt)List(k) else Nil) ::: br._2)
    }
    def apply(sw: Subword) = (twotracks,sw,indices) match {
      case (false,(i,j),(lL,lU,rL,rU)) if i<j => // single track
        val min_k = if (rU==0) i+lL else Math.max(i+lL,j-rU)
        val max_k = if (lU==0) j-rL else Math.min(j-rL,i+lU)
        for(
          k <- (min_k to max_k).toList;
          (x,xb) <- inner((i,k));
          (y,yb) <- that((k,j))
        ) yield(((x,y),bt(xb,yb,k)))
      case (true,(i,j),(l,u,1,_)) => // tt:concat1
        val i0 = if (l==0) 0 else Math.max(i-l,0)
        for(
          k <- (i0 to i-u).toList;
          (x,xb) <- inner((k,i)); // in1[k..i]
          (y,yb) <- that((k,j))   // M[k,j]
        ) yield(((x,y),bt(xb,yb,k)))
      case (true,(i,j),(l,u,2,_)) => // tt:concat2
        val j0 = if (l==0) 0 else Math.max(j-l,0)
        for(
          k <- (j0 to j-u).toList;
          (x,xb) <- inner((i,k)); // M[i,k]
          (y,yb) <- that((k,j))   // in2[k..j]
        ) yield(((x,y),bt(xb,yb,k)))
      case _ => List()
    }
    override def apply2(sw:Subword,bt:Backtrack) = {
      val (bl:Backtrack,br:Backtrack,kb:Int) = bt match { case (r,idx) => 
        val a:Int=that.tree.alt; val c:Int=inner.tree.ccat;
        ((r/a,idx.take(c)), (r%a,idx.drop(c+(if (tree.bt)1 else 0))), if (tree.bt)idx(c) else -1)
      }
      val (swl:Subword,swr:Subword) = (twotracks,sw,indices) match {
        case (false,(i,j),(lL,lU,rL,rU)) if i<j => // single track
          val k=if(-1!=kb)kb else if (rU==0)i+lL else Math.max(i+lL,j-rU); ((i,k),(k,j))
        case (true,(i,j),(l,u,1,_)) => val k=if(-1!=kb)kb else i-l; ((k,i),(k,j)) // tt:concat1
        case (true,(i,j),(l,u,2,_)) => val k=if(-1!=kb)kb else j-l; ((i,k),(k,j)) // tt:concat2
        case _ => ((0,0),(0,0))
      }
      for (
        (x,xb) <- inner.apply2(swl,bl);
        (y,yb) <- that.apply2(swr,br)
      ) yield (((x,y), xb:::yb))
    }
    override def reapply(sw:Subword,bt:Backtrack) = {
      val (bl:Backtrack,br:Backtrack,kb:Int) = bt match { case (r,idx) => 
        val a:Int=that.tree.alt; val c:Int=inner.tree.ccat;
        ((r/a,idx.take(c)), (r%a,idx.drop(c+(if (tree.bt)1 else 0))), if (tree.bt)idx(c) else -1)
      }
      val (swl:Subword,swr:Subword) = (twotracks,sw,indices) match {
        case (false,(i,j),(lL,lU,rL,rU)) if i<j => // single track
          val k=if(-1!=kb)kb else if (rU==0)i+lL else Math.max(i+lL,j-rU); ((i,k),(k,j))
        case (true,(i,j),(l,u,1,_)) => val k=if(-1!=kb)kb else i-l; ((k,i),(k,j)) // tt:concat1
        case (true,(i,j),(l,u,2,_)) => val k=if(-1!=kb)kb else j-l; ((i,k),(k,j)) // tt:concat2
        case _ => ((0,0),(0,0))
      }
      (inner.reapply(swl,bl), that.reapply(swr,br))
    }
  }

  abstract class Parser[T] extends (Subword => List[(T,Backtrack)]) with Treeable { inner =>
    def apply(sw: Subword): List[(T,Backtrack)]
    def apply2(sw:Subword,bt:Backtrack): List[(T, List[BTItem])] = apply(sw).map{case(t,b)=>(t,Nil)} // default for terminals
    def reapply(sw:Subword, bt:Backtrack):T = apply(sw).map{_._1}.head // default for terminals

    final def ^^[U](f: T => U) = p_map(inner,f)
    final def |(that: Parser[T]) = p_or(inner,that)
    final def aggregate(h: List[T] => List[T]) = p_aggr(inner,h)
    final def filter (p: Subword => Boolean) = p_filter(inner,p)
  }

  // --------------------------------------------------------------------------
  // Utilities for debugging and pretty-printing
  def printBT(bs:List[(Answer,List[(Subword,Backtrack)])]) = {
    println("{")
    for(b<-bs) { print("  "+b._1+"   BT =")
      for (((i,j),(r,bt)) <- b._2) { print(" ["+i+","+j+"]="+r+","+bt+" ") }; println
    }
    println("}")
  }
  def printTabs {
    for((n,t)<-tabs) { println(n+":")
      for((k,v)<-t; (c,(r,bt))<-v) printf("  %-7s -> %-60s %d, %s\n",k,c,r,bt); println
    }
  }
}

