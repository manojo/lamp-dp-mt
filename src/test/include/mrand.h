/*
 * Mersenne Twister
 * Copyright (C) 1997 - 2002, Makoto Matsumoto and Takuji Nishimura,
 * The real versions due to Isaku Wada, 2002/01/09 added.
 * BSD licence, http://www.math.sci.hiroshima-u.ac.jp/~m-mat/MT/emt.html
 */
#include <stdint.h>

// Choose which version of Mersenne Twister you want:
#if 0
// Define constants for type MT11213A:
#define MERS_N   351
#define MERS_M   175
#define MERS_R   19
#define MERS_U   11
#define MERS_S   7
#define MERS_T   15
#define MERS_L   17
#define MERS_A   0xE4BD75F5
#define MERS_B   0x655E5280
#define MERS_C   0xFFD58000
#else
// or constants for type MT19937:
#define MERS_N   624
#define MERS_M   397
#define MERS_R   31
#define MERS_U   11
#define MERS_S   7
#define MERS_T   15
#define MERS_L   18
#define MERS_A   0x9908B0DF
#define MERS_B   0x9D2C5680
#define MERS_C   0xEFC60000
#endif

static uint32_t mt[MERS_N]; // State vector
static int mti;             // Index into mt

static uint32_t mrand();

/* Seed generator */
void mseed(int seed) {
	const uint32_t factor = 1812433253UL;
	int i;
	mt[0] = seed;
	for (mti=1; mti<MERS_N; mti++) {
		mt[mti] = (factor * (mt[mti-1] ^ (mt[mti-1] >> 30)) + mti);
	}
	for (i=0; i<37; i++) mrand();
}

uint32_t mrand() {
	uint32_t y;
	if (mti>=MERS_N) {
		// Generate MERS_N words at one time
		const uint32_t LOWER_MASK = (1LU << MERS_R) - 1;       // Lower MERS_R bits
		const uint32_t UPPER_MASK = 0xFFFFFFFF << MERS_R;      // Upper (32 - MERS_R) bits
		static const uint32_t mag01[2] = {0, MERS_A};

		int kk;
		for (kk=0; kk < MERS_N-MERS_M; kk++) {
		y = (mt[kk] & UPPER_MASK) | (mt[kk+1] & LOWER_MASK);
		mt[kk] = mt[kk+MERS_M] ^ (y >> 1) ^ mag01[y & 1];}

		for (; kk < MERS_N-1; kk++) {
			y = (mt[kk] & UPPER_MASK) | (mt[kk+1] & LOWER_MASK);
			mt[kk] = mt[kk+(MERS_M-MERS_N)] ^ (y >> 1) ^ mag01[y & 1];
		}

		y = (mt[MERS_N-1] & UPPER_MASK) | (mt[0] & LOWER_MASK);
		mt[MERS_N-1] = mt[MERS_M-1] ^ (y >> 1) ^ mag01[y & 1];
		mti = 0;
	}
	y = mt[mti++];

	// Tempering (May be omitted):
	y ^=  y >> MERS_U;
	y ^= (y << MERS_S) & MERS_B;
	y ^= (y << MERS_T) & MERS_C;
	y ^=  y >> MERS_L;
	return y;
}

long mrand31() { return (long)(mrand()>>1); }

double mrand1() { return mrand()*(1.0/4294967295.0); } /* real in [0,1] */
double mrand2() { return mrand()*(1.0/4294967296.0); } /* real in [0,1) */
double mrand3() { return (((double)mrand()) + 0.5)*(1.0/4294967296.0); } /* real in (0,1) */

double mrand53(void) { return((mrand()>>5)*67108864.0+(mrand()>>6))*(1.0/9007199254740992.0); }  /* real in [0,1) with 53-bit resolution */
