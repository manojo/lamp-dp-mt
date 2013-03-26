package lms2

trait Signature {
  type Alphabet // input type
  type Answer // output type

  //def h(a:Answer,b:Answer):Answer // optimization function

  val mAlph: Manifest[Alphabet]
  val mAns : Manifest[Answer]
}

// (Rep[Int], Rep[Int]) => Generator[T]
// Generator[T:Manifest] extends (continuation:(Rep[T] => Rep[Unit]) => Rep[Unit]) <- execution

import scala.virtualization.lms.common._
import lms._
trait BaseParsers extends Package with GeneratorOps /*with LiftVariables*/{ this:Signature =>
  type Input = Array[Alphabet]
  type Backtrack = (Int,List[Int]) // (subrule_id, indices)
  type Trace = List[(Int,Int,Backtrack)]

  val twotracks = false // whether grammar is multi-track
  final val maxN = -1   // infinity for Parser.max

  def tabulate(name:String, inner: => Parser[Answer]) : Parser[Answer]
  def parser_aggr[T:Manifest](inner: Parser[T], h: (Rep[T],Rep[T]) => Rep[T]) : Parser[T]
  def parser_filter[T:Manifest](inner: Parser[T], pred:(Rep[Int],Rep[Int]) => Rep[Boolean]) : Parser[T]
  def parser_map[T:Manifest, U:Manifest](inner: Parser[T], f: Rep[T] => Rep[U]) : Parser[U]
  def parser_or[T:Manifest](left: Parser[T], right: Parser[T]): Parser[T]
  def parser_concat[T:Manifest, U:Manifest](left: Parser[T], right: Parser[U], track:Int): Parser[(T,U)]

  // Abstract parser
  sealed abstract class Parser[T:Manifest]{
    def min:Int // subword minimal size
    def max:Int // subword maximal size, -1=infinity
    val alt:Int // alternative (subrule_id)
    val cat:Int // concatenation split (offset in backtrack)


    // List-based vanilla Scala
    def apply(i:Rep[Int],j:Rep[Int]): Generator[T] //Generator[(T,Backtrack)]
    //def unapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]): Rep[Trace]
    //def reapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]): Rep[T]

    final def ^^[U:Manifest](f: Rep[T] => Rep[U]) = parser_map(this,f)
    final def |(other: Parser[T]) = parser_or(this,other)
    final def aggregate(h:(Rep[T],Rep[T])=>Rep[T]) = parser_aggr(this,h)
    final def filter (f:(Rep[Int],Rep[Int])=>Rep[Boolean]) = parser_filter(this,f)
  }
}

trait BaseParsersExp extends BaseParsers with PackageExp with GeneratorOpsExp { this:Signature =>
  def tabulate(name:String, inner: => Parser[Answer]) = new Tabulate(inner,name)(mAns)
  def parser_aggr[T:Manifest](inner: Parser[T], h: (Rep[T],Rep[T]) => Rep[T]) = Aggregate(inner,h)
  def parser_filter[T:Manifest](inner: Parser[T], pred:(Rep[Int],Rep[Int]) => Rep[Boolean]) = Filter(inner,pred)
  def parser_map[T:Manifest, U:Manifest](inner: Parser[T], f: Rep[T] => Rep[U]) = Map(inner,f)
  def parser_or[T:Manifest](left: Parser[T], right: Parser[T]) = Or(left,right)
  def parser_concat[T:Manifest, U:Manifest](left: Parser[T], right: Parser[U], track:Int) = Concat(left,right,track)

  // Forcibly escape LMS lifting (avoid forcing type for every operand)
  private def __min(a:Int,b:Int) = if (a < b) a else b
  private def __max(a:Int,b:Int) = if (a > b) a else b
  private def __or(a:Boolean,b:Boolean) = if (a) true else b
  private def __and(a:Boolean,b:Boolean) = if (a) b else false

  // axiom must be given to bottom up
  final val bt0:Rep[Backtrack] = (unit(0),List[Int]()) // default initial backtrack
  val axiom:Tabulate

  // Recurrence analysis, done once when grammar is complete, before the computation.
  private var analyzed:Boolean=false
  def analyze { if (analyzed) return; analyzed=true
    // Strip away unnecessary tabulations
    var used = scala.collection.mutable.Set[String](); use(axiom)
    def use[T](q:Parser[T]):Unit = q match {
      case Aggregate(p,_) => use(p) case Filter(p,_) => use(p) case Map(p,_) => use(p) case Or(l,r) => use(l); use(r) case Concat(l,r,_) => use(l); use(r)
      case t:Tabulate if (!used.contains(t.name)) => used++=scala.collection.mutable.Set(t.name); use(t.inner) case _ =>
    }
    for (n <- (rules.keys.toSet -- used)) rules.remove(n)
    // Yield analysis
    for((n,t)<-rules) t.minv=100000 // upper bound on minimum yields
    (0 until rules.size).foreach{ _ => for((n,t) <- rules) t.minv=t.inner.min }
    for((n,t)<-rules) t.maxv=t.minv
    for((n,t)<-rules) t.maxv=rmax(t.inner, rules.size)
    def rmax[T](p0:Parser[T],d:Int):Int = p0 match {
      case Terminal(_,max) => max
      case Filter(p,f) => rmax(p,d)
      case Aggregate(p,h) => rmax(p,d)
      case Map(p,f) => rmax(p,d)
      case Or(l,r) => val ml=rmax(l,d); if (ml==maxN) maxN else { val mr=rmax(r,d); if (mr==maxN) maxN else __max(ml,mr) }
      case Concat(l,r,_) => val ml=rmax(l,d); if (ml==maxN) maxN else { val mr=rmax(r,d); if (mr==maxN) maxN else ml+mr }
      case p:Tabulate => if (d==1) maxN else rmax(p.inner,d-1)
    }
    // Dependency analyis order: prevents infinite loops, also define an order for bottom up implementations (requires yield analysis)
    def deps[T](q:Parser[T]): List[String] = q match { // (A->B) <=> B(i,j) = ... | A(i,j)
      case Aggregate(p,_) => deps(p) case Filter(p,_) => deps(p) case Map(p,_) => deps(p) case Or(l,r) => deps(l)++deps(r)
      case cc@Concat(l,r,_) => val ix = cc.indices; val (lm,_,rm,_)=cc.indices; (if (lm==0) deps(r) else Nil) ::: (if (rm==0) deps(l) else Nil)
      case t:Tabulate => scala.List(t.name) case _ => Nil
    }
    val cs = rules.map{case (n,p)=>(n,deps(p.inner)) }
    while (!cs.isEmpty) { var rem=false;
      cs.foreach { case (n,ds) if (ds.isEmpty||(true/:ds.map{d=>rulesOrder.contains(d)}){case(a,b)=>a&&b}) => rem=true; rulesOrder=n::rulesOrder; cs.remove(n); case _ => }
      if (rem==false) sys.error("Loop between tabulations, error in grammar")
    }
    rulesOrder = rulesOrder.reverse
    // Identify subrules (uniquely within the same grammar as sorted by name)
    var id=0; for((n,p) <- rules.toList.sortBy(_._1)) { p.id=id; id=id+p.inner.alt; }
  }

  // --------------------------------------------------------------------------
  // Memoization through tabulation
  import scala.collection.mutable.HashMap
  var rulesOrder:List[String]=Nil // Order of tabulations evaluation
  val rules = new HashMap[String,Tabulate]
  //def tabInit(w:Rep[Int],h:Rep[Int]) = rules.foreach{ case (_,t) => t.init(w,h) }
  //def tabReset = rules.foreach{ case (_,t) => t.reset }
  class Tabulate(in: => Parser[Answer], val name:String)(implicit val mAns: Manifest[Answer]) extends Parser[Answer] {
    lazy val inner = in
    val (alt,cat) = (1,0)
    def min = minv; var minv:Int = 0
    def max = maxv; var maxv:Int = 0

    // Matrix storage
    //XXX: highly dubious trick here.. the var is unlifted and we are assigning a rep to it
    //Why and how it works exactly is a bit unclear.
    private var data: Rep[Array[Answer/*,Backtrack)*/]]  = unit(null)
    private var mW: Rep[Int] = unit(0)
    private var mH: Rep[Int] = unit(0)
    def init(w:Rep[Int],h:Rep[Int]) = {
      mW=w; mH=h;
      val sz:Rep[Int]= w*h
                    //  if (twotracks) w*h
                    //   else { /*assert(w==h);*/ h*(h+unit(1))/unit(2) }
        data=NewArray[Answer/*,Backtrack)*/](sz)
      unit({})
    }

    def reset { data=unit(null); mW=unit(0); mH=unit(0); }

    if (rules.contains(name)) sys.error("Duplicate tabulation name")
    rules += ((name,this))
    var id:Int = -1 // subrules base index

    /*@inline */private def idx(i:Rep[Int],j:Rep[Int]):Rep[Int] =
      if (twotracks) i*mW+j
      else {
        mW * i + j
        //val d= mH +unit(1)+i-j
        //( mH * (mH + unit(1)) - d*(d-unit(1)) ) / unit(2) + i
      }

    def apply(i:Rep[Int],j:Rep[Int]) = {
      /*val arr = readVar(data); */
      val v = data(idx(i,j))
      //cond(v != unit(null), elGen(v/*,bt0*/), emptyGen())
      elGen(v)
    } // read-only
    //def unapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = { val v=data(idx(i,j)); if (v!=unit(null)) List((i,j,v._2)) else List[(Int,Int,Backtrack)]() }
    //def reapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = { val v=data(idx(i,j)); /*if (v==unit(null)) sys.error("Failed reapply"+(i,j))*/ v._1 }
    def compute(i:Rep[Int],j:Rep[Int])(z: Rep[Answer], foldF: (Rep[Answer], Rep[Answer]) => Rep[Answer]):Rep[Unit] = {

      val s = var_new(z)
      inner(i,j).apply{ x: Rep[Answer/*,Backtrack*/] =>
        s = foldF(readVar(s), x)
      }
      /*val arr = readVar(data); */
      data(idx(i,j)) = readVar(s) //(e._1,b)
    } // write-only
    /*
    def build(bt:Trace):Answer = bt match {
      case bh::bs => val (i,j,(rule,b))=bh; val (t,rr)=findTab(rule); val a=t.inner.reapply(i,j,(rr,b)); if (bs==Nil) a else { data(idx(i,j))=(a,bt0); build(bs) }
      case Nil => sys.error("No backtrack provided")
    }
    */
    /*
    def backtrack(i0:Rep[Int],j0:Rep[Int]) = {
      val e=data(idx(i0,j0))
      var pending:Rep[Trace] = List((i0,j0,e._2))
      var trace:Rep[Trace] = List[(Int,Int,Backtrack)]()
      while (!pending.isEmpty) { // XXX: use an array instead ???
        val el = pending.head;
        println(el) // XXX: we loop always on the same element

        trace=el::trace;
        val i=el._1; val j=el._2; val rule=el._3._1; val bt=el._3._2;
        val (t,rr) = findTab(rule)
        val res = t.inner.unapply(i,j,(rr,bt))
        pending = res ++ pending.tail;
      }
      List((e._1,trace))
    }
    */
  }

  def findTab(rule:Rep[Int]):(Tabulate,Rep[Int]) = {
    var tab = rules.values.head; // placeholder
    var r:Rep[Int]=unit(0);
    for (t<-rules.values) {
      val rr=rule-unit(t.id);
      if (rr >= unit(0) && rr < unit(t.inner.alt)) {
        tab = t;
        r = rr;
      }
    }
    (tab,r)
  }

  // --------------------------------------------------------------------------
  // Terminal abstraction
  abstract case class Terminal[T:Manifest](min:Int,max:Int) extends Parser[T] {
    final val (alt,cat) = (1,0)
    //def unapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = List[(Int,Int,Backtrack)]()
    //def reapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = { val r=apply(i,j); /*if (r.isEmpty) sys.error("Empty apply"+(i,j)+" for "+bt);*/ r.map{ _._1 }.head }
  }

  // Aggregate combinator.
  // Takes a function which modifies the list of a parse. Usually used
  // for max or min functions (but can also be a prettyprint).
  case class Aggregate[T:Manifest](inner:Parser[T], h:(Rep[T],Rep[T])=>Rep[T]) extends Parser[T] {
    lazy val (alt,cat) = (inner.alt,inner.cat)
    def min = inner.min
    def max = inner.max
    def apply(i:Rep[Int],j:Rep[Int]) = {
      //XXX: change this later!
      inner(i,j)
      //val l=inner(i,j);
      //if (l.isEmpty) List[(T,Backtrack)]()
      //else list_reduce(l,(a:Rep[(T,Backtrack)],b:Rep[(T,Backtrack)]) => if (a._1==h(a._1,b._1)) a else b, l.head);
      // if (l.isEmpty) List[(T,Backtrack)]() else List(list_fold(l.tail,l.head,(a:Rep[(T,Backtrack)],b:Rep[(T,Backtrack)]) => if (a._1==h(a._1,b._1)) a else b ))
    }
    //def unapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = inner.unapply(i,j,bt) // we have only 1 result
    //def reapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = inner.reapply(i,j,bt)
  }

  // Filter combinator.
  // Yields an empty list if the filter does not pass.
  case class Filter[T:Manifest](inner:Parser[T], pred:(Rep[Int],Rep[Int])=>Rep[Boolean]) extends Parser[T] {
    lazy val (alt,cat) = (inner.alt,inner.cat)
    def min = inner.min
    def max = inner.max
    def apply(i:Rep[Int],j:Rep[Int]) =
      cond(pred(i,j), inner(i,j), emptyGen())
    //def unapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = inner.unapply(i,j,bt) // filter matched at apply
    //def reapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = inner.reapply(i,j,bt) // ditto
  }

  // Mapper. Equivalent of ADP's <<< operator.
  // To separate left and right hand side of a grammar rule
  case class Map[T:Manifest,U:Manifest](inner:Parser[T], f: Rep[T] => Rep[U]) extends Parser[U] {
    lazy val (alt,cat) = (inner.alt,inner.cat)
    def min = inner.min
    def max = inner.max
    def apply(i:Rep[Int],j:Rep[Int]) =
      inner(i,j) map { (x:Rep[T/*,Backtrack*/]) => f(x) /*(f(x._1),x._2)*/ }
    //def unapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = inner.unapply(i,j,bt)
    //def reapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = f(inner.reapply(i,j,bt))
  }

  // Or combinator. Equivalent of ADP's ||| operator.
  // In ADP semantics we concatenate the results of the parse
  // of 'this' with the parse of 'that'
  case class Or[T:Manifest](left:Parser[T], right:Parser[T]) extends Parser[T] {
    lazy val (alt,cat) = (left.alt+right.alt,__max(left.cat,right.cat))
    def min = __min(left.min,right.min)
    def max = if (__or(left.max==maxN, right.max==maxN)) maxN else __max(left.max,right.max)
    def apply(i:Rep[Int],j:Rep[Int]) = {
      left(i,j) ++ right(i,j)//.map{ x:Rep[(T,Backtrack)] => val b:Rep[Backtrack]=(x._2._1+unit(left.alt),x._2._2); (x._1,b) }
    }
    //def unapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = { val r=bt._1; var a=unit(left.alt-1); if (r<=a) left.unapply(i,j,bt) else right.unapply(i,j,(r-a,bt._2)) }
    //def reapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = { val r=bt._1; var a=unit(left.alt-1); if (r<=a) left.reapply(i,j,bt) else right.reapply(i,j,(r-a,bt._2)) }
  }

  // Concatenate combinator.
  // Parses a concatenation of string " left ~ right " with length(left) in [lL,lU]
  // and length(right) in [rL,rU], lU,rU=0 means unbounded (infinity).
  case class Concat[T:Manifest,U:Manifest](left: Parser[T], right:Parser[U], track:Int) extends Parser[(T,U)] {
    lazy val (alt,cat) = (left.alt*right.alt, left.cat+(if(hasBt)1 else 0)+right.cat)
    def min = left.min+right.min
    def max = if (__or(left.max==maxN, right.max==maxN)) maxN else left.max+right.max
    lazy val hasBt:Boolean = (track,left.min,left.max,right.min,right.max) match {
      case (0,a,b,c,d) if (__and(a==b,a>=0) || __and(c==d,c>=0)) => false
      case (1,a,b,_,_) if(__and(a==b,a>=0)) => false
      case (2,_,_,a,b) if(__and(a==b,a>=0)) => false
      case _ => true
    }
    lazy val indices = { assert(analyzed==true); (left.min,left.max,right.min,right.max) }
    @inline private def bt(bl:Rep[Backtrack],br:Rep[Backtrack],k:Rep[Int]):Rep[Backtrack] = {
      (bl._1*unit(right.alt)+br._1, bl._2 ++ (if (hasBt)List(k) else List[Int]()) ++ br._2)
    }

    def apply(i:Rep[Int],j:Rep[Int]) = {
      val (lL,lU,rL,rU) = indices
      if (track==0) {
        val min_k = if (rU==maxN) i+unit(lL) else Math.max(i+unit(lL),j-unit(rU))
        val max_k = if (lU==maxN) j-unit(rL) else Math.min(j-unit(rL),i+unit(lU))

        range(min_k, max_k+unit(1)).flatMap{ k=>
          left(i,k).flatMap{ x=>
            right(k,j).map{ y=>
              (x,y) //val t:Rep[(T,U)]=(x._1,y._1); (t,bt(x._2,y._2,k))
            }
          }
        }
      } else if (track==1) {
        val min_k = if (lU==maxN) unit(0) else Math.max(i-unit(lU),unit(0))
        val max_k = i-unit(lL)

        range(min_k, max_k+unit(1)).flatMap{ k=>
          left(k,i).flatMap{ x=>
            right(k,j).map{ y=>
              (x,y) //val t:Rep[(T,U)]=(x._1,y._1); (t,bt(x._2,y._2,k))
            }
          }
        }
      } else if (track==2) {
        val min_k = if (rU==maxN) unit(0) else Math.max(j-unit(rU),unit(0))
        val max_k = j-unit(rL)

        range(min_k, max_k+unit(1)).flatMap{ k=>
          left(i,k).flatMap{ x=>
            right(k,j).map{ y=>
              (x,y) //val t:Rep[(T,U)]=(x._1,y._1); (t,bt(x._2,y._2,k))
            }
          }
        }
      } else emptyGen[(T,U)/*,Backtrack*/]()
    }

    private def sw_split(i:Rep[Int],j:Rep[Int],kb:Rep[Int]):Rep[(Int,Int,Int,Int)] = (track,indices) match {
      case (0,(l,_,_,u)) => val k=if(hasBt)kb else if (u==maxN) i+l else Math.max(i+unit(l),j-unit(u)); (i,k, k,j) // single track
      case (1,(l,u,_,_)) => val k=if(hasBt)kb else i-unit(l); (k,i, k,j) // tt:concat1
      case (2,(_,_,l,u)) => val k=if(hasBt)kb else j-unit(l); (i,k, k,j) // tt:concat2
      case _ => (unit(0),unit(0), unit(0),unit(0))
    }

    private def bt_split(bt:Rep[Backtrack]):Rep[(Backtrack,Backtrack,Int)] = {
      val a:Int=right.alt; val c:Int=left.cat;
      /*
      val (r,idx)=bt;
      ((r/a,idx.take(c)), (r%a,idx.drop(c+(if (hasBt)1 else 0))), if (hasBt)idx(c) else -1)
      */
      (bt0, bt0, unit(0)) // XXX: must go away
    }

    /*def unapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = {
      val bb=bt_split(bt); val sw=sw_split(i,j,bb._3)
      left.unapply(sw._1,sw._2,bb._1) ++ right.unapply(sw._3,sw._4,bb._2)
    }
    def reapply(i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = {
      val bb=bt_split(bt); val sw=sw_split(i,j,bb._3)
      (left.reapply(sw._1,sw._2,bb._1), right.reapply(sw._3,sw._4,bb._2))
    }*/
  }


  /*
  ----
  I said something wrong: I don't pass the offset but directly values being written in the backtrack (hence overwrite
  the whole backtrack everytime I write a new value in the aggregation temporary variable); although, what I said for rule_id
  still remains valid.
  ---

  You need to pass additional information top-down when you are composing the parsers into a Generator
  See function signature in CodeGen.sala:105

  say we have transform(Parser, rule, off ) : Generator
  - rule represents the actual rule number that is tabulate.id + alternative index within the tabulation
  - off is the offset at which to write concatenation index in idx_tmp

  - In an aggregation, you need to create 4 variables: res:T, rule_id=-1, idx=idx_tmp=newArray(tabulation.ccat)
    In inner parsers, you just write and compare these variables.
    Make sure you initialize rule_id to -1.
    Whenever you write res=XXX also do idx=copy(idx_tmp), rule_id=rule

  - Map, Filter just pass rule and off values to inner
  - transform( Or(l,r), rule) ==> transform(l,rule,off) ... transform(r,rule + l.alt, off)
  - transform( cc@Concat(l,r), rule, aggr) ==> if (cc.hasBt) idx_tmp[off]=k;
                                               transform(l,rule,off),
                                               transform(r,rule,off+if (cc.hasBt) 1 else 0)
  */
  //probably not the most elegant way to do this, but will work for now.
  case class BTIndexWrapper[T:Manifest](p: Parser[T], indices: Rep[Array[Int]])

  // Generate C parser for subword (i,j): collect conditions, hoisted/content and backtrack indices
  // (parser, i,j,k?, subrule, aggregation_depth) => (Conditions+for loops, hoisted, body, backtrack indices)
  def addIndices[T:Manifest](p0: Parser[T], rule:Int, offset : Int) : BTIndexWrapper[T] = p0 match {

    case t@Terminal(_,_) => BTIndexWrapper(t, NewArray[Int](unit(0)))
    case p:Tabulate => BTIndexWrapper(p, NewArray[Int](unit(0)))

    //special case for us this one, used only as a fold?
    case a@Aggregate(p,h) =>
      val inner = addIndices(p, rule, offset+1)

      //val (c,hb,b,bti) = gen(p,i,j,g,rule,aggr+1)

      /*
      def bodyTpe:String = { // fallback to "typeof(body)" if untypable, where body has no fresh variable
        val g0:FreeVar = new FreeVar('0') { override def get=zero; override def dup=this }
        val (_,_,lb,_)=gen(p,zero,zero,g0,0,0); "typeof("+lb+")"
      }
      */

      /*if (aggr==0) (c,hb,cc,bti) // hoist aggregation if contained
      else { val nv = tpe+" "+tc+"; "+btTpe(p.cat)+" "+tb+"={-1"+(if (p.cat>0)",{}" else "")+"};\n";
        (List(CUser(tb+".rule!=-1")),nv+emit((c,hb,cc,bti)),tc,(0 until p.cat).map{x=>tb+".pos["+x+"]"}.toList)
      }
      */
      BTIndexWrapper(p, NewArray[Int](unit(0)))

    case Or(l,r) => BTIndexWrapper(p0, NewArray[Int](unit(0)))

    case m@Map(p,f) => addIndices(p, rule, offset) match {
      case BTIndexWrapper(_, indices) => BTIndexWrapper(m, indices)
    }

    case fi@Filter(p,f) => addIndices(p, rule, offset) match {
      case BTIndexWrapper(_, indices) => BTIndexWrapper(fi, indices)
    }

    case cc@Concat(l,r,tt) =>
     /*def bf1(f:Int, l:Int, u:Int):List[Cond] = { val ls=List(i.leq(j,f+l)); if (u!=maxN) j.leq(i,-f-u)::ls else ls }
      val (c,k):(List[Cond],Var) = (tt,cc.indices) match {
        // low=up in at least one side
        case (0,(iL,iU,jL,jU)) if (iL==iU && jL==jU) => (List(i.eq(j,iL+jL)), i.add(iL))
        case (0,(iL,iU,jL,jU)) if (iL==iU) => (bf1(iL,jL,jU), i.add(iL))
        case (0,(iL,iU,jL,jU)) if (jL==jU) => (bf1(jL,iL,iU), j.add(-jL))
        // most general case
        case (0,(iL,iU,jL,jU)) => val k0=g.get; var cs:List[Cond]=Nil;
          if (jU!=maxN) cs = j.leq(k0,-jU) :: cs
          if (iU!=maxN) cs = k0.leq(i,-iU) :: cs // we might want to simplify if min_k==i || max_k==j
          (CFor(k0.v,i.v,iL,j.v,jL)::cs, k0)
        // concat1,concat2
        case (t,(a,b,c,d)) if (t==1||t==2) => val (l,u,v) = if (t==1) (a,b,i) else (c,d,j)
          if (l==u) (List(zero.leq(v,l)), v.add(-l))
          else { val k0=g.get; val cu=if (u==maxN) Nil else List(k0.leq(v,u)); (CFor(k0.v,'0',0,v.v,l)::cu, k0) }
      }
      val (lc,lhb,lb,lbt) = if (tt==1) gen(l,k,i,g,rule,aggr) else gen(l,i,k,g,rule,aggr)
      val (rc,rhb,rb,rbt) = gen(r,k,j,g,rule,aggr)
      (simplify(c:::lc:::rc), lhb+(if (lhb!=""&&rhb!="") "\n" else "")+rhb, lb+","+rb, lbt:::(if(cc.hasBt) List(k.toString) else Nil):::rbt)
      */
      BTIndexWrapper(cc, NewArray[Int](unit(0)))
    case _ => sys.error("Unknown parser")
  }

}
