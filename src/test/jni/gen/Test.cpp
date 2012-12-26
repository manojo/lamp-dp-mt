#include <jni.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// FLAGS:= -shared -I/System/Library/Frameworks/JavaVM.framework/Headers
// OUT:= Test.jnilib

#ifndef _Included_Test__
#define _Included_Test__
#ifdef __cplusplus
extern "C" {
#endif
JNIEXPORT jobject JNICALL Java_Test_00024_foo (JNIEnv *, jobject, jobjectArray);
#ifdef __cplusplus
}
#endif

// Generated code
// -----------------------------------------------------------------------------

typedef struct __alphabet_t alphabet_t;
typedef struct __t3iii t3iii;
struct __alphabet_t { int rows; int cols; };
struct __t3iii { int _1; int _2; int _3; };

#define TI alphabet_t
#define TC t3iii
typedef struct { short i,j,rule; short pos[3]; } trace_t;
const int trace_len[4] = {3,1,1,0};

static unsigned jni_read(JNIEnv* env, jobjectArray input, TI** in) {
  if (*in) free(*in); *in=NULL; if (input==NULL) return 0;
  jsize i,size = env->GetArrayLength(input); if (size==0) return 0;
  *in=(TI*)malloc(size*sizeof(TI)); if (!*in) { fprintf(stderr,"Not enough memory.\n"); exit(1); }
  // Loading method handles
  jobject el = env->GetObjectArrayElement(input, 0);
  jclass cls = env->GetObjectClass(el);
  jmethodID mrows = env->GetMethodID(cls, "rows", "()I");
  jmethodID mcols = env->GetMethodID(cls, "cols", "()I");
  // Loading data elements
  for (i=0;i<size;++i) {
    el = env->GetObjectArrayElement(input, i);
    (*in)[i].rows = (int)env->CallIntMethod(el, mrows);
    (*in)[i].cols = (int)env->CallIntMethod(el, mcols);
  }
  return size;
}

static jobject jni_write(JNIEnv* env, TC score, trace_t* trace, size_t size) {
  // Result object
  jclass cls_1 = env->FindClass("java/lang/Integer");
  jmethodID ctr_1 = env->GetMethodID(cls_1,"<init>","(I)V");
  jobject res_1 = env->NewObject(cls_1,ctr_1,score._1);
  jclass cls_2 = env->FindClass("java/lang/Integer");
  jmethodID ctr_2 = env->GetMethodID(cls_2,"<init>","(I)V");
  jobject res_2 = env->NewObject(cls_2,ctr_2,score._2);
  jclass cls_3 = env->FindClass("java/lang/Integer");
  jmethodID ctr_3 = env->GetMethodID(cls_3,"<init>","(I)V");
  jobject res_3 = env->NewObject(cls_3,ctr_3,score._3);
  jclass cls = env->FindClass("scala/Tuple3");
  jmethodID ctr = env->GetMethodID(cls,"<init>","(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V");
  jobject res = env->NewObject(cls,ctr,res_1,res_2,res_3);
  // Backtrack trace
  jclass cl2 = env->FindClass("scala/Tuple2");
  jmethodID ct2 = env->GetMethodID(cl2, "<init>", "(Ljava/lang/Object;Ljava/lang/Object;)V");
  #define J_PAIR(A,B) env->NewObject(cl2, ct2, A, B)
  jclass cli = env->FindClass("java/lang/Integer");
  jmethodID cti = env->GetMethodID(cli, "<init>", "(I)V");
  #define J_INT(X) env->NewObject(cli, cti, X)
  jclass cln = env->FindClass("scala/collection/immutable/List");
  jmethodID ctn = env->GetStaticMethodID(cln, "empty", "()Lscala/collection/immutable/List;");
  const jobject nil = env->CallStaticObjectMethod(cln, ctn);
  jclass clc = env->FindClass("scala/collection/immutable/$colon$colon");
  jmethodID ctc = env->GetMethodID(clc, "<init>", "(Ljava/lang/Object;Lscala/collection/immutable/List;)V");
  #define J_CONS(H,T) env->NewObject(clc, ctc, H, T)
  jobject jtrace = nil;
  for (int i=0; i<size; ++i) {
    jobject ixs = nil; trace_t* tr=&trace[i];
    for (int l=trace_len[tr->rule]; l>0; --l) ixs = J_CONS(J_INT(tr->pos[l-1]), ixs);
    jobject el = J_PAIR( J_PAIR(J_INT(tr->i),J_INT(tr->j)) , J_PAIR(J_INT(tr->rule),ixs) );
    jtrace = J_CONS(el, jtrace);
  }
  return J_PAIR(res,jtrace);
}

// -----------------------------------------------------------------------------
// End of generated code

jobject Java_Test_00024_foo (JNIEnv * env, jobject ooo, jobjectArray input) {
	alphabet_t* in=NULL;
	int size = jni_read(env, input, &in);
	for (int i=0;i<size;++i) {
		printf("In %-2d : %4d %4d\n",i,in[i].rows,in[i].cols);
	}
	free(in);
	#define N 10
	trace_t* t = (trace_t*)malloc(N*sizeof(trace_t));
	for (int i=0;i<N;++i) {
		t[i].i=i; t[i].j=2*i; t[i].rule=i%4;
		for (int j=0;j<3;++j) t[i].pos[j]=i;
	}
	t3iii sc={1,2,3};
	jobject obj = jni_write(env,sc,t,N);
	free(t);
	return obj;
}
#endif
