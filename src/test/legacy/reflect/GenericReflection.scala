import java.lang.reflect.{Method,Type,ParameterizedType};

// http://tutorials.jenkov.com/java-reflection/generics.html#general

object Test extends App {
  def getString:List[String] = null
  def getString2(x:String):List[String] = null
  val method = this.getClass.getMethod("getString");
  //val method = this.getClass.getMethod("getString2",classOf[String]);
  method.getGenericReturnType match {
    case tp:ParameterizedType =>
      for(typeArgument <- tp.getActualTypeArguments) {
      println("typeArgClass = " + typeArgument);
    }
    case _ =>
  }
}
