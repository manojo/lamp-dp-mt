#include <jni.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include "comp1.h"
#ifdef __cplusplus
extern "C" {
#endif
JNIEXPORT jobject JNICALL Java_CompWrapper1_parse(JNIEnv* env, jobject obj, jcharArray input1);
JNIEXPORT jobject JNICALL Java_CompWrapper1_backtrack(JNIEnv* env, jobject obj, jcharArray input1);
#ifdef __cplusplus
}
#endif

static unsigned jni_read(JNIEnv* env, jcharArray input, input_t** in) {
  if (*in) free(*in); *in=NULL; if (input==NULL) return 0;
  jsize i,size = env->GetArrayLength(input); if (size==0) return 0;
  *in=(input_t*)malloc(size*sizeof(input_t)); if (!*in) { fprintf(stderr,"Not enough memory.\n"); exit(1); }
  jboolean isCopy=false; jchar* jarray = env->GetCharArrayElements(input,&isCopy);
  for (i=0;i<size;++i) (*in)[i] = (char)jarray[i];
  env->ReleaseCharArrayElements(input,jarray,0);
  return size;
}

static jobject jni_write(JNIEnv* env, int score, trace_t* trace, size_t size) {
  // Result object
  jclass cls = env->FindClass("java/lang/Integer");
  jmethodID ctr = env->GetMethodID(cls,"<init>","(I)V");
  jobject res = env->NewObject(cls,ctr,score);
  // Backtrack trace
  if (trace==NULL) return res;
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

jobject Java_CompWrapper1_parse(JNIEnv* env, jobject obj, jcharArray input1) {
  struct timeval ts,te; double delta;
  gettimeofday(&ts,NULL);
  input_t *in1=NULL; jni_read(env,input1,&in1);
  g_init(in1,NULL);  gettimeofday(&te,NULL);
  delta=(te.tv_sec-ts.tv_sec)*1000.0+(te.tv_usec-ts.tv_usec)/1000.0;
  printf("%-20s : %.3f sec\n","- JNI read",delta/1000.0);
 free(in1);
  gettimeofday(&ts,NULL);
  g_solve();
  gettimeofday(&te,NULL);
  delta=(te.tv_sec-ts.tv_sec)*1000.0+(te.tv_usec-ts.tv_usec)/1000.0;
  printf("%-20s : %.3f sec\n","- CUDA compute",delta/1000.0);
  int score=g_backtrack(NULL,NULL);
  jobject result = jni_write(env, score, NULL, 0);
  fflush(stdout); fflush(stderr);
  g_free(); return result;
}

jobject Java_CompWrapper1_backtrack(JNIEnv* env, jobject obj, jcharArray input1) {
  struct timeval ts,te; double delta;
  gettimeofday(&ts,NULL);
  input_t *in1=NULL; jni_read(env,input1,&in1);
  g_init(in1,NULL);  gettimeofday(&te,NULL);
  delta=(te.tv_sec-ts.tv_sec)*1000.0+(te.tv_usec-ts.tv_usec)/1000.0;
  printf("%-20s : %.3f sec\n","- JNI read",delta/1000.0);
 free(in1);
  gettimeofday(&ts,NULL);
  g_solve();
  gettimeofday(&te,NULL);
  delta=(te.tv_sec-ts.tv_sec)*1000.0+(te.tv_usec-ts.tv_usec)/1000.0;
  printf("%-20s : %.3f sec\n","- CUDA compute",delta/1000.0);
  trace_t *trace=NULL; unsigned size=0;
  gettimeofday(&ts,NULL);
  int score=g_backtrack(&trace,&size);
  gettimeofday(&te,NULL);
  delta=(te.tv_sec-ts.tv_sec)*1000.0+(te.tv_usec-ts.tv_usec)/1000.0;
  printf("%-20s : %.3f sec\n","- CUDA backtrack",delta/1000.0);
  gettimeofday(&ts,NULL);
  jobject result = jni_write(env, score, trace, size); free(trace);
  gettimeofday(&te,NULL);
  delta=(te.tv_sec-ts.tv_sec)*1000.0+(te.tv_usec-ts.tv_usec)/1000.0;
  printf("%-20s : %.3f sec\n","- JNI output",delta/1000.0);
  fflush(stdout); fflush(stderr);
  g_free(); return result;
}
