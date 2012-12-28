package playground

object Types extends App {
  val within = this

  def add(b:String,n:String):String = { println("typedef struct { "+b+"; } "+n+";"); n }

  sealed abstract class Tp {
    def name:String = this match {
      case TPri(_,_,n) => n.substring(0,1).toLowerCase
      case TTuple(a) => "t"+a.size+a.map{_.name}.mkString
      case TClass(n,_) => "_"+n.toLowerCase
    }
    override def toString() = this match {
      case TPri(_,c,_) => c
      case TTuple(a) => add(a.zipWithIndex.map{case(t,i)=>t.toString+" _"+(i+1) }.mkString("; "),this.name)
      case TClass(n,a) => add(a.map{case (t,n)=>t+" "+n}.mkString("; "), n.toLowerCase+"_t")
    }
  }
  case class TPri(s:String,c:String,n:String) extends Tp
  case class TTuple(a:List[Tp]) extends Tp
  case class TClass(n:String,a:List[(Tp,String)]) extends Tp
  val pri = Map(("Boolean",TPri("Boolean","bool"         ,"Z")), // Scala, C, JNI
                ("Byte"   ,TPri("Byte"   ,"unsigned char","B")),
                ("Char"   ,TPri("Char"   ,"char"         ,"C")),
                ("Short"  ,TPri("Short"  ,"short"        ,"S")),
                ("Int"    ,TPri("Int"    ,"int"          ,"I")),
                ("Long"   ,TPri("Long"   ,"long"         ,"J")),
                ("Float"  ,TPri("Float"  ,"float"        ,"F")),
                ("Double" ,TPri("Double" ,"double"       ,"D")),
                ("String" ,TPri("String" ,"const char*"  ,"Ljava/lang/String;")))

  private val ctx = within.getClass.getCanonicalName
  private def up1(s:String) = s.substring(0,1).toUpperCase+s.substring(1)
  import scala.util.parsing.combinator.syntactical.StandardTokenParsers
  object TypeParser extends StandardTokenParsers {
    import lexical.{NumericLit,StringLit}
    lexical.reserved ++= pri.keys.toList ++ (pri.keys.toList.map{_.toLowerCase}.filter{x=>x!="string"}) ++ List("scala","class")
    lexical.delimiters ++= List("(",")",",",".","$")
    private def p:Parser[Tp]=(
        ("boolean"|"byte"|"char"|"short"|"int"|"long"|"float"|"double") ^^ { x=>pri(up1(x)) }
      | opt(("scala")~".")~>("Boolean"|"Byte"|"String"|"Char"|"Short"|"Int"|"Long"|"Float"|"Double") ^^ { x=>pri(x) }
      | "(" ~> repsep(p,",") <~ ")" ^^ { a => TTuple(a) }
      | opt("class")~>repsep(ident,"."|"$") ^^ { x=> x.mkString(".") match {
          case "java.lang.Integer" => pri("Int")
          case n if (n.startsWith("java.lang.")) => val c=n.substring(10); pri.get(c) match { case Some(p) => p case None => sys.error("Type '"+n+"' unsupported.") }
          case n if (n.startsWith("scala.Tuple")) => sys.error("Tuples are not allowed in classes")
          case n => try { val cls=Class.forName(ctx+n.substring(n.lastIndexOf('.')+1)) // also: absolute, within.getDeclaredClasses, getDeclaringClass, getEnclosingClass, getSuperclass, ...
            TClass(n.substring(n.lastIndexOf('.')+1),cls.getDeclaredFields.map{f=>(parse(f.getType.toString),f.getName)}.toList)
          } catch { case _ => sys.error("Type '"+n+"' unuspported.") }}}
      | failure("Illegal type expression"))
    def parse(str:String):Tp = phrase(p)(new lexical.Scanner(str)) match { case Success(res, _)=>res case e=>sys.error(e.toString) }
  }

  // Tests
  case class A(a:Int, b:java.lang.Integer, c:String)
  case class B(z:Int, w:A)
  type X = (Int,Float,(Double,(Boolean,A)))
  import scala.reflect.runtime.universe.typeOf
  println(TypeParser.parse(typeOf[B].toString))
  println(TypeParser.parse(typeOf[X].toString))

/*
  //println(ctx)
  println(pp.parse("java.lang.Integer"))
  println(pp.parse("int"))
  println(pp.parse("scala.Int"))
  println(pp.parse("Int"))
*/

  /*
   def tpOf[T](a:T):String = {
    val s=a.getClass.toString;
    if (a.isInstanceOf[Product]) { val p=a.asInstanceOf[Product]; "("+(0 until p.productArity).map{x=>tpOf(p.productElement(x))}.mkString(",")+")" }
    else s match {
      case "boolean"|"byte"|"char"|"short"|"int"|"long"|"float"|"double" => s.substring(0,1).toUpperCase+s.substring(1,s.length)
      case _ if (s.startsWith("class java.lang.")) => s.substring(16) match { case "Character"=>"Char" case "Integer"=>"Int" case t=>t }
      case _ => s.substring(6) // seems that case classes extend Product, enforce that?
    }
  }
  */
}

// http://stackoverflow.com/questions/11628379/how-to-know-if-an-object-is-an-instance-of-a-typetags-type
/*
  import scala.language.implicitConversions
  import scala.reflect.ClassTag;
  import scala.reflect.runtime.universe.TypeTag;
  trait AggrF[T] { val inner:List[T]=>List[T]; val tpe:String }
  implicit def toAggrF[T](h:List[T]=>List[T])(implicit tt:TypeTag[T]):AggrF[T] = new AggrF[T] {
    val inner:List[T]=>List[T] = h
    val tpe:String = tt.tpe.toString
  }
  def printType[T](a:AggrF[T]) = println(a.tpe)
  def hh(l:List[(Int,Int)]):List[(Int,Int)] = l
  printType(hh _)
*/

/*
import java.lang.reflect.{Method,Type,ParameterizedType}
object CodeJNITest extends App {
  val j = new CodeJNI(this)
  case class Alphabet(rows:Int,cols:(Int,Int))
  import scala.reflect.runtime.universe.typeTag;
  println(typeTag[Alphabet].tpe.toString)

  def getString:List[String] = null
  def getString2(x:String):List[String] = null
  val method = this.getClass.getMethod("getString")
  //val method = this.getClass.getMethod("getString2",classOf[String]);
  method.getGenericReturnType match {
    case tp:ParameterizedType =>
      for(typeArgument <- tp.getActualTypeArguments) {
      println("typeArgClass = " + typeArgument)
    }
    case _ =>
  }
}
*/



