import java.io._

/*
import scala.tools.nsc._
import scala.tools.nsc.reporters._

trait ScalaCompiler {
  var compiler: Global = _
  var reporter: ConsoleReporter = _
  def setupCompiler = {
    val settings = new Settings()
    settings.classpath.value = this.getClass.getClassLoader match {
      case ctx: java.net.URLClassLoader => ctx.getURLs.map(_.getPath).mkString(":")
      case _ => System.getProperty("java.class.path")
    }
    settings.bootclasspath.value = Predef.getClass.getClassLoader match {
      case ctx: java.net.URLClassLoader => ctx.getURLs.map(_.getPath).mkString(":")
      case _ => System.getProperty("sun.boot.class.path")
    }
    settings.encoding.value = "UTF-8"
    settings.outdir.value = "."
    settings.extdirs.value = ""
    reporter = new ConsoleReporter(settings, null, new PrintWriter(System.out))
    compiler = new Global(settings, reporter)
  }

  def compile[T](className:String,content:String)(implicit mT: Manifest[T]): T = {
    if (this.compiler eq null) setupCompiler
    val compiler = this.compiler
    val run = new compiler.Run
    val fileSystem = new scala.tools.nsc.io.VirtualDirectory("<vfs>", None)
    compiler.settings.outputDirs.setSingleOutput(fileSystem)
    run.compileSources(List(new util.BatchSourceFile("<stdin>", content)))
    reporter.printSummary(); reporter.reset

    val parent = this.getClass.getClassLoader
    val loader = new scala.tools.nsc.interpreter.AbstractFileClassLoader(fileSystem, parent)
    val cls: Class[_] = loader.loadClass(className)
    cls.newInstance.asInstanceOf[T]
  }
}
*/

trait CCompiler {
  val outPath:String
  val cudaPath:String
  val cudaFlags:String
  val ccFlags:String
  val ldFlags:String

  var compileCount = 0
  var dataMap = new scala.collection.mutable.HashMap[String,String]()

  def replace(content:String, map:Map[String,String]) = {
    val builder = new StringBuilder(content);
    def rep(o:String, n:String) = {
      val ol=o.length; val nl=n.length
      var idx=builder.indexOf(o)
      while (idx != -1) { builder.replace(idx,idx+ol,n); idx=builder.indexOf(o,idx+nl) }
    }
    map.foreach { case (o,n) => rep("{"+o+"}",n) }
    builder.toString
  }

  // create/append to a file (c,cpp,cu,h)
  def add(ext:String, content:String):Unit = add(ext,content,Map())
  def add(ext:String, content:String, map:Map[String,String]) {
    val cnt = replace(content,map)
    dataMap.get(ext) match {
      case Some(o) => dataMap += ((ext,o+"\n/*---EOF---*/\n"+cnt))
      case None => dataMap += ((ext,cnt))
    }
  }

  // execute arbitrary command, return (out,err)
  private def run(cmd:String):(String,String) = {
    val p = Runtime.getRuntime.exec(cmd,null,new File(outPath));
    def gobble(in:InputStream) = new Runnable {
      var out = new StringBuilder
      var thr = new Thread(this); thr.start
      override def toString = { thr.join; out.toString.trim }
      override def run {
        val r = new BufferedReader(new InputStreamReader(in))
        var l = r.readLine; while(l != null) { out.append(l+"\n"); l = r.readLine }; r.close
      }
    }
    val out=gobble(p.getInputStream); val err=gobble(p.getErrorStream); p.waitFor
    val o=out.toString; val e=err.toString
    if (!o.equals("") || !e.equals("")) println("\nExec: "+cmd+"\n- Out: "+o+"\n- Err: "+e+"\n")
    (o,e)
  }

  // generate and load library
  def gen {
    compileCount = compileCount+1
    val f = "comp"+compileCount
    dataMap.foreach { case (ext,data) => val out=new FileWriter(outPath+"/"+f+"."+ext); out.write(replace(data,Map(("file",f)))); out.close }
    dataMap.foreach {
      case("c",_) =>   run("g++ "+ccFlags+" "+f+".c -c -o "+f+"_c.o") // gcc fails to link properly with nvcc object files
      case("cpp",_) => run("g++ "+ccFlags+" "+f+".cpp -c -o "+f+"_cpp.o")
      case("cu",_) =>  run(cudaPath+"/bin/nvcc "+cudaFlags+" "+ccFlags+" "+f+".cu -c -o "+f+"_cu.o")
      case _ =>
    }
    val files = dataMap.map{case(x,_)=>x}.filter(! _.startsWith("h")).map(f+"_"+_+".o").mkString(" ")
    run("g++ "+files+" "+ldFlags+" -o libComp"+compileCount+".jnilib")
    dataMap.clear
    System.load(new File(outPath+"/libComp"+compileCount+".jnilib").getCanonicalPath)
  }
}

abstract class CudaDP[TI:Manifest,TC:Manifest] extends CCompiler {
  type Input = Array[TI];
  type Backtrack = Array[(Int,Int)];

  def solve(in1: Input, in2: Input):(TC,Backtrack) = {
    init(in1,in2); solve; val res=backtrack; free; res
  }

  // Setup the input data
  @native private def init(in1: Input, in2: Input) {}
  // Compute the matrix content
  @native private def solve {} // fake implementation to allow private
  // Get score and backtrack
  @native private def backtrack:(TC,Backtrack) = null;
  // Release structures
  @native private def free {}

  // Types helpers
  private val type_jni = Map(("boolean","Z"),("byte","B"),("char","C"),("short","S"),("int","I"),("long","J"),("float","F"),("double","D"))
  private val type_c = Map(("boolean","bool"),("byte","unsigned char"),("char","char"),("short","short"),("int","int"),("long","long"),("float","float"),("double","double"))
  private def up1(s:String) = s.substring(0,1).toUpperCase+s.substring(1)

  // header and JNI implementation files
  private val tc = manifest[TC].erasure.toString
  private val ti:(String,String) = manifest[TI].erasure match {
    case cl if (type_jni.contains(cl.toString)) => val cn=cl.toString;
      ("#define TI "+type_c(cn),
       "  for (i=0;i<size;++i) (*in)[i] = (TI)env->Get"+up1(cn)+"ArrayElement(input, i);\n"
      )
    case cl => //println(manifest[T].erasure.getConstructors.mkString(", "))
      val ts = cl.getDeclaredFields.map{x=>(x.getType.toString,x.getName)}
      val ms = ts.map{ case(t,n)=> "env->GetMethodID(cls, \""+n+"\", \"()"+type_jni(t)+"\")," }
      var es = ts.zipWithIndex.map{ case((t,n),i) => "e->"+n+" = env->Call"+up1(t)+"Method(elem, ms["+i+"]);" }
      ("typedef struct { "+ts.map{case (t,n)=>type_c(t)+" "+n+";"}.mkString(" ")+" } in_t;\n#define TI in_t",
       "  jmethodID ms[] = {\n    "+ms.mkString("\n    ")+"\n  };\n\n  for (i=0;i<size;++i) {\n"+
       "    elem = env->GetObjectArrayElement(input, i);\n    TI* e = &((*in)[i]);\n    "+es.mkString("\n    ")+"\n  }\n"
      )
  }
  val h_file = "#ifndef __CudaDP_H__\n#define __CudaDP_H__\n#ifdef __cplusplus\nextern \"C\" {\n#endif\n\n"+
      (ti._1)+"\n#define TC "+type_c(tc)+"\n#define TB short\nvoid g_init(TI* in0, TI* in1);\nvoid g_free();\n"+
      "void g_solve();\nTC g_backtrack(unsigned** bt, unsigned* size);\n\n#ifdef __cplusplus\n}\n#endif\n#endif"
  val c_file = replace("""
#include <jni.h>
#include <stdio.h>
#include <stdlib.h>
#include "{file}.h"

static unsigned inArray(JNIEnv* env, jobjectArray input, TI** in) {
  // Allocate memory
  if (*in) free(*in); *in=NULL; if (input==NULL) return 0;
  jsize i,size = env->GetArrayLength(input);
  *in=(TI*)malloc(size*sizeof(TI)); if (!*in) { fprintf(stderr,"Not enough memory.\n"); exit(1); }
  if (size==0) return 0;

  jobject elem = env->GetObjectArrayElement(input, 0);
  jclass cls = env->GetObjectClass(elem);
  
  {TI_Load}
  return size;
}

#ifdef __cplusplus
extern "C" {
#endif
JNIEXPORT void JNICALL Java_CudaDP_init(JNIEnv *, jobject, jobjectArray, jobjectArray);
JNIEXPORT void JNICALL Java_CudaDP_solve(JNIEnv *, jobject) { g_solve(); }
JNIEXPORT jobject JNICALL Java_CudaDP_backtrack(JNIEnv *, jobject);
JNIEXPORT void JNICALL Java_CudaDP_free(JNIEnv *, jobject) { g_free(); }
#ifdef __cplusplus
}
#endif

JNIEXPORT void JNICALL Java_CudaDP_init(JNIEnv* env, jobject obj, jobjectArray input1, jobjectArray input2) {
  TI *in1=NULL,*in2=NULL; inArray(env,input1,&in1); inArray(env,input2,&in2);
  g_init(in1,in2); free(in1); free(in2);
}

JNIEXPORT jobject JNICALL Java_CudaDP_backtrack(JNIEnv *env, jobject obj) {
  unsigned *bt,size,i;
  TC cost=g_backtrack(&bt,&size);

  jclass cls = env->FindClass("scala/Tuple2");
  jmethodID ctr = env->GetMethodID(cls, "<init>", "(Ljava/lang/Object;Ljava/lang/Object;)V");
  jclass cls_i = env->FindClass("java/lang/Integer");
  jmethodID ctr_i = env->GetMethodID(cls_i, "<init>", "(I)V");
  jclass cls_c = env->FindClass("{TC_Class}");
  jmethodID ctr_c = env->GetMethodID(cls_c, "<init>", "({TC_Jni})V");
  jobjectArray backtrack = env->NewObjectArray(size, cls, NULL);
  for (i=0; i<size; ++i) {
    jobject e1 = env->NewObject(cls_i, ctr_i, bt[i*2]);
    jobject e2 = env->NewObject(cls_i, ctr_i, bt[i*2+1]);
    jobject tuple = env->NewObject(cls, ctr, e1, e2);
    env->SetObjectArrayElement(backtrack, size-1-i, tuple);
  }
  free(bt);
  jobject score = env->NewObject(cls_c, ctr_c, cost);
  return env->NewObject(cls, ctr, score, backtrack);
}
""",Map(("TI_Load",ti._2),("TC_Class","java/lang/"+up1(tc)),("TC_Jni",type_jni(tc))))
}

abstract class CudaDPStr[TC:Manifest] extends CudaDP[Char,TC] {
  def solve(in1: String, in2: String):(TC,Backtrack) = solve(in1.toArray, if(in2!=null) in2.toArray else null)
}

/** ------------------------ Example usage ------------------------ **/

object TestCCompiler {

  // This is the input of our alorithm
  case class Mat(rows:Int, cols:Int)

  // This is our algorithm
  val dp = new CudaDP[Mat,Long] with CCompiler {
    override val outPath = "bin"
    override val cudaPath = "/usr/local/cuda"
    override val cudaFlags = "-m64 -arch=sm_30"
    override val ccFlags = "-O2 -I/System/Library/Frameworks/JavaVM.framework/Headers"
    override val ldFlags = "-L"+cudaPath+"/lib -lcudart -shared -Wl,-rpath,"+cudaPath+"/lib"

    override def solve(in1:Input,in2:Input) = {
      add("h",h_file)
      add("c",c_file)
      add("cu","""
#include "{file}.h"
#include "{inc}/common.h"
#define SH_TRI
#define B_W 32LU
#define B_H 32LU
#define M_W {M_W}LU
#define M_H {M_H}LU

// Matrix multiplication parenthesizing (triangular matrix)
//   M[i,j]= min {i<=k<j} M[i,k] + M [k+1,j] + r_i * c_k * c_j

#define INIT(i,j) (j<=i)
#define p_kernel \
  _infinity \
  _min_loop(k,i,j,  _cost(i,k) + _cost(k+1,j) + _in(i).rows * _in(k).cols * _in(j).cols, k )

#include "{inc}/small.h" 
#include "{inc}/small_gpu.h"
""",Map(("inc","../include"),("M_H",""+in1.size),("M_W",""+(if(in2==null)in1 else in2).size)))

      gen // XXX: can be called only once for the moment
      super.solve(in1,in2)
    }
  }

  def main(args: Array[String]) = {
    // http://tutorials.jenkov.com/java-reflection/fields.html
    // http://lampwww.epfl.ch/~michelou/scala/scala-reflection.html

    // This is an example usage
    val (score,bt) = dp.solve(Array(Mat(1,3),Mat(3,5),Mat(5,9),Mat(9,2),Mat(2,4)) ,null)

    println("Score = "+score)
    println("Backtrack =\n"+bt.map{case (i,j)=>"("+i+","+j+")"}.mkString(" "))

    // XXX: error, there is no recompilation/reload of the libraries
    /*
    val (score2,bt2) = dp.solve(Array(Mat(1,3),Mat(3,1)) ,null)
    println("Score = "+score2)
    println("Backtrack =\n"+bt2.map{case (i,j)=>"("+i+","+j+")"}.mkString(" "))
    */


    println("done");
  }
}
