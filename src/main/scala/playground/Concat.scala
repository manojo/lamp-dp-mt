package playground

// XXX: see function tupling and tuples flattening
// http://trac.assembla.com/metascala/browser/src/metascala/HLists.scala
// http://stackoverflow.com/questions/2354277/function-tupled-and-placeholder-syntax

object HLists {
  sealed trait HList {
    type Head
    type Tail <: HList
    type Append[L <: HList] <: HList
    val length:Int
  }

  final class HNil extends HList {
    type Head = Nothing
    type Tail = HNil
    type Append[L <: HList] = L
    val length = 0
    def ::[T](v : T) = HCons(v, this)
    def :::[L <: HList](l : L) = l
  }
  val HNil = new HNil()

  final case class HCons[H, T <: HList](head : H, tail : T) extends HList {
    type This = HCons[H, T]
    type Head = H
    type Tail = T
    type Append[L <: HList] = HCons[H, T#Append[L]]
    val length = tail.length+1
    def ::[T](v : T) = HCons(v, this)
    def :::[L <: HList](l : L)(implicit fn : AppendFn[L, This]) = fn(l, this)
  }
  case class AppendFn[L1 <: HList, L2 <: HList](fn:(L1, L2) => L1#Append[L2]) { def apply(a1:L1,a2:L2) = fn(a1, a2) }
  implicit def hlistNilAppender[L <: HList] = AppendFn[HNil, L]((v : HNil, l : L) => l)
  implicit def hlistConsAppender[H, T <: HList, L2 <: HList, R <: HList]
    (implicit fn : AppendFn[T, L2]) = AppendFn[HCons[H, T], L2]((l1 : HCons[H, T], l2 : L2) => HCons(l1.head, fn(l1.tail, l2)))
}

object Concat extends App {

  // With regular lists, typing error goes unnoticed through compilation
  val arg = 5 :: "foo" :: Nil
  def f(x:Int,s:String) = s+(x+x)

  def app[T,U,V](f:Function2[T,U,V],l:List[Any]) = l match {
    case (a:T @unchecked) :: (b:U @unchecked) :: Nil => f(a,b)
    case _ => sys.error("Foo")
  }
  println(app(f,arg))

  // With HLists, typing error is detected at compile time
  import HLists._
  val a = 3 :: true :: (4,8) :: HNil // That's like usual lists except Nil->HNil
  val b = 5 :: "foo" :: HNil
  val c = a ::: b

  val argh = 5 :: "foo" :: HNil
  def apph[T,U,V](f:Function2[T,U,V],l:HCons[T,HCons[U,HNil]]) = l match {
    case HCons(a,HCons(b,HNil)) => f(a,b)
    case _ => sys.error("Foo")
  }
  println(apph(f,argh))

  /*
  import scala.language.implicitConversions
  implicit def toF2[T,U,R](f:Function2[T,U,R]) = new (List[Any]=>R) {
    def apply(l:List[Any]) = l match {
      case (a:T @unchecked) :: (b:U @unchecked) :: Nil => f(a,b)
      case _ => sys.error("Bar")
    }
  }
  println((f _)(arg))
  */
}
