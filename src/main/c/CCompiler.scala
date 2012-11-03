import java.io._

trait CCompiler {
  type Input 

  val outPath:String
  val cudaPath:String
  val cudaFlags:String
  val ccFlags:String
  val ldFlags:String

  var compileCount = 0
  var dataMap = new scala.collection.mutable.HashMap[String,String]()

  // create a new file (c,cpp,cu,h)
  def add(ext:String, content:String):Unit = add(ext,content,Map())
  def add(ext:String, content:String, map:Map[String,String]) {
    val builder = new StringBuilder(content);
    def rep(o:String, n:String) = {
      val ol=o.length; val nl=n.length
      var idx=builder.indexOf(o)
      while (idx != -1) { builder.replace(idx,idx+ol,n); idx=builder.indexOf(o,idx+nl) }
    }
    map.foreach { case (o,n) => rep("{"+o+"}",n) }
    dataMap.get(ext) match {
      case Some(o) => dataMap += ((ext,o+"\n/*---EOF---*/\n"+builder.toString))
      case None => dataMap += ((ext,builder.toString))
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
  def gen(scala:String) {
    compileCount = compileCount+1
    val f = "comp"+compileCount
    dataMap.foreach { case (ext,data) => val out=new FileWriter(outPath+"/"+f+"."+ext); out.write(data); out.close }
    dataMap.foreach {
      case("c",_) =>   run("gcc "+ccFlags+" "+f+".c -c -o "+f+"_c.o")
      case("cpp",_) => run("g++ "+ccFlags+" "+f+".cpp -c -o "+f+"_cpp.o")
      case("cu",_) =>  run(cudaPath+"bin/nvcc "+cudaFlags+" "+ccFlags+" "+f+".cu -c -o "+f+"_cu.o")
    }
    val files = dataMap.map{ case(ext,_) => f+"_"+ext+".o" }.mkString(" ")
    run("g++ "+files+" "+ldFlags+" -o libComp"+compileCount+".jnilib")
    dataMap.clear
    // now load the library
    System.load(new File(outPath+"/libComp"+compileCount+".jnilib").getCanonicalPath)
  }
}

/** ------------------------ Example usage ------------------------ **/

class CudaDP[TI] {
  type Input = Array[TI];
  type Backtrack = Array[Tuple2[Int,Int]];

  //Loader.load("CudaDP")
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

// scalac -d bin CCompiler.scala && scala -cp bin TestCCompiler

object TestCCompiler extends CCompiler {
  override val outPath = "bin"
  override val cudaPath = "/usr/local/cuda/"
  override val cudaFlags = "-m64 -arch=sm_30"
  override val ccFlags = "-O2 -I/System/Library/Frameworks/JavaVM.framework/Headers"
  override val ldFlags = "-L"+cudaPath+"/lib -lcudart -shared -Wl,-rpath,/usr/local/cuda/lib"

  def main(args: Array[String]) = {
    add("c","""
#include <jni.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

// Input type
typedef struct { int _1, _2; } in_t;  // GEN: generate this
#define TI in_t

TI* in1=NULL;
TI* in2=NULL;
int in1_len=0;
int in2_len=0;

static int inArray(JNIEnv* env, jobjectArray input, TI** in) {
  // Allocate memory
  if (*in) free(*in); *in=NULL; if (input==NULL) return 0;
  jsize i,size = (*env)->GetArrayLength(env, input);
  *in=(TI*)malloc(size*sizeof(TI)); assert(*in);
  if (size==0) return 0;

    jobject elem = (*env)->GetObjectArrayElement(env, input, 0);
    jclass cls = (*env)->GetObjectClass(env, elem);

    /*
    jmethodID mid = (*env)->GetMethodID(env, cls, "productArity", "()I");
    jint arity = (*env)->CallObjectMethod(env, elem, mid);
    printf("arity = %d\n",arity);
    */

    // GEN: generate the following
    jmethodID ms[] = {
      (*env)->GetMethodID(env, cls, "_1", "()I"),
      (*env)->GetMethodID(env, cls, "_2", "()I"),
    };

  for (i=0;i<size;++i) {
    elem = (*env)->GetObjectArrayElement(env, input, i);
    TI* e = &((*in)[i]);
    e->_1 = (long) (*env)->CallObjectMethod(env, elem, ms[0]);
    e->_2 = (long) (*env)->CallObjectMethod(env, elem, ms[1]);
  }

  return size;
}

JNIEXPORT void JNICALL Java_CudaDP_inArrays(JNIEnv* env, jobject obj, jobjectArray input1, jobjectArray input2) {
  in1_len=inArray(env,input1,&in1);
  in2_len=inArray(env,input2,&in2);

  int i; printf("inLists( [");
  for (i=0;i<in1_len;++i) { TI e = in1[i]; if (i) printf(","); printf("(%d,%d)",e._1,e._2); } printf("] [");
  for (i=0;i<in2_len;++i) { TI e = in2[i]; if (i) printf(","); printf("(%d,%d)",e._1,e._2); } printf("] )\n");

  // XXX: alloc list.count * object.size ints, process
  // better: write a class that is a placeholder and can be combined into a struct
  // => use both java and C representation
}

JNIEXPORT void JNICALL Java_CudaDP_inStrings(JNIEnv* env, jobject obj, jstring string1, jstring string2) {
  const char* s1=(*env)->GetStringUTFChars(env, string1, NULL);
  const char* s2=(*env)->GetStringUTFChars(env, string2, NULL);
  printf("inStrings( \"%s\", \"%s\")\n",s1,s2);
  (*env)->ReleaseStringUTFChars(env, string1, s1);
  (*env)->ReleaseStringUTFChars(env, string2, s2);
}

JNIEXPORT void JNICALL Java_CudaDP_computeMatrix(JNIEnv* env, jobject obj) { printf("computeMatrix()\n"); }
JNIEXPORT jlong JNICALL Java_CudaDP_getScore(JNIEnv* env, jobject obj) { printf("getScore()\n"); return 0; }
JNIEXPORT jobjectArray JNICALL Java_CudaDP_getBacktrack(JNIEnv *env, jobject obj) { printf("getBacktrack()\n"); return NULL; }
JNIEXPORT void JNICALL Java_CudaDP_free(JNIEnv* env, jobject obj) { printf("free()\n"); }
""")

    add("cu","""
#include "../include/common.h" // XXX: fix path
#define SH_TRI
#define B_W 32LU
#define B_H 32LU
#define M_W 128LU
#define M_H 128LU

////////////////////////////////////////////////////////////////////////////////
// Data types
typedef struct { unsigned rows,cols; char print() { return 'X'; } } mat_t;
#define TI mat_t         // input data type
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
  in[0].rows=RNZ;
  for (unsigned i=1;i<M_H;++i) { in[i-1].cols=in[i].rows=RNZ; }
  in[M_H-1].cols=RNZ;
  return in;
}

// XXX: fix path
#include "../include/small.h"      // common functions
#include "../include/small_cpu.h"  // cpu implementation
#include "../include/small_gpu.h"  // gpu implementation

int main(int argc, char** argv) {
  g_init();
  g_solve();

  unsigned *bt,size;
  TC cost=g_backtrack(&bt,&size);
  printf("Cost = %lu\n",cost);
  printf("Backtrack = \n");
  if (size) {
    unsigned i=size;
    do { --i; printf("(%d,%d) ",bt[i*2],bt[i*2+1]); } while (i);
  }
  free(bt);
  printf("\n");

  g_free();
  return 0;
}
    """)

    gen("scala code")

    println
    println("C/CUDA implementation generated, now let's play")
    println

// XXX: fix the reflection as it is broken

/*
    // Input typing
    lazy val inTypes:List[String] = {
      import scala.reflect.runtime.universe._
      var s = typeOf[Input].toString;
      s.substring(1,s.length-1).replace("scala.","").toLowerCase.split(", ").toList
    }
    lazy val struct = "typedef struct { "+inTypes.zipWithIndex.map{case (x,i)=>x+" _"+(i+1)}.mkString("; ")+"; } in_t;"
    lazy val loader = {
      val k = Map(("boolean","Z"),("byte","B"),("char","C"),("short","S"),("int","I"),("long","J"),("float","F"),("double","D"))
      val ts = inTypes
      val ms = ts.map {x=>k(x)}.zipWithIndex.map{case(t,i) => "    (*env)->GetMethodID(env, cls, \"_"+(i+1)+"\", \"()"+t+"\")," }
      var es = ts.zipWithIndex.map{case(t,i) => "    e->_"+(i+1)+" = ("+t+") (*env)->CallObjectMethod(env, elem, ms["+i+"]);" }
      "  jmethodID ms[] = {\n"+ms.mkString("\n")+"\n  };\n\n  for (i=0;i<size;++i) {\n"+
      "    elem = (*env)->GetObjectArrayElement(env, input, i);\n"+
      "    TI* e = &((*in)[i]);\n" +  es.mkString("\n")+"\n  }\n"
    }
*/

//    Class aClass = ...//obtain class object
//    Field[] methods = aClass.getFields();

/*
    println("C struct:")
    println(struct);
    println("C loader:")
    println(loader);
    println
*/
/*
    type Input = (Int,Int,Char,Long,Short,Boolean,Byte)

    def printMethods2[T: Manifest] { // no instance
      val meths = manifest[T].erasure.getMethods
      println(meths mkString "\n")
    }
    printMethods2[Input]
*/
    
  // http://tutorials.jenkov.com/java-reflection/fields.html
  // http://lampwww.epfl.ch/~michelou/scala/scala-reflection.html

    type Input = (Int,Int)
  
    val dp = new CudaDP[Input]
    dp.inStrings("Hello world","Hello Manohar")
    dp.inArrays( Array((1,3),(3,5),(5,9),(9,2),(2,4)) ,null)
    dp.computeMatrix
    println("Score = "+dp.getScore)
    println("Backtrack = "+dp.getBacktrack)
    dp.free

    println("done");
  }
}
