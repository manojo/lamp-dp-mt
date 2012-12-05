package rnalib

// Library loader, libraries must be at the root of the class path
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

object RNALib {
  Loader.load("RNA")

  @native def setParams(file:String):Unit
  @native def setSequence(seq:String):Unit
  @native def clear:Unit

  @native def termau_energy(i:Int, j:Int):Int
  @native def hl_energy(i:Int, j:Int):Int
  @native def hl_energy_stem(i:Int, j:Int):Int
  @native def il_energy(i:Int, j:Int, k:Int, l:Int):Int
  @native def bl_energy(bl:Int, i:Int, j:Int, br:Int, Xright:Int):Int
  @native def br_energy(bl:Int, i:Int, j:Int, br:Int, Xleft:Int):Int
  @native def sr_energy(i:Int, j:Int):Int
  @native def sr_pk_energy(a:Byte, b:Byte, c:Byte, d:Byte):Int
  @native def dl_energy(i:Int, j:Int):Int
  @native def dr_energy(i:Int, j:Int, n:Int):Int
  @native def dli_energy(i:Int, j:Int):Int
  @native def dri_energy(i:Int, j:Int):Int
  @native def ext_mismatch_energy(i:Int, j:Int, n:Int):Int
  @native def ml_mismatch_energy(i:Int, j:Int):Int
  @native def ml_energy:Int
  @native def ul_energy:Int
  @native def sbase_energy:Int
  @native def ss_energy(i:Int, j:Int):Int

  // Note that 'Byte' is mapping 'base_t'

  // for MacroState partition function
  // @native def dl_dangle_dg(dangle:Byte, i:Byte, j:Byte):Int
  // @native def dr_dangle_dg(i:Byte, j:Byte, dangle:Byte):Int

  // @native def mk_pf(x:Double):Double
  // @native def scale(x:Int):Double;
  // @native iupac_match(base:Byte, iupac_base:Byte):Boolean
}

/*
object Test extends App {
  RNALib.setParams("vienna/rna_turner2004.par")
  RNALib.setSequence("acguacguacgu")
  println(RNALib.sr_energy(0,5));
  println(RNALib.il_energy(0,2,4,6));
  RNALib.clear
}
*/
