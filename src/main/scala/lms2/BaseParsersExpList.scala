package lms2

import scala.virtualization.lms.common._


/*
import lms.{MyListOps,MyListOpsExp,ScalaGenMyListOps, MyScalaCompile}
import lms.{MyRangeOps,MyRangeOpsExp,ScalaGenMyRangeOps}
import lms.{ListToGenTransform,ScalaGenGeneratorOps}

trait Package extends ArrayOps with MyListOps with NumericOps with IfThenElse
                 with LiftNumeric with Equal with BooleanOps with OrderingOps
                 with MathOps with MyRangeOps with TupleOps with MiscOps {}
// XXX: how to control manually how operations ?
*/

// XXX: if we start importing LMS traits we end-up with all Scala code (analysis, static data) being lifted
// whereas this is not necessary (and not desired, as it restricts usable functions).
// Idea: use generators to achive what we want and combine them into BaseParsers to obtain desired effect ?

// (Rep[Int], Rep[Int]) => Generator[T]
// Generator[T:Manifest] extends (continuation:(Rep[T] => Rep[Unit]) => Rep[Unit]) <- execution

  /*
  def genApply(implicit mT:Manifest[T]) : ((Rep[Int],Rep[Int])=>Rep[List[(T,Backtrack)]]) = (x:Rep[Int],y:Rep[Int]) => unit(List[(T,Backtrack)]())
  def genUnapply(implicit mT:Manifest[T]) : ((Rep[Int],Rep[Int],Rep[Backtrack])=>Rep[Trace]) = (x:Rep[Int],y:Rep[Int],bt:Rep[Backtrack]) => unit(List[(Int,Int,Backtrack)]())
  def genReapply(implicit mT:Manifest[T]) : ((Rep[Int],Rep[Int],Rep[Backtrack])=>Rep[T]) = (x:Rep[Int],y:Rep[Int],bt:Rep[Backtrack]) => unit(null.asInstanceOf[T])
  */

trait BaseParsersExpList extends BaseParsers { this:Signature =>

  override type Rep[+A] = A
  override def unit[A : Manifest](a: A) = a

  // LMS nodes

  def findTab(rule:Rep[Int]):(Tabulate,Rep[Int]) = { // XXX: LMS/non-LMS involved
    rules.find{ case (n,t)=> val rr=rule-t.id; rr >= 0 && rr < t.inner.alt} match {
      case Some((n,t)) => (t,rule-t.id)
      case None => sys.error("No tabulation for subrule #"+rule)
    }
  }

  def tab_idx(t:Tabulate,i:Rep[Int],j:Rep[Int]):Rep[Int] = if (twotracks) i*unit(t.mW)+j else { val d=unit(t.mH)+1+i-j; ( unit(t.mH*(t.mH+1)) - d*(d-unit(1)) ) /unit(2) + i }
  def tab_apply(t:Tabulate,i:Rep[Int],j:Rep[Int]) = { val v = t.data(tab_idx(t,i,j)); if (v!=null) List((v._1,bt0)) else List() }
  def tab_unapply(t:Tabulate,i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = { val v=t.data(tab_idx(t,i,j)); if (v!=null) List((i,j,v._2)) else List() }
  def tab_reapply(t:Tabulate,i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = { val v=t.data(tab_idx(t,i,j)); if (v!=null) v._1 else sys.error("Failed reapply"+(i,j)) }
  def tab_compute(t:Tabulate,i:Rep[Int],j:Rep[Int]) = { val l=t.inner(i,j); if (!l.isEmpty) { val (c,(r,b))=l.head; t.data(tab_idx(t,i,j))=(c,(t.id+r,b)); } } // write-only
  def tab_build(t:Tabulate,bt:Trace):Answer = bt match {
    case bh::bs => val (i,j,(rule,b))=bh; val (t,rr)=findTab(rule); val a=t.inner.reapply(i,j,(rr,b)); if (bs==Nil) a else { t.data(tab_idx(t,i,j))=(a,bt0); t.build(bs) }
    case Nil => sys.error("No backtrack provided")
  }
  def tab_backtrack(t:Tabulate,i0:Int,j0:Int) = {
    val e=t.data(tab_idx(t,i0,j0))
    var pending:Trace = List((i0,j0,e._2))
    var trace:Trace = Nil
    while (!pending.isEmpty) {
      val el = pending.head; trace=el::trace;
      val (i,j,(rule,bt))=el;
      val (t,rr) = findTab(rule)
      val res = t.inner.unapply(i,j,(rr,bt))
      pending = res:::pending.tail;
    }
    List((e._1,trace))
  }
  def tab_init(t:Tabulate,w:Rep[Int],h:Rep[Int]) { t.mW=w; t.mH=h; val sz=if (twotracks) w*h else { assert(w==h); h*(h+1)/2 }; t.data=new Array(sz); }
  def tab_reset(t:Tabulate) { t.data=unit(null); t.mW=unit(0); t.mH=unit(0); }

  // term_apply is defined at terminal level
  def term_unapply[T](p:Terminal[T],i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = Nil
  def term_reapply[T](p:Terminal[T],i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = { val r=p.apply(i,j); if (r.isEmpty) sys.error("Empty apply"+(i,j)+" for "+bt); r.map{ _._1 }.head }

  def aggr_apply[T](p:Aggregate[T],i:Rep[Int],j:Rep[Int]) = { val l=p.inner(i,j); if (l.isEmpty) Nil else List(l.tail.foldLeft(l.head){(a,b)=> if (a._1==p.h(a._1,b._1)) a else b}) }
  def filter_apply[T](p:Filter[T],i:Rep[Int],j:Rep[Int]) = if(p.pred(i,j)) p.inner(i,j) else Nil

  def map_apply[T,U](p:Map[T,U],i:Rep[Int],j:Rep[Int]) = p.inner(i,j) map { case (s,b) => (p.f(s),b) }
  def map_reapply[T,U](p:Map[T,U],i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = p.f(p.inner.reapply(i,j,bt))

  def or_apply[T](p:Or[T],i:Rep[Int],j:Rep[Int]) = p.left(i,j) ++ p.right(i,j).map{ case (t,(r,b)) => (t,(r+p.left.alt,b)) }
  def or_unapply[T](p:Or[T],i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = { val (r,idx)=bt; var a=p.left.alt-1; if (r<=a) p.left.unapply(i,j,(r,idx)) else p.right.unapply(i,j,(r-a,idx)) } // XXX: can we make it generic
  def or_reapply[T](p:Or[T],i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = { val (r,idx)=bt; var a=p.left.alt-1; if (r<=a) p.left.reapply(i,j,(r,idx)) else p.right.reapply(i,j,(r-a,idx)) } // for both lists and generators ??

  def ccat_apply[T,U](p:Concat[T,U],i:Rep[Int],j:Rep[Int]) = {
    def bt(bl:Backtrack,br:Backtrack,k:Int):Backtrack = (bl._1*p.right.alt+br._1, bl._2:::(if (p.hasBt)List(k) else Nil):::br._2)
    val (lL,lU,rL,rU) = p.indices
    if (p.track==0) {
        val min_k = if (rU==maxN || i+lL > j-rU) i+lL else j-rU
        val max_k = if (lU==maxN || j-rL < i+lU) j-rL else i+lU
        for(
          k <- (min_k to max_k).toList;
          (x,xb) <- p.left(i,k);
          (y,yb) <- p.right(k,j)
        ) yield(((x,y),bt(xb,yb,k)))
    } else if (p.track==1) {
        val min_k = if (lU==maxN || i-lU < 0) 0 else i-lU
        val max_k = i-lL
        for(
          k <- (min_k to max_k).toList;
          (x,xb) <- p.left(k,i); // in1[k..i]
          (y,yb) <- p.right(k,j) // M[k,j]
        ) yield(((x,y),bt(xb,yb,k)))
    } else if (p.track==2) {
        val min_k = if (rU==maxN || j-rU < 0) 0 else j-rU
        val max_k = j-rL
        for(
          k <- (min_k to max_k).toList;
          (x,xb) <- p.left(i,k); // M[i,k]
          (y,yb) <- p.right(k,j) // in2[k..j]
        ) yield(((x,y),bt(xb,yb,k)))
    } else Nil
  }

  def ccat_split[T,U](p:Concat[T,U],i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]):(Int,Int,Backtrack,Int,Int,Backtrack) = {
    val (r,idx)=bt; val a:Int=p.right.alt; val c:Int=p.left.cat;
    val (bl,br) = ((r/a,idx.take(c)), (r%a,idx.drop(c+(if (p.hasBt)1 else 0))))
    val kb = if (p.hasBt) idx(c) else -1
    (p.track,p.indices) match {
      case (0,(lL,lU,rL,rU)) if i<j => val k=if(p.hasBt)kb else if (rU==maxN)i+lL else Math.max(i+lL,j-rU); (i,k,bl, k,j,br) // single track
      case (1,(l,u,_,_)) => val k=if(p.hasBt)kb else i-l; (k,i,bl, k,j,br) // tt:concat1
      case (2,(_,_,l,u)) => val k=if(p.hasBt)kb else j-l; (i,k,bl, k,j,br) // tt:concat2
      case _ => (0,0,bl, 0,0,br)
    }
  }
  def ccat_unapply[T,U](p:Concat[T,U],i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = { val (li,lj,bl,ri,rj,br)=ccat_split(p,i,j,bt); p.left.unapply(li,lj,bl) ::: p.right.unapply(ri,rj,br) }
  def ccat_reapply[T,U](p:Concat[T,U],i:Rep[Int],j:Rep[Int],bt:Rep[Backtrack]) = { val (li,lj,bl,ri,rj,br)=ccat_split(p,i,j,bt); (p.left.reapply(li,lj,bl), p.right.reapply(ri,rj,br)) }
}
