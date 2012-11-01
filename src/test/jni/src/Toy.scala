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

/** Dynamic Programming solver struct for CUDA */
class CudaDP {
  type Input = Array[Product];
  type Backtrack = Array[Tuple2[Int,Int]];

  Loader.load("CudaDP")
  // Initialize the problem
  @native def inArrays(in1: Input, in2: Input):Unit;
  @native def inStrings(in1: String, in2: String):Unit;
  // Compute the matrix content
  @native def computeMatrix:Unit;
  // Get score and backtrack
  @native def getScore:Long;
  @native def getBacktrack:Backtrack;
  // Release structures
  @native def free:Unit;
  //@native override def finalize:Unit;
}

/** Demo application */
object Toy {
  def main(args: Array[String]) {
    val a = new Vec3(1,2,3)
    val b = new Vec3(3,2,1)
    val c = a.dot(b)
    System.out.println(c);

    val dp = new CudaDP
    dp.inStrings("Hello world","Hello Manohar")

    type Input = Array[Tuple2[Int,Int]]

    dp.inArrays(Array((1,3),(3,5),(5,9),(9,2),(2,4)),null)
    dp.computeMatrix
    println("Score = "+dp.getScore)
    println("Backtrack = "+dp.getBacktrack)
    dp.free
  }
}
