/** A library loader, library must be at the root of the class path */
object Loader {
  val libs = new scala.collection.mutable.HashSet[String]()
  val paths = (this.getClass.getClassLoader match {
    case ctx: java.net.URLClassLoader => ctx.getURLs.map(_.getPath)
    case _ => System.getProperty("java.class.path").split(":")
  }).reverse.toList

  def load(lib:String) {
    def ld(pl:List[String]):Unit = pl match {
      case p::ps => val f = new java.io.File(p+"/lib"+lib+".jnilib")
        if (f.exists) System.load(f.getCanonicalPath()) else ld(ps);
      case Nil => throw new Exception("JNI Library "+lib+" not found");
    }
    if (! libs.contains(lib)) { ld(paths); libs+=lib; }
  }
}

/** A simple class with a native method */
class Vec3(val x:Int, val y:Int, val z:Int) {
  Loader.load("Vec3")

  def +:(v: Vec3) = new Vec3(x+v.x,y+v.y,z+v.z)
  def -:(v: Vec3) = new Vec3(x-v.x,y-v.y,z-v.z)
  override def toString() = "("+x+","+y+","+z+")"
  @native def dot(v: Vec3):Vec3; //= new Vec3(x*v.x,y*v.y,z*v.z)
}

/** Demo application */
object Toy {
  def main(args: Array[String]) {
    val a = new Vec3(1,2,3)
    val b = new Vec3(3,2,1)
    val c = a.dot(b)
    System.out.println(c);
  }
}
