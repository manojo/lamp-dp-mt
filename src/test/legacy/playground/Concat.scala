package playground

// See function tupling and tuples flattening
// http://trac.assembla.com/metascala/browser/src/metascala/HLists.scala
// http://stackoverflow.com/questions/2354277/function-tupled-and-placeholder-syntax

object HLists {
  // Definitions
  import scala.language.higherKinds
  sealed trait HList {
    type Head
    type Tail <: HList
    type Append[L <: HList] <: HList
  }
  final class HNil extends HList {
    type Head = Nothing
    type Tail = HNil
    type Append[L <: HList] = L
    def ::[T](v : T) = HCons(v, this)
    def :::[L <: HList](l : L) = l
  }
  val HNil = new HNil

  final case class HCons[H, T <: HList](head : H, tail : T) extends HList {
    type This = HCons[H, T]
    type Head = H
    type Tail = T
    type Append[L <: HList] = HCons[H, T#Append[L]]
    def ::[T](v : T) = HCons(v, this)
    def :::[L <: HList](l : L)(implicit fn : AppendFn[L, This]) = fn(l, this)
  }
  case class AppendFn[L1<:HList, L2<:HList](fn:(L1,L2) => L1#Append[L2]) { def apply(a1:L1,a2:L2) = fn(a1, a2) }
  implicit def hlistNilAppender[L<:HList] = AppendFn[HNil,L]((v:HNil,l:L) => l)
  implicit def hlistConsAppender[H,T<:HList,L2<:HList, R<:HList]
    (implicit fn:AppendFn[T,L2]) = AppendFn[HCons[H,T],L2]((l1:HCons[H,T], l2:L2) => HCons(l1.head, fn(l1.tail, l2)))

  // Conversion from HList to function arguments
  import scala.language.implicitConversions
  implicit def appF1[A,R](f:Function1[A,R]) = new (HCons[A,HNil]=>R) {
    def apply(l:HCons[A,HNil]) = l match { case HCons(a,HNil) => f(a) }
  }
  implicit def appF2[A,B,R](f:Function2[A,B,R]) = new (HCons[A,HCons[B,HNil]]=>R) {
    def apply(l:HCons[A,HCons[B,HNil]]) = l match { case HCons(a,HCons(b,HNil)) => f(a,b) }
  }
  implicit def appF3[A,B,C,R](f:Function3[A,B,C,R]) = new (HCons[A,HCons[B,HCons[C,HNil]]]=>R) {
    def apply(l:HCons[A,HCons[B,HCons[C,HNil]]]) = l match { case HCons(a,HCons(b,HCons(c,HNil))) => f(a,b,c) }
  }
  implicit def appF4[A,B,C,D,R](f:Function4[A,B,C,D,R]) = new (HCons[A,HCons[B,HCons[C,HCons[D,HNil]]]]=>R) {
    def apply(l:HCons[A,HCons[B,HCons[C,HCons[D,HNil]]]]) = l match { case HCons(a,HCons(b,HCons(c,HCons(d,HNil)))) => f(a,b,c,d) }
  }
  implicit def appF5[A,B,C,D,E,R](f:Function5[A,B,C,D,E,R]) = new (HCons[A,HCons[B,HCons[C,HCons[D,HCons[E,HNil]]]]]=>R) {
    def apply(l:HCons[A,HCons[B,HCons[C,HCons[D,HCons[E,HNil]]]]]) = l match { case HCons(a,HCons(b,HCons(c,HCons(d,HCons(e,HNil))))) => f(a,b,c,d,e) }
  }
}

object Concat extends App {
/*
  def f(p:(Int,Int),x:Int,s:String) = s+(x*x)+" "+p

  import HLists._
  val as = ((1,2)::HNil) ::: (5 :: "foo" :: HNil)
  println(  (f _)(as)  )
*/
  /*
  // With regular lists, typing error goes unnoticed through compilation
  val arg = 5 :: "foo" :: Nil
  def f(x:Int,s:String) = s+(x+x)

  import scala.language.implicitConversions
  implicit def toF2[T,U,R](f:Function2[T,U,R]) = new (List[Any]=>R) {
    def apply(l:List[Any]) = l match {
      case (a:T @unchecked) :: (b:U @unchecked) :: Nil => f(a,b)
      case _ => sys.error("Error")
    }
  }
  println((f _)(arg))
  */

  import scala.language.implicitConversions
  implicit def detuple2[A,B,R](fn:Function2[A,B,R]) = new (((A,B))=>R) {
    def apply(t:(A,B)) = { val (a,b)=t; fn(a,b) } }
  implicit def detuple3[A,B,C,R](fn:Function3[A,B,C,R]) = new ((((A,B),C))=>R) {
    def apply(t:((A,B),C)) = { val ((a,b),c)=t; fn(a,b,c) } }
  implicit def detuple4[A,B,C,D,R](fn:Function4[A,B,C,D,R]) = new (((((A,B),C),D))=>R) {
    def apply(t:(((A,B),C),D)) = { val (((a,b),c),d)=t; fn(a,b,c,d) } }
  implicit def detuple5[A,B,C,D,E,R](fn:Function5[A,B,C,D,E,R]) = new ((((((A,B),C),D),E))=>R) {
    def apply(t:((((A,B),C),D),E)) = { val ((((a,b),c),d),e)=t; fn(a,b,c,d,e) } }
  implicit def detuple6[A,B,C,D,E,F,R](fn:Function6[A,B,C,D,E,F,R]) = new (((((((A,B),C),D),E),F))=>R) {
    def apply(t:(((((A,B),C),D),E),F)) = { val (((((a,b),c),d),e),f)=t; fn(a,b,c,d,e,f) } }
  implicit def detuple7[A,B,C,D,E,F,G,R](fn:Function7[A,B,C,D,E,F,G,R]) = new ((((((((A,B),C),D),E),F),G))=>R) {
    def apply(t:((((((A,B),C),D),E),F),G)) = { val ((((((a,b),c),d),e),f),g)=t; fn(a,b,c,d,e,f,g) } }

  object foo {
    def f(x:Int,s:String) = s+(x+x)
    def g = println((f _)((5,"foo")))
  }
  foo.g

}
