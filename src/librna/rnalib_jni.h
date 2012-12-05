#include <jni.h>
#ifndef __rnalib_jni_H__
#define __rnalib_jni_H__
#ifdef __cplusplus
extern "C" {
#endif

// Definition of the classname, spread over all functions
#define _fun(name) Java_RNALib_00024_##name

JNIEXPORT void JNICALL _fun(setParams)(JNIEnv *, jobject, jstring);
JNIEXPORT void JNICALL _fun(setSequence)(JNIEnv *, jobject, jstring);
JNIEXPORT void JNICALL _fun(clear)(JNIEnv *, jobject);
JNIEXPORT jint JNICALL _fun(termau_1energy)(JNIEnv *, jobject, jint, jint);
JNIEXPORT jint JNICALL _fun(hl_1energy)(JNIEnv *, jobject, jint, jint);
JNIEXPORT jint JNICALL _fun(hl_1energy_1stem)(JNIEnv *, jobject, jint, jint);
JNIEXPORT jint JNICALL _fun(il_1energy)(JNIEnv *, jobject, jint, jint, jint, jint);
JNIEXPORT jint JNICALL _fun(bl_1energy)(JNIEnv *, jobject, jint, jint, jint, jint, jint);
JNIEXPORT jint JNICALL _fun(br_1energy)(JNIEnv *, jobject, jint, jint, jint, jint, jint);
JNIEXPORT jint JNICALL _fun(sr_1energy)(JNIEnv *, jobject, jint, jint);
JNIEXPORT jint JNICALL _fun(sr_1pk_1energy)(JNIEnv *, jobject, jchar, jchar, jchar, jchar);
JNIEXPORT jint JNICALL _fun(dl_1energy)(JNIEnv *, jobject, jint, jint);
JNIEXPORT jint JNICALL _fun(dr_1energy)(JNIEnv *, jobject, jint, jint, jint);
JNIEXPORT jint JNICALL _fun(dli_1energy)(JNIEnv *, jobject, jint, jint);
JNIEXPORT jint JNICALL _fun(dri_1energy)(JNIEnv *, jobject, jint, jint);
JNIEXPORT jint JNICALL _fun(ext_1mismatch_1energy)(JNIEnv *, jobject, jint, jint, jint);
JNIEXPORT jint JNICALL _fun(ml_1mismatch_1energy)(JNIEnv *, jobject, jint, jint);
JNIEXPORT jint JNICALL _fun(ml_1energy)(JNIEnv *, jobject);
JNIEXPORT jint JNICALL _fun(ul_1energy)(JNIEnv *, jobject);
JNIEXPORT jint JNICALL _fun(sbase_1energy)(JNIEnv *, jobject);
JNIEXPORT jint JNICALL _fun(ss_1energy)(JNIEnv *, jobject, jint, jint);

#ifdef __cplusplus
}
#endif
#endif
