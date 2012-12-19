package v4

import scala.reflect.runtime.universe.TypeTag

class CodeJNI(head:CodeHeader) {
  val j_types = Map(("Boolean","Z"),("Byte","B"),("Char","C"),("Short","S"),("Int","I"),("Long","J"),
                    ("Float","F"),("Double","D"),("String","Ljava/lang/String;"))

  def wrapper[TI,TC](cat:Int)(implicit ti:TypeTag[TI], tc:TypeTag[TC]) {
    head.add("#define TI "+head.getType(ti.tpe.toString))
    head.add("#define TC "+head.getType(tc.tpe.toString))
    head.add("typedef struct { short i,j,rule; short pos[3]; } trace_t;")
    head.add("const int trace_len[4] = {3,1,1,0};")
    println(head.flush)

    // jobject elem = env->GetObjectArrayElement(input, 0);
    // jclass cls = env->GetObjectClass(elem);
    // env->GetMethodID(cls, "+n+", \"()"+type_jni(t)+"\")

    // parser for tuples
    // parser for case classes
    // parser for primary types

    // we need two parsers for types:
    // 1. extract the method calls to retrieve desired data
    // 2. apply the method and push data back in appropriate structure

    // call execute
    // call backtrack

    // for every item, push back (i,j),(rule,List[indices])
    // then construct a pair with answer

    //type Subword = (Int, Int)
    //type Backtrack = (Int,List[Int]) // (subrule_id, indices)
    //result is of the form (Answer,List[(Subword,Backtrack)])


  // XXX: idea: use dumb variable to do traversal of the parsers to obtain type ?
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
  val type_jni = Map(("boolean","Z"),("byte","B"),("char","C"),("short","S"),("int","I"),("long","J"),("float","F"),("double","D"))
  val type_c = Map(("boolean","bool"),("byte","unsigned char"),("char","char"),("short","short"),("int","int"),("long","long"),("float","float"),("double","double"))
  def up1(s:String) = s.substring(0,1).toUpperCase+s.substring(1)

    val ti2:(String,String) = ti.runtimeClass match {
      case cl if (type_jni.contains(cl.toString)) => val cn=cl.toString;
        ("#define TI "+type_c(cn),"  for (i=0;i<size;++i) (*in)[i] = (TI)env->Get"+up1(cn)+"ArrayElement(input, i);\n")
      case cl =>
        //println(manifest[T].erasure.getConstructors.mkString(", "))
        val ts = cl.getDeclaredFields.map{x=>(x.getType.toString,x.getName)}
        val ms = ts.map{ case(t,n)=> "env->GetMethodID(cls, \""+n+"\", \"()"+type_jni(t)+"\")," }
        var es = ts.zipWithIndex.map{ case((t,n),i) => "e->"+n+" = env->Call"+up1(t)+"Method(elem, ms["+i+"]);" }
        ("typedef struct { "+ts.map{case (t,n)=>type_c(t)+" "+n+";"}.mkString(" ")+" } in_t;\n#define TI in_t",
         "  jmethodID ms[] = {\n    "+ms.mkString("\n    ")+"\n  };\n\n  for (i=0;i<size;++i) {\n"+
         "    elem = env->GetObjectArrayElement(input, i);\n    TI* e = &((*in)[i]);\n    "+es.mkString("\n    ")+"\n  }\n")
    }

println("""
static unsigned inArray(JNIEnv* env, jobjectArray input, TI** in) {
  // Allocate memory
  if (*in) free(*in); *in=NULL; if (input==NULL) return 0;
  jsize i,size = env->GetArrayLength(input); if (size==0) return 0;
  *in=(TI*)malloc(size*sizeof(TI)); if (!*in) { fprintf(stderr,"Not enough memory.\n"); exit(1); }
  jobject elem = env->GetObjectArrayElement(input, 0);
  jclass cls = env->GetObjectClass(elem);
  {TI_Load}
  return size;
}
""")
*/
  }
}


import java.lang.reflect.{Method,Type,ParameterizedType}

object CodeJNITest extends App {
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




/*
  Method method = MyClass.class.getMethod("getStringList", null);

Type returnType = method.getGenericReturnType();

if(returnType instanceof ParameterizedType){
    ParameterizedType type = (ParameterizedType) returnType;
    Type[] typeArguments = type.getActualTypeArguments();
    for(Type typeArgument : typeArguments){
        Class typeArgClass = (Class) typeArgument;
        System.out.println("typeArgClass = " + typeArgClass);
    }
}
*/

/*
  val j = new CodeJNI(new CodeHeader(this))
  case class Alphabet(rows:Int,cols:(Int,Int))
  //type Alphabet = (Int,Int)
  type Answer = (Int,Int,Int)

  //j.wrapper[Alphabet,Answer](3);
  // http://tutorials.jenkov.com/java-reflection/generics.html#general
  import scala.reflect.runtime.universe._
  println( x.getClass.getDeclaredFields().map{x=>x.toString}.mkString(", ")  );
*/
}

/*
void jni_input(JNIEnv* env, jobjectArray input, TI** in) {
  if (*in) free(*in); *in=NULL; if (input==NULL) return 0;
  // Allocate memory
  jsize i,size = env->GetArrayLength(input); if (size==0) return 0;
  *in=(TI*)malloc(size*sizeof(TI)); if (!*in) { fprintf(stderr,"Not enough memory.\n"); exit(1); }
  jobject elem = env->GetObjectArrayElement(input, 0);
  jclass cls = env->GetObjectClass(elem);

  // if primitive
    for (i=0;i<size;++i) (*in)[i] = (TI)env->Get"+up1(cn)+"ArrayElement(input, i);

   // if composite type
        val ts = cl.getDeclaredFields.map{x=>(x.getType.toString,x.getName)}
        val ms = ts.map{ case(t,n)=> "env->GetMethodID(cls, \""+n+"\", \"()"+type_jni(t)+"\")," }
        var es = ts.zipWithIndex.map{ case((t,n),i) => "e->"+n+" = env->Call"+up1(t)+"Method(elem, ms["+i+"]);" }
    "  jmethodID ms[] = {\n    "+ms.mkString("\n    ")+"\n  };\n\n  for (i=0;i<size;++i) {\n"+
         "    elem = env->GetObjectArrayElement(input, i);\n    TI* e = &((*in)[i]);\n    "+es.mkString("\n    ")+"\n  }\n")
    }


  return size;

}

void jni_backtrack(trace_t* trace, size_t size) {

}



static unsigned inArray(JNIEnv* env, jobjectArray input, TI** in) {
}

JNIEXPORT jobject JNICALL Java_{className}_apply(JNIEnv* env, jobject obj, jobjectArray input1, jobjectArray input2) {
  // 1. Initialize
  TI *in1=NULL,*in2=NULL; inArray(env,input1,&in1); inArray(env,input2,&in2);
  g_init(in1,in2);
  free(in1); free(in2);
  // 2. Solve
  g_solve();
  // 3. Backtrack
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
  jobject result = env->NewObject(cls, ctr, score, backtrack);
  // 4. Cleanup
  g_free();
  return result;
}
*/
