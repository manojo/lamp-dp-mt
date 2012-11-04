import java.io._

trait CCompiler {
  val outPath:String
  val cudaPath:String
  val cudaFlags:String
  val ccFlags:String
  val ldFlags:String

  var compileCount = 0
  var dataMap = new scala.collection.mutable.HashMap[String,String]()

  private def replace(content:String, map:Map[String,String]) = {
    val builder = new StringBuilder(content);
    def rep(o:String, n:String) = {
      val ol=o.length; val nl=n.length
      var idx=builder.indexOf(o)
      while (idx != -1) { builder.replace(idx,idx+ol,n); idx=builder.indexOf(o,idx+nl) }
    }
    map.foreach { case (o,n) => rep("{"+o+"}",n) }
    builder.toString
  }

  // create a new file (c,cpp,cu,h)
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

  // generate and instanciate
  def gen {
    compileCount = compileCount+1
    val f = "comp"+compileCount
    dataMap.foreach { case (ext,data) => val out=new FileWriter(outPath+"/"+f+"."+ext); out.write(replace(data,Map(("file",f)))); out.close }
    dataMap.foreach {
      case("c",_) =>   run("g++ "+ccFlags+" "+f+".c -c -o "+f+"_c.o") // gcc fails at linking properly with nvcc files
      case("cpp",_) => run("g++ "+ccFlags+" "+f+".cpp -c -o "+f+"_cpp.o")
      case("cu",_) =>  run(cudaPath+"/bin/nvcc "+cudaFlags+" "+ccFlags+" "+f+".cu -c -o "+f+"_cu.o")
      case _ =>
    }
    val files = dataMap.map{case(x,_)=>x}.filter(! _.startsWith("h")).map(f+"_"+_+".o").mkString(" ")
    run("g++ "+files+" "+ldFlags+" -o libComp"+compileCount+".jnilib")
    dataMap.clear
    // now load the library
    System.load(new File(outPath+"/libComp"+compileCount+".jnilib").getCanonicalPath)
  }
}

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


/** ------------------------ Example usage ------------------------ **/

class CudaDP[TI:Manifest] {
  type Input = Array[TI];
  type Backtrack = Array[(Int,Int)];

  @native def inArrays(in1: Input, in2: Input):Unit;
  @native def inStrings(in1: String, in2: String):Unit;
  // Compute the matrix content
  //@native def computeMatrix:Unit;
  @native def computeMatrix:Unit;
  // Get score and backtrack
  @native def getScore:Long;
  @native def getBacktrack:Backtrack;
  // Release structures
  @native def free:Unit;

  val inputHelpers:(String,String) = manifest[TI].erasure match {
    case cl if (cl.toString.equals("char")) =>
        (
          "#define TI char",
          "  for (i=0;i<size;++i) (*in)[i] = (char)env->GetObjectArrayElement(input, i);\n"
        )
    case cl =>
        //println(manifest[T].erasure.getConstructors.mkString(", "))
        //println(manifest[T].erasure.getDeclaredFields.map{x=>x.getType+" "+x.getName}.mkString("\n"))
        val ts = cl.getDeclaredFields.map{x=>(x.getType.toString,x.getName)}
        val k = Map(("boolean","Z"),("byte","B"),("char","C"),("short","S"),("int","I"),("long","J"),("float","F"),("double","D"))
        val ms = ts.map {case(t,n)=> "    env->GetMethodID(cls, \""+n+"\", \"()"+k(t)+"\")," }
        var es = ts.zipWithIndex.map{ case((t,n),i) => "    e->"+n+" = ("+t+")(long) env->CallObjectMethod(elem, ms["+i+"]);" }
        (
          "typedef struct { "+ts.map{case (t,n)=>t+" "+n+";"}.mkString(" ")+" } in_t;\n#define TI in_t",
          "  jmethodID ms[] = {\n"+ms.mkString("\n")+"\n  };\n\n  for (i=0;i<size;++i) {\n"+
          "    elem = env->GetObjectArrayElement(input, i);\n"+
          "    TI* e = &((*in)[i]);\n" +  es.mkString("\n")+"\n  }\n"
        )
  }
}

// scalac -d bin CCompiler.scala && scala -cp bin TestCCompiler


case class Mat(rows:Int, cols:Int)

object TestCCompiler extends CudaDP[Mat] with CCompiler {
  override val outPath = "bin"
  override val cudaPath = "/usr/local/cuda"
  override val cudaFlags = "-m64 -arch=sm_30"
  override val ccFlags = "-O2 -I/System/Library/Frameworks/JavaVM.framework/Headers"
  override val ldFlags = "-L"+cudaPath+"/lib -lcudart -shared -Wl,-rpath,"+cudaPath+"/lib"

  def main(args: Array[String]) = {
    // http://tutorials.jenkov.com/java-reflection/fields.html
    // http://lampwww.epfl.ch/~michelou/scala/scala-reflection.html

    add("h","#ifndef __CudaDP_H__\n#define __CudaDP_H__\n#ifdef __cplusplus\nextern \"C\" {\n#endif\n\n"+
        (inputHelpers._1)+" // input type\n#define TC unsigned long // cost type\n#define TB short // backtrack type\n"+
        "void g_init();\nvoid g_free();\nvoid g_solve();\nTC g_backtrack(unsigned** bt, unsigned* size);\n"+
        "\n#ifdef __cplusplus\n}\n#endif\n#endif")

    add("c","""
#include <jni.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include "{file}.h"

// Input type
// typedef struct { int _1, _2; } in_t;  // GEN: generate this
// #define TI in_t

TI* in1=NULL;
TI* in2=NULL;
int in1_len=0;
int in2_len=0;

static int inArray(JNIEnv* env, jobjectArray input, TI** in) {
  // Allocate memory
  if (*in) free(*in); *in=NULL; if (input==NULL) return 0;
  jsize i,size = env->GetArrayLength(input);
  *in=(TI*)malloc(size*sizeof(TI)); assert(*in);
  if (size==0) return 0;

  jobject elem = env->GetObjectArrayElement(input, 0);
  jclass cls = env->GetObjectClass(elem);
  
  """+inputHelpers._2+"""
  return size;
}

#ifdef __cplusplus
extern "C" {
#endif
JNIEXPORT void JNICALL Java_CudaDP_inArrays(JNIEnv *, jobject, jobjectArray, jobjectArray);
JNIEXPORT void JNICALL Java_CudaDP_inStrings(JNIEnv *, jobject, jstring, jstring);
JNIEXPORT void JNICALL Java_CudaDP_computeMatrix(JNIEnv *, jobject);
JNIEXPORT jlong JNICALL Java_CudaDP_getScore(JNIEnv *, jobject);
JNIEXPORT jobjectArray JNICALL Java_CudaDP_getBacktrack(JNIEnv *, jobject);
JNIEXPORT void JNICALL Java_CudaDP_free(JNIEnv *, jobject);
#ifdef __cplusplus
}
#endif

JNIEXPORT void JNICALL Java_CudaDP_inArrays(JNIEnv* env, jobject obj, jobjectArray input1, jobjectArray input2) {
  in1_len=inArray(env,input1,&in1);
  in2_len=inArray(env,input2,&in2);

  int i; printf("inLists( [");
  for (i=0;i<in1_len;++i) { TI e = in1[i]; if (i) printf(","); printf("(%d,%d)",e.rows,e.cols); } printf("] [");
  for (i=0;i<in2_len;++i) { TI e = in2[i]; if (i) printf(","); printf("(%d,%d)",e.rows,e.cols); } printf("] )\n");

  // XXX: alloc list.count * object.size ints, process
  // better: write a class that is a placeholder and can be combined into a struct
}

JNIEXPORT void JNICALL Java_CudaDP_inStrings(JNIEnv* env, jobject obj, jstring string1, jstring string2) {
  const char* s1=env->GetStringUTFChars(string1, NULL);
  const char* s2=env->GetStringUTFChars(string2, NULL);
  printf("inStrings( \"%s\", \"%s\")\n",s1,s2);
  env->ReleaseStringUTFChars(string1, s1);
  env->ReleaseStringUTFChars(string2, s2);
}

extern void g_init();
extern void g_solve();
extern void g_free();

JNIEXPORT void JNICALL Java_CudaDP_computeMatrix(JNIEnv* env, jobject obj) { g_init(); g_solve(); g_free(); printf("computeMatrix()\n"); }
JNIEXPORT jlong JNICALL Java_CudaDP_getScore(JNIEnv* env, jobject obj) { printf("getScore()\n"); return 0; }
JNIEXPORT jobjectArray JNICALL Java_CudaDP_getBacktrack(JNIEnv *env, jobject obj) { printf("getBacktrack()\n"); return NULL; }
JNIEXPORT void JNICALL Java_CudaDP_free(JNIEnv* env, jobject obj) { printf("free()\n"); }
""")

    add("cu","""
#include "{file}.h"
#include "../include/common.h" // XXX: fix path
#define SH_TRI
#define B_W 32LU
#define B_H 32LU
#define M_W 128LU
#define M_H 128LU

////////////////////////////////////////////////////////////////////////////////
// Data types
#define TI_CHR(X) ('0'+(X).rows) // conversion to char (debug)
#define TC unsigned long // cost type
#define TB short         // backtrack type (2 bits for direction + 14 for value)

// Initialization
#define INIT(i,j) (j<=i) // matrix initialization at [stop]

// Matrix multiplication parenthesizing (triangular matrix)
//
//   M[i,j]= min {i<=k<j} M[i,k] + M [k+1,j] + r_i * c_k * c_j
//
#define p_kernel \
  _infinity \
  _min_loop(k,i,j,  _cost(i,k) + _cost(k+1,j) + _in(i).rows * _in(k).cols * _in(j).cols, k )

// Once generated: execute
// nvcc -arch=sm_21 -O2 <FILE>.cu -DSH_RECT -o <OUT>
// optirun <OUT>
////////////////////////////////////////////////////////////////////////////////

// Input
TI* p_input() {
  static unsigned s=time(NULL); mseed(s); // keep consistent
  TI* in = (TI*)malloc(M_H*sizeof(TI));
  #define RNZ ({ unsigned x; do { x=mrand()%10; } while (!x); x; })
  in[0].rows=RNZ; for (unsigned i=1;i<M_H;++i) { in[i-1].cols=in[i].rows=RNZ; }
  in[M_H-1].cols=RNZ; return in;
}

// XXX: fix path
#include "../include/small.h"      // common functions
#include "../include/small_cpu.h"  // cpu implementation
#include "../include/small_gpu.h"  // gpu implementation

int main(int argc, char** argv) {
  g_init(); g_solve();
  unsigned *bt,size;
  TC cost=g_backtrack(&bt,&size);
  printf("Cost = %lu\n",cost);
  printf("Backtrack = \n");
  if (size) {
    unsigned i=size;
    do { --i; printf("(%d,%d) ",bt[i*2],bt[i*2+1]); } while (i);
  }
  free(bt); printf("\n");
  g_free(); return 0;
}
    """)

    gen

    println
    println("C/CUDA implementation generated, now let's play")
    println

//    type Input = (Int,Int)
 
//    val dp = new CudaDP[Input]
    inStrings("Hello world","Hello Manohar")
    inArrays(Array(Mat(1,3),Mat(3,5),Mat(5,9),Mat(9,2),Mat(2,4)) ,null)
    computeMatrix
    println("Score = "+getScore)
    println("Backtrack = "+getBacktrack)
    free

    println("done");
  }
}
