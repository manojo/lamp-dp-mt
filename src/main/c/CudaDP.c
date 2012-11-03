#include <jni.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

// Input type
typedef struct {
	int _1, _2; // GEN: generate this
} input_t;
#define TI input_t

TI* in1=NULL;
TI* in2=NULL;
int in1_len=0;
int in2_len=0;


// Signature: ([Lscala/Product;[Lscala/Product;)V

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

	printf("inLists( [");
	int i;
	for (i=0;i<in1_len;++i) { TI e = in1[i]; if (i) printf(","); printf("(%d,%d)",e._1,e._2); }
	printf("] [");
	for (i=0;i<in2_len;++i) { TI e = in2[i]; if (i) printf(","); printf("(%d,%d)",e._1,e._2); }
	printf("] )\n");

	// XXX: alloc list.count * object.size ints, process
	// better: write a class that is a placeholder and can be combined into a struct
	// => use both java and C representation
}

// Signature: (Ljava/lang/String;Ljava/lang/String;)V
JNIEXPORT void JNICALL Java_CudaDP_inStrings(JNIEnv* env, jobject obj, jstring string1, jstring string2) {
	const char* s1=(*env)->GetStringUTFChars(env, string1, NULL);
	const char* s2=(*env)->GetStringUTFChars(env, string2, NULL);

	printf("inStrings( \"%s\", \"%s\")\n",s1,s2);

	(*env)->ReleaseStringUTFChars(env, string1, s1);
	(*env)->ReleaseStringUTFChars(env, string2, s2);
}

// Signature: ()V
JNIEXPORT void JNICALL Java_CudaDP_computeMatrix(JNIEnv* env, jobject obj) {
	printf("computeMatrix()\n");
}

// Signature: ()J
JNIEXPORT jlong JNICALL Java_CudaDP_getScore(JNIEnv* env, jobject obj) {
	printf("getScore()\n");
	return 0;
}

// Signature: ()[Lscala/Tuple2;
JNIEXPORT jobjectArray JNICALL Java_CudaDP_getBacktrack(JNIEnv *env, jobject obj) {
	printf("getBacktrack()\n");
	return NULL;
}

// Signature: ()V
JNIEXPORT void JNICALL Java_CudaDP_free(JNIEnv* env, jobject obj) {
	printf("free()\n");
}

// Signature: ()V
//JNIEXPORT void JNICALL Java_CudaDP_finalize (JNIEnv* env, jobject obj) {
//	printf("finalize(%p)\n",obj);
//}
