#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <jni.h>

#define _fun(name) Java_librna_LibRNA_00024_##name
#define _vfun(name) JNIEXPORT void JNICALL Java_librna_LibRNA_00024_##name
#define _ifun(name) JNIEXPORT jint JNICALL Java_librna_LibRNA_00024_##name
#define _p0 JNIEnv *env, jobject obj

#ifdef __cplusplus
extern "C" {
#endif

// Definition of the classname, spread over all JNI functions
_vfun(setParams)(_p0, jstring);
_vfun(setSequence)(_p0, jstring);
_vfun(clear)(_p0);
_ifun(termau_1energy)(_p0, jint, jint);
_ifun(hl_1energy)(_p0, jint, jint);
_ifun(hl_1energy_1stem)(_p0, jint, jint);
_ifun(il_1energy)(_p0, jint, jint, jint, jint);
_ifun(bl_1energy)(_p0, jint, jint, jint, jint, jint);
_ifun(br_1energy)(_p0, jint, jint, jint, jint, jint);
_ifun(sr_1energy)(_p0, jint, jint);
_ifun(sr_1pk_1energy)(_p0, jbyte, jbyte, jbyte, jbyte);
_ifun(dl_1energy)(_p0, jint, jint);
_ifun(dr_1energy)(_p0, jint, jint);
_ifun(dli_1energy)(_p0, jint, jint);
_ifun(dri_1energy)(_p0, jint, jint);
_ifun(ext_1mismatch_1energy)(_p0, jint, jint);
_ifun(ml_1mismatch_1energy)(_p0, jint, jint);
_ifun(ml_1energy)(_p0);
_ifun(ul_1energy)(_p0);
_ifun(sbase_1energy)(_p0);
_ifun(ss_1energy)(_p0, jint, jint);
_ifun(dl_dangle_dg)(_p0, jbyte, jbyte, jbyte);
_ifun(dr_dangle_dg)(_p0, jbyte, jbyte, jbyte);
#ifdef __cplusplus
}
#endif

#define my_len c_len
#define my_seq c_seq
#define my_P c_P
#define my_dev
#include "rnalib_impl.h"
#undef my_len
#undef my_seq
#undef my_P
#undef my_dev

void _fun(setParams)(_p0, jstring file) {
  const char *str = (*env)->GetStringUTFChars(env, file, 0);
  if (str) read_parameter_file(str);
  if (c_P) free(c_P); c_P=get_scaled_parameters();
  (*env)->ReleaseStringUTFChars(env, file, str);
}

void _fun(setSequence)(_p0, jstring sequence) {
  const char *str = (*env)->GetStringUTFChars(env, sequence, 0);
  size_t i; if (c_seq) free(c_seq);
  c_len=strlen(str); c_seq=malloc((c_len+1)*sizeof(char));
  if (c_seq==NULL) { fprintf(stderr,"Sequence memory allocation error.\n"); exit(EXIT_FAILURE); }
  else {
    for (i=0;i<c_len;++i) switch(str[i]) {
      case 'a' : c_seq[i] = 1; break;
      case 'c' : c_seq[i] = 2; break;
      case 'g' : c_seq[i] = 3; break;
      case 'u' : c_seq[i] = 4; break;
      default: fprintf(stderr,"Bad character '%c' (%d) in the provided sequence.\n",str[i],str[i]); exit(EXIT_FAILURE);
    }
  	c_seq[c_len]=0;
  }
  (*env)->ReleaseStringUTFChars(env, sequence, str);
}

void _fun(clear)(_p0) { if (c_seq) { free(c_seq); c_seq=NULL; } }
jint _fun(termau_1energy)(_p0, jint i, jint j) { return termau_energy(i,j); }
jint _fun(hl_1energy)(_p0, jint i, jint j) { return hl_energy(i,j); }
jint _fun(hl_1energy_1stem)(_p0, jint i, jint j) { return hl_energy_stem(i,j); }
jint _fun(il_1energy)(_p0, jint i, jint k, jint l, jint j) { return il_energy(i,k,l,j); }
jint _fun(bl_1energy)(_p0, jint i, jint k, jint l, jint j, jint Xright) { return bl_energy(i,k,l,j,Xright); }
jint _fun(br_1energy)(_p0, jint i, jint k, jint l, jint j, jint Xleft) { return br_energy(i,k,l,j,Xleft); }
jint _fun(sr_1energy)(_p0, jint i, jint j) { return sr_energy(i,j); }
jint _fun(sr_1pk_1energy)(_p0, jbyte a, jbyte b, jbyte c, jbyte d) { return sr_pk_energy(a,b,c,d); }
jint _fun(dl_1energy)(_p0, jint i, jint j) { return dl_energy(i,j); }
jint _fun(dr_1energy)(_p0, jint i, jint j) { return dr_energy(i,j); }
jint _fun(dli_1energy)(_p0, jint i, jint j) { return dli_energy(i,j); }
jint _fun(dri_1energy)(_p0, jint i, jint j) { return dri_energy(i,j); }
jint _fun(ext_1mismatch_1energy)(_p0, jint i, jint j) { return ext_mismatch_energy(i,j); }
jint _fun(ml_1mismatch_1energy)(_p0, jint i, jint j) { return ml_mismatch_energy(i,j); }
jint _fun(ml_1energy)(_p0) { return ml_energy(); }
jint _fun(ul_1energy)(_p0) { return ul_energy(); }
jint _fun(sbase_1energy)(_p0) { return sbase_energy(); }
jint _fun(ss_1energy)(_p0, jint i, jint j) { return ss_energy(i,j); }
jint _fun(dl_dangle_dg)(_p0, jbyte dangle, jbyte i, jbyte j) { return dl_dangle_dg(dangle,i,j); }
jint _fun(dr_dangle_dg)(_p0, jbyte i, jbyte j, jbyte dangle) { return dl_dangle_dg(i,j,dangle); }
