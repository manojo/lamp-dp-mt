package playground

trait Foo {
  import scala.language.implicitConversions
  import scala.reflect._

  def tpof(tp:String) = println("Type = "+tp)



  implicit def tp0[T:ClassTag](a:T):String = { val s=classTag[T].runtimeClass.toString;
    (if (s=="class java.lang.Object") a.getClass.toString else s) match {
  	case "boolean"|"byte"|"char"|"short"|"int"|"long"|"float"|"double" => s.substring(0,1).toUpperCase+s.substring(1,s.length)
    case t if (t=="class java.lang.Object") => "tpof(a)"
    case t if (t.startsWith("class java.lang.")) => t.substring(16)
  	case t if (t.startsWith("class scala.Tuple")) => Integer.parseInt(t.substring(17)) match {
  	  case 2 => tp2(a.asInstanceOf[Tuple2[Any,Any]])
  	  case 3 => tp3(a.asInstanceOf[Tuple3[Any,Any,Any]])
  	  case 4 => tp4(a.asInstanceOf[Tuple4[Any,Any,Any,Any]])
  	  case 5 => tp5(a.asInstanceOf[Tuple5[Any,Any,Any,Any,Any]])
  	}
  	case _ => s.substring(6)
  }}
  implicit def tp1[T:ClassTag](a:Tuple1[T]) = "("+tp0(a._1)+")"
  implicit def tp2[T:ClassTag,U:ClassTag](a:(T,U)) = "("+tp0(a._1)+","+tp0(a._2)+")"
  implicit def tp3[T:ClassTag,U:ClassTag,V:ClassTag](a:(T,U,V)) = "("+tp0(a._1)+","+tp0(a._2)+","+tp0(a._3)+")"
  implicit def tp4[T:ClassTag,U:ClassTag,V:ClassTag,W:ClassTag](a:(T,U,V,W)) = { "("+tp0(a._1)+","+tp0(a._2)+","+tp0(a._3)+","+tp0(a._4)+")" }
  implicit def tp5[T:ClassTag,U:ClassTag,V:ClassTag,W:ClassTag,X:ClassTag](a:(T,U,V,W,X)) = { "("+tp0(a._1)+","+tp0(a._2)+","+tp0(a._3)+","+tp0(a._4)+","+tp0(a._5)+")" }
  implicit def tp6[T:ClassTag,U:ClassTag,V:ClassTag,W:ClassTag,X:ClassTag,Y:ClassTag](a:(T,U,V,W,X,Y)) = {
  	"("+tp0(a._1)+","+tp0(a._2)+","+tp0(a._3)+","+tp0(a._4)+","+tp0(a._5)+","+tp0(a._6)+")"
  }

  case class Mat(rows:Int, cols:Int)

}

object Play extends App with Foo {
  type Answer = (Int,Int,Int)

  //tpof((1,2))
  //tpof(1)
  tpof(("foo",2.toChar,3.toLong,4.toShort,Mat(1,3),(1.toFloat,(0.toByte,2))))

  //println(tp1((1,2)))

  //println((1,2).isInstanceOf[Product])

  println("Hello world")
}
