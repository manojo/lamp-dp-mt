import java.io._

case class Mat(rows:Int,cols:Int)

object Test extends App {
  @native def foo(in:Array[Mat]) : ((Int,Int,Int),List[ ((Int,Int),(Int,List[Int])) ])


  System.load(new File("Test.jnilib").getCanonicalPath)



  println("OK");
  var r = foo(Array(Mat(1,2),Mat(3,4),Mat(5,6),Mat(7,8)));

  println(r);

  //println("Hello, world!")
}


/*
CODE GENERATED WITH

object JNI extends App {
  val h = new CodeHeader(this)
  case class A(x:Int,y:Int)
  case class Alphabet(rows:Int,cols:Int)
  //type Alphabet = (Int,Int)
  type Answer = (Int,Int,Int)

  import scala.reflect.runtime.universe.typeTag
  val ti = typeTag[Alphabet].tpe.toString
  val tc = typeTag[Answer].tpe.toString
  // Faking a bit surrounding program
  h.add("#define TI "+h.getType(ti))
  h.add("#define TC "+h.getType(tc))
  h.add("typedef struct { short i,j,rule; short pos[3]; } trace_t;")
  h.add("const int trace_len[4] = {3,1,1,0};")
  println(h.flush)
  println(h.jniRead(h.parse(ti)))
  println(h.jniWrite(h.parse(tc)))
}

*/