#pragma once

#define DNA_MATCH       (1)
#define DNA_MISMATCH    (-3)
#define DNA_GAP_EXT     (2)
#define DNA_GAP_OPEN    (3)
#define DNA_GAP_FIRST   (DNA_GAP_EXT+DNA_GAP_OPEN)


#define SW_NUCLEOTIDE
//#define SW_AMINOACID


#define PROT_GAP_EXT     (10)
#define PROT_GAP_OPEN    (2)
#define PROT_GAP_FIRST   (PROT_GAP_EXT+PROT_GAP_OPEN)


#define INF (999999999)

#include "blosum/blosum50.h"

