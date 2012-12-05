#include "librna.h"
#include "rnalib.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static char* seq=NULL; // the sequence converted in 0-5 internal Vienna format

void _fun(setParams)(JNIEnv *env, jobject obj, jstring file) {
  const char *str = (*env)->GetStringUTFChars(env, file, 0);
  librna_read_param_file(str);
  (*env)->ReleaseStringUTFChars(env, file, str);
}

void _fun(setSequence)(JNIEnv *env, jobject obj, jstring sequence) {
  const char *str = (*env)->GetStringUTFChars(env, sequence, 0);
  size_t i,len = strlen(str);
  if (seq) free(seq);
  seq=malloc((len+1)*sizeof(char));
  if (seq==NULL) { fprintf(stderr,"Sequence memory allocation error.\n"); exit(1); }
  else {
    for (i=0;i<len;++i) switch(str[i]) {
      case 'a' : seq[i] = 1; break;
      case 'c' : seq[i] = 2; break;
      case 'g' : seq[i] = 3; break;
      case 'u' : seq[i] = 4; break;
      default: fprintf(stderr,"Bad character '%c' (%d) in the provided sequence.\n",str[i],str[i]); exit(1);
    }
  	seq[len]=0;
  }
  (*env)->ReleaseStringUTFChars(env, sequence, str);
}

void _fun(clear)(JNIEnv *env, jobject obj) { if (seq) { free(seq); seq=NULL; } }

jint _fun(termau_1energy)(JNIEnv *env, jobject obj, jint i, jint j) { return termau_energy(seq,i,j); }
jint _fun(hl_1energy)(JNIEnv *env, jobject obj, jint i, jint j) { return hl_energy(seq,i,j); }
jint _fun(hl_1energy_1stem)(JNIEnv *env, jobject obj, jint i, jint j) { return hl_energy_stem(seq,i,j); }
jint _fun(il_1energy)(JNIEnv *env, jobject obj, jint i, jint j, jint k, jint l) { return il_energy(seq,i,j,k,l); }
jint _fun(bl_1energy)(JNIEnv *env, jobject obj, jint bl, jint i, jint j, jint br, jint Xright) { return bl_energy(seq,bl,i,j,br,Xright); }
jint _fun(br_1energy)(JNIEnv *env, jobject obj, jint bl, jint i, jint j, jint br, jint Xleft) { return br_energy(seq,bl,i,j,br,Xleft); }
jint _fun(sr_1energy)(JNIEnv *env, jobject obj, jint i, jint j) { return sr_energy(seq,i,j); }
jint _fun(sr_1pk_1energy)(JNIEnv *env, jobject obj, jbyte a, jbyte b, jbyte c, jbyte d) { return sr_pk_energy(a,b,c,d); }
jint _fun(dl_1energy)(JNIEnv *env, jobject obj, jint i, jint j) { return dl_energy(seq,i,j); }
jint _fun(dr_1energy)(JNIEnv *env, jobject obj, jint i, jint j, jint n) { return dr_energy(seq,i,j,n); }
jint _fun(dli_1energy)(JNIEnv *env, jobject obj, jint i, jint j) { return dli_energy(seq,i,j); }
jint _fun(dri_1energy)(JNIEnv *env, jobject obj, jint i, jint j) { return dri_energy(seq,i,j); }
jint _fun(ext_1mismatch_1energy)(JNIEnv *env, jobject obj, jint i, jint j, jint n) { return ext_mismatch_energy(seq,i,j,n); }
jint _fun(ml_1mismatch_1energy)(JNIEnv *env, jobject obj, jint i, jint j) { return ml_mismatch_energy(seq,i,j); }
jint _fun(ml_1energy)(JNIEnv *env, jobject obj) { return ml_energy(); }
jint _fun(ul_1energy)(JNIEnv *env, jobject obj) { return ul_energy(); }
jint _fun(sbase_1energy)(JNIEnv *env, jobject obj) { return sbase_energy(); }
jint _fun(ss_1energy)(JNIEnv *env, jobject obj, jint i, jint j) { return ss_energy(i,j); }
jint _fun(dl_dangle_dg)(JNIEnv *env, jobject obj, jbyte dangle, jbyte i, jbyte j) { return dl_dangle_dg(dangle,i,j); }
jint _fun(dr_dangle_dg)(JNIEnv *env, jobject obj, jbyte i, jbyte j, jbyte dangle) { return dl_dangle_dg(i,j,dangle); }
