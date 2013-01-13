/* RNA energy library
   library of wrapper functions to access the Vienna-Tables for the Turner1999 and Turner2004 energy values from Bellman's GAP programs
   works with the Vienna-Package 1.8.5 and Vienna-Package 2.0.0
   written by Stefan Janssen, 12.09.2011
   modified on 28.10.2011 to support gaps in sequences, which is necessary to fold alignments. Basic concept: the common structure is given by the usual grammar, but base- and/or stackpairing is only possible if x% of sequences at this positions can form pairs. Thus pairs with gaps or gap-gap-pairs are possible for single sequences; loops can contain gaps and thus e.g. an internal loop might become a bulge loop or even a stack.
   modified on 24.11.2011 to merge 2004 and 1999 versions into one file
   modified on 13.04.2012 to use the same trick as the Vienna-Package to just once rescale energie values to given temperature

   more information about the nearest neighbor energy model can be found in
    - David Mathews "Nearest Neighbor Database Homepage": http://rna.urmc.rochester.edu/NNDB/
    - Michael Zukers user manual to mfold 3.0: http://mfold.rna.albany.edu/download/mfold-3.0-manual.pdf.gz
    - fundamental information about the nearest neighbor energy model are included in the papers listed in the begin of the file "energy_par.c"
    - file H/loop_energies.h of the Vienna RNA package >= 2.0.0
    - some aspects of the Turner2004 model are not integrated in the Vienna RNA package, for details see their upcoming paper "ViennaRNA Package 2.0" by Lorenz et al.
*/

/* returns the destabilizing energy of all but GC or CG basepairs. This should be applied only on terminal basepairs. It should be better understood as a bonus for CG / GC basepairs.
       X     (X = some closed structure)
     |   |
     i - j   i = the index (first base of s is 0, second 1, ...) of the 5' partner of the stem terminating basepair
     |   |   j = the index (first base of s is 0, second 1, ...) of the 3' partner of the stem terminating basepair
     5'  3'  */
int termau_energy(rsize i, rsize j);

/* returns the energy contribution for hairpin loops, i.e one closing basepair with an embedded unpaired loop region (of 3 bases, at least).
          . . .      The energy contribution is composed of:
        .       .    a) the stabilizing effect of stacking the outermost bases of the loop onto the enclosing basepair, i.e. "hl_stack": i+1 and j-1 stack onto the pair i-j
        .       .    b) the destabilizing effect of the loop region "hl_ent"
       i+1     j-1   c) the destabilizing effect of the closing basepair i-j if it is AU, UA, GU or UG "termau_energy" (partially included in "hl_stack")
          i - j      Prior to these three effects, there exist special energy values for some ultrastable tetra-loops (tri-, tetra- and hexa-loops in 2004 version) (referring to the size of the loop region) "hl_tetra"
          |   |      i = the index (first base of s is 0, second 1, ...) of the 5' partner of the hairpin closing basepair
          5'  3'     j = the index (first base of s is 0, second 1, ...) of the 3' partner of the hairpin closing basepair
   (i and j form the closing basepair) */
int hl_energy(rsize i, rsize j);

/* like hl_energy, just no penalty for size > 4 structures */
int hl_energy_stem(rsize i, rsize j);

// Get basepair index x = 5' base of the basepair, y = 3' base of the basepair
static int bp_index(char x, char y);

// Counts the number of GAP symbols between i and j to find the real length of a loop
static rsize noGaps(rsize i, rsize j);

// Next downstream base is not necessarily the next character in s. There might be one or more GAPs between both.
// Thus getNext jumps over GAPs to the steps-next non GAP base in s. This is restricted by left and right borders "pos" and "rightBorder".
//   pos = startpoint of search for right neighboring non-GAP base.
//   steps = sometimes we don't need the direct neighboring base, but also the second, third, ... neighboring non GAP base.
//   rightBorder = last character position to look for right neighboring non-GAP bases.
static rsize getNext(rsize pos, rsize steps, rsize rightBorder);

// Next upstream base is not necessarily the previous character in s. There might be one or more GAPs between both.
// Thus getNext jumps over GAPs to the step-previous non GAP base in s. This is restricted by left and right borders "leftBorder" and "pos".
//   pos = last character position to look for left neighboring non-GAP bases.
//   steps = sometimes we don't need the direct neighboring base, but also the second, third, ... neighboring non GAP base.
//   leftBorder = startpoint of search for left neighboring non-GAP base.
static rsize getPrev(rsize pos, rsize steps, rsize leftBorder);

// approximates the destabilizing effect of unpaired loop regions longer than 30 bases, since there are no measured wet lab data
// currently (11.09.2011) lxc37 is 107.856 and MAXLOOP is 30. this function is used for hairpins, bulges and internal loops
//   size, i.e. number of bases, of the unpaired loop region: l
static int jacobson_stockmayer(rsize l);

// destabilizing energy values for unpaired hairpin loops smaller then MAXLOOP bases. For larger loops jacobson_stockmayer is used.
// currently (11.09.2011) MAXLOOP is 30
//   just the size, i.e. number of bases, of the unpaired loop region: l
static int hl_ent(rsize l);

/* returns stabilizing energy values for the outermost bases of a hairpin loop, which stack onto the closing base pair
   the outermost bases of the hairpin loop do not form a basepair, thus they are a mismatch
          . . .        (i and j form the closing basepair)
        .       .      i = the index (first base of s is 0, second 1, ...) of the 5' partner of the hairpin closing basepair
        .       .      j = the index (first base of s is 0, second 1, ...) of the 3' partner of the hairpin closing basepair
       i+1     j-1     mismatchH37 data-arrangement:
          i - j        1. index = bp = code for closing basepair i-j
          |   |        2. index = lbase = code for 5' base i+1 stacking on closing basepair i-j
          5'  3'       3. index = rbase = code for 3' base j-1 stacking on closing basepair i-j */
static int hl_stack(rsize i, rsize j);

/*
   returns the energy of an internal loop with exactly one unpaired base on 5' and 3' side.
       X     (X = some closed structure)
     |   |
   i+2 - j-2      (i+2 and j-2 form the embedded basepair)
 i+1       j-1    (i+1 and j-1 are the unpaired bases in the internal loop)
     i - j        (i and j form the closing basepair)
     |   |
     5'  3'
   Input is
     s = the input RNA sequence in bit encoding, i.e. N=0, A=1, C=2, G=3, U=4, GAP=5 (see /usr/include/librna/rnalib.h base_t)
     i = the index (first base of s is 0, second 1, ...) of the 5' partner of the internal loop closing basepair
     k = non-GAP-case: == i+2, GAP-case: 5' partner of basal X basepair. We need this to not look to much downstream for the enclosedBP, because sometimes it might be missing due to gaps, sometimes just the loop ist extended by a few gaps.
     l = non-GAP-case: == j-2, GAP-case: 3' partner of basal X basepair. We need this to not look to much upstream for the enclosedBP, because sometimes it might be missing due to gaps, sometimes just the loop ist extended by a few gaps.
     j = the index (first base of s is 0, second 1, ...) of the 3' partner of the internal loop closing basepair
   int11_37 data-arrangement:
     1. index = closingBP = code for closing basepair i-j
     2. index = enclosedBP = code for enclosed basepair, i.e. the fist basepair of the embedded substructure, i+2 - j-2.
     3. index = lbase = code for 5' unpaired base of the internal loop
     4. index = rbase = code for 3' unpaired base of the internal loop
*/
static int il11_energy(rsize i, rsize k, rsize l, rsize j);

/*
   returns the energy of an internal loop with exactly one unpaired base on 5' and two unpaired bases on 3' side.
       X     (X = some closed structure)
     |   |
   i+2 - j-3      (i+2 and j-3 form the embedded basepair)
 i+1       j-2    (i+1, j-1 and j-2 are the unpaired bases in the internal loop)
           j-1
     i - j        (i and j form the closing basepair)
     |   |
     5'  3'
   Input is
     s = the input RNA sequence in bit encoding, i.e. N=0, A=1, C=2, G=3, U=4, GAP=5 (see /usr/include/librna/rnalib.h base_t)
     i = the index (first base of s is 0, second 1, ...) of the 5' partner of the internal loop closing basepair
     k = non-GAP-case: == i+2, GAP-case: 5' partner of basal X basepair. We need this to not look to much downstream for the enclosedBP, because sometimes it might be missing due to gaps, sometimes just the loop ist extended by a few gaps.
     l = non-GAP-case: == j-3, GAP-case: 3' partner of basal X basepair. We need this to not look to much upstream for the enclosedBP, because sometimes it might be missing due to gaps, sometimes just the loop ist extended by a few gaps.
     j = the index (first base of s is 0, second 1, ...) of the 3' partner of the internal loop closing basepair
   int21_37 data-arrangement:
     1. index = closingBP = code for closing basepair i-j
     2. index = enclosedBP = code for enclosed basepair, i.e. the fist basepair of the embedded substructure, i+2 - j-3.
     3. index = lbase = code for single 5' unpaired base of the internal loop, i+1
     4. index = rbase = code for first (= close to the embedded substructure) 3' unpaired base of the internal loop, j-2
     5. index = rrbase = code for second (= close to the i-j basepair) 3' unpaired base of the internal loop, j-1
*/
static int il12_energy(rsize i, rsize k, rsize l, rsize j);

// symmetric case to il12_energy
static int il21_energy(rsize i, rsize k, rsize l, rsize j);

/*
   returns the energy of an internal loop with exactly two unpaired base on 5' and 3' side.
       X          (X = some closed structure)
     |   |
   i+3 - j-3      (i+3 and j-3 form the embedded basepair)
 i+2       j-2    (i+2 and j-2 are the unpaired bases in the internal loop)
 i+1       j-1    (i+1 and j-1 are the unpaired bases in the internal loop)
     i - j        (i and j form the closing basepair)
     |   |
     5'  3'
   Input is
     s = the input RNA sequence in bit encoding, i.e. N=0, A=1, C=2, G=3, U=4, GAP=5 (see /usr/include/librna/rnalib.h base_t)
     i = the index (first base of s is 0, second 1, ...) of the 5' partner of the internal loop closing basepair
     k = non-GAP-case: == i+3, GAP-case: 5' partner of basal X basepair. We need this to not look to much downstream for the enclosedBP, because sometimes it might be missing due to gaps, sometimes just the loop ist extended by a few gaps.
     l = non-GAP-case: == j-3, GAP-case: 3' partner of basal X basepair. We need this to not look to much upstream for the enclosedBP, because sometimes it might be missing due to gaps, sometimes just the loop ist extended by a few gaps.
     j = the index (first base of s is 0, second 1, ...) of the 3' partner of the internal loop closing basepair
   int22_37 data-arrangement:
     1 = the input RNA sequence in bit encoding, i.e. N=0, A=1, C=2, G=3, U=4, GAP=5 (see /usr/include/librna/rnalib.h base_t)
     2. index = closingBP = code for closing basepair i-j
     3. index = enclosedBP = code for enclosed basepair, i.e. the fist basepair of the embedded substructure, i+2 - j-2.
     4. index = lbase = code for first (= closer to the closing basepair) 5' unpaired base of the internal loop, i+1
     5. index = llbase = code for second (= closer to the embedded substructure) 5' unpaired base of the internal loop, i+2
     6. index = rbase = code for first (= closer to the embedded substructure) 3' unpaired base of the internal loop, j-2
     7. index = rrbase = code for second (= closer to the closing basepair) 3' unpaired base of the internal loop, j-1
*/
static int il22_energy(rsize i, rsize k, rsize l, rsize j);

/*
   returns destabilizing energy values for unpaired loops smaller then MAXLOOP bases in internal loops
   for larger loops jacobson_stockmayer is used.
   currently (11.09.2011) MAXLOOP is 30
   Input is just the size, i.e. number of bases, of the unpaired loop region: l
*/
static int il_ent(rsize l);

/*
   returns the stabilizing energy for the outermost bases of the unpaired regions stacking on the closing and the embedded basepair of the internal loop
   the outermost bases of the internal loops do not form a basepair, thus they are mismatches
       X          (X = some closed structure)
     |   |
     k - l        (k and l form the embedded basepair)
 k-1       l+1    (k-1 and l+1 are the unpaired bases in the internal loop)
  .         .
 i+1       j-1    (i+1 and j-1 are the unpaired bases in the internal loop)
     i - j        (i and j form the closing basepair)
     |   |
     5'  3'
   Input is
     s = the input RNA sequence in bit encoding, i.e. N=0, A=1, C=2, G=3, U=4, GAP=5 (see /usr/include/librna/rnalib.h base_t)
     i = the index (first base of s is 0, second 1, ...) of the 5' partner of the internal loop closing basepair
     k = the index (first base of s is 0, second 1, ...) of the 5' partner of the internal loop embedded basepair.
     l = the index (first base of s is 0, second 1, ...) of the 3' partner of the internal loop embedded basepair.
     j = the index (first base of s is 0, second 1, ...) of the 3' partner of the internal loop closing basepair
   mismatchI37 data-arrangement:
     1. index = out_closingBP = in_closingBP = code for closing basepair i-j
     2. index = out_lbase = in_lbase = code for first (= closer to the closing basepair) 5' unpaired base of the internal loop, i+1
     3. index = out_rbase = in_rbase = code for second (= closer to the closing basepair) 3' unpaired base of the internal loop, j-1
*/
static int il_stack(rsize i, rsize k, rsize l, rsize j);

/*
   returns the destabilizing penalty for internal loops with asymmetric sized unpaired loop regions
   version 1999: currently (12.09.2011) ninio37[2] is 50 and MAX_NINIO is 300
   version 2004: currently (12.09.2011) ninio37 is 60 and MAX_NINIO is 300
   Input is
     sl = size of the 5' unpaired loop region
     sr = size of the 3' unpaired loop region
*/
static int il_asym(rsize sl, rsize sr);

/*
   returns the energy contribution of an internal loop, i.e. two basepairs forming a stem which has bulged out bases on 5' and 3' side.
       X          (X = some closed structure)
     |   |
     k - l        (k and l form the embedded basepair)
 k-1       l+1    (k-1 and l+1 are the unpaired bases in the internal loop)
  .         .
 i+1       j-1    (i+1 and j-1 are the unpaired bases in the internal loop)
     i - j        (i and j form the closing basepair)
     |   |
     5'  3'
   The energy contribution is composed of:
    a) the stabilizing effect of stacking the outermost bases of the loop regions onto the closing or embedded basepair, i.e. "il_stack" i+1 and j-1 stack onto the pair i-j AND k-1 and l+1 stack onto the pair k-l
    b) the destabilizing effect of the loop regions "il_ent"
    c) the destabilizing effect of asymmetric loop sizes "il_asym"
   Prior to these three effects, there exist energy values for some special cases
    1x1 internal loops, i.e. internal loop with exactly one bulged base on both sides: "il11_energy"
    1x2 internal loops: "il12_energy"
    1xn internal loops with n > 2: "mismatch1nI37" and others (only for T2004)
    2x1 internal loops: "il21_energy"
    2x2 internal loops: "il22_energy"
    2x3 internal loops: "mismatch23I37" and others (only for T2004)
    3x2 internal loops: "mismatch23I37" and others (only for T2004)
    nx1 internal loops with n > 2: "mismatch1nI37" and others (only for T2004)
   Input is
     s = the input RNA sequence in bit encoding, i.e. N=0, A=1, C=2, G=3, U=4, GAP=5 (see /usr/include/librna/rnalib.h base_t)
     i = the index (first base of s is 0, second 1, ...) of the 5' partner of the internal loop closing basepair
     k = the index (first base of s is 0, second 1, ...) of the 5' partner of the internal loop embedded basepair.
     l = the index (first base of s is 0, second 1, ...) of the 3' partner of the internal loop embedded basepair.
     j = the index (first base of s is 0, second 1, ...) of the 3' partner of the internal loop closing basepair
*/
int il_energy(rsize i, rsize k, rsize l, rsize j);

/*
   returns destabilizing energy values for an unpaired loop smaller then MAXLOOP bases in a bulge loop
   for larger loops jacobson_stockmayer is used.
   currently (12.09.2011) MAXLOOP is 30
   Input is
     just the size, i.e. number of bases, of the unpaired loop region: l
*/
static int bl_ent(rsize l);

/*
   returns the energy contribution of a left bulge loop, i.e. two basepairs forming a stem which has bulged out bases on 5' side.
       X          (X = some closed structure)
     |   |
   l+1 - j-1      (l+1 and j-1 form the embedded basepair)
  l      |        (l is the last unpaired bases in the bulge loop)
  .      |
  k      |        (k is the first the unpaired bases in the bulge loop)
     i - j        (i and j form the closing basepair)
     |   |
     5'  3'
   The energy contribution is composed of:
    a) the destabilizing effect of the loop region "bl_ent"
    b) the destabilizing effect of the closing basepair i-j if it is AU, UA, GU or UG "termau_energy"
    c) the destabilizing effect of the embedded basepair l+1 - j-1 if it is AU, UA, GU or UG "termau_energy"
   Prior to these three effects, there exist energy values for the special case if exactly one base is bulged, then b) and c) are replaced by the energy of stacking closing- and embedded basepair
   Input is
     s = the input RNA sequence in bit encoding, i.e. N=0, A=1, C=2, G=3, U=4, GAP=5 (see /usr/include/librna/rnalib.h base_t)
     i = the index (first base of s is 0, second 1, ...) of the 5' partner of the internal loop closing basepair
     k = the index (first base of s is 0, second 1, ...) of the first unpaired base of the 5' bulge region
     l = the index (first base of s is 0, second 1, ...) of the last unpaired base of the 5' bulge region
     j = the index (first base of s is 0, second 1, ...) of the 3' partner of the internal loop closing basepair
     Xright = for GAP case: the 3' partner of the enclosed basepair might not be at j-1 if we consider gaps. We have two possibilities: either it is seperated from j by one or more GAPs, or it might even be missing at all. Thus we have to know where the closed substructure X has its right border.
*/
int bl_energy(rsize i, rsize k, rsize l, rsize j, rsize Xright);

/*
   symmetric case to "bl_energy"
       X          (X = some closed structure)
     |   |
   i+1 - k-1      (i+1 and k-1 form the embedded basepair)
     |      k     (k is the first unpaired bases in the bulge loop)
     |      .
     |      l     (l is the last the unpaired bases in the bulge loop)
     i - j        (i and j form the closing basepair)
     |   |
     5'  3'
*/
int br_energy(rsize i, rsize k, rsize l, rsize j, rsize Xleft);

/*
   returns the stabilizing energy of two successive basepairs forming a stack
       X          (X = some closed structure)
     |   |
   i+1 - j-1      (i+1 and j-1 form the embedded basepair)
     |   |
     i - j        (i and j form the closing basepair)
     |   |
     5'  3'
   Input is
     s = the input RNA sequence in bit encoding, i.e. N=0, A=1, C=2, G=3, U=4, GAP=5 (see /usr/include/librna/rnalib.h base_t)
     i = the index (first base of s is 0, second 1, ...) of the 5' partner of the closing basepair
     j = the index (first base of s is 0, second 1, ...) of the 3' partner of the closing basepair
   stack37 data-arrangement:
     1. index = closingBP = code for closing basepair i-j
     2. index = enclosedBP = code for enclosed basepair i+1 and j-1. Note, basepair is reversed to preserver 5'-3' order
*/
int sr_energy(rsize i, rsize j);

/* same as "sr_energy" but here the input is not relative to the RNA input sequence, but can be any combination of four bases
   currently used for the coaxial stacking of both stems of a pseudoknot */
int sr_pk_energy(char a, char b, char c, char d);

/* energy contribution of a single base left to a stem which dangles on this stem from the outside
       X          (X = some closed structure)
     |   |
     i - j        (i and j form the closing basepair)
  i-1    |        (5' dangling base)
     5'  3'
   Input is
     s = the input RNA sequence in bit encoding, i.e. N=0, A=1, C=2, G=3, U=4, GAP=5 (see /usr/include/librna/rnalib.h base_t)
     i = the index (first base of s is 0, second 1, ...) of the 5' partner of the closing basepair
     j = the index (first base of s is 0, second 1, ...) of the 3' partner of the closing basepair
   dangle5_37 data-arrangement:
     1. index = closingBP = code for closing basepair i-j
     2. index = dbase = code for dangling base
*/
int dl_energy(rsize i, rsize j);

/*
   symmetric case to dl_energy, but here the dangling base is on the 3' side of the stem
       X          (X = some closed structure)
     |   |
     i - j        (i and j form the closing basepair)
     |    j+1     (3' dangling base)
     5'  3'
   Input is
     in addition: n = length of the input RNA sequence (necessary for OverDangle, should there be no more base on the right side of a stem)
*/
int dr_energy(rsize i, rsize j);

/*
   similar to dl_energy, but here the base dangles from the inside onto the stem. This happens only in multiloops.
      X Y         (X and Y = some closed structures)
  i+1    |        (5' base, dangling onto the inner terminal basepair of a multiloop-closing stem)
     i - j        (i and j form the closing basepair)
     |   |
     5'  3'
*/
int dli_energy(rsize i, rsize j);
/*
   symmetric case to dli_energy, but here the base which dangles onto a multiloop closing stem from inside is on 3' side
      X Y         (X and Y = some closed structures)
     |    j-1     (3' base, dangling onto the inner terminal basepair of a multiloop-closing stem)
     i - j        (i and j form the closing basepair)
     |   |
     5'  3'
*/
int dri_energy(rsize i, rsize j);

/*
   returns the energy contribution of two bases dangling from the outside onto a stem, but do not form a basepair
       X          (X = some closed structure)
     |   |
     i - j        (i and j form the closing basepair)
  i-1     j+1     (5' and 3' dangling bases)
     5'  3'
   Input is
     s = the input RNA sequence in bit encoding, i.e. N=0, A=1, C=2, G=3, U=4, GAP=5 (see /usr/include/librna/rnalib.h base_t)
     i = the index (first base of s is 0, second 1, ...) of the 5' partner of the closing basepair
     j = the index (first base of s is 0, second 1, ...) of the 3' partner of the closing basepair
     n = length of the input RNA sequence (necessary for OverDangle, should there be no more base on the right side of a stem)
   mismatchExt37 data-arrangement:
     1. index = closingBP = code for closing basepair i-j
     2. index = lbase = code for dangling 5' base
     3. index = rbase = code for dangling 3' base
*/
int ext_mismatch_energy(rsize i, rsize j);

/*
   same as ext_mismatch_energy but for two bases dangling on the inside of a multiloop stem
      X Y         (X and Y = some closed structures)
  i+1     j-1     (5' and 3' base, dangling onto the inner terminal basepair of a multiloop-closing stem)
     i - j        (i and j form the closing basepair)
     |   |
     5'  3'
*/
int ml_mismatch_energy(rsize i, rsize j);

/* energy for initiating a multiloop (v1999: 340, v2004: 930) */
int ml_energy(void);

/* energy for initiating a stem within a multiloop (v1999: 40, v2004: -90) */
int ul_energy(void);

/* energy for one unpaired base, not included into loops (hairpin-, bulge-, internal- loops), but in single stranded stretches next to closed substructures also in multiloops
   currently (12.09.2011) this value is set to 0 */
int sbase_energy(void);

/* same es sbase_energy, but for zero to n bases. currently (12.09.2011) this value is set to 0 */
int ss_energy(rsize i, rsize j);

/* scales the energy value x into a partition function value */
double mk_pf(double x);

/* partition function bonus for x unpaired bases */
double scale(int x);

/*
   support function for dl_energy, for the case when the energy contribution must be independent of the input RNA sequence. This is the case where MacroStates has to use a n-tupel as answer type, where n reflects several possible dangling cases.
       X          (X = some closed structure)
     |   |
     i - j        (i and j form the closing basepair)
dangle   |        (dangle = 5' dangling base)
     5'  3'
   Input is
     dangle = the code for the dangling base, note: here it is not an index of the input RNA sequence!
     i = the code for the 5' partner of the closing basepair, note: here it is not an index of the input RNA sequence!
     j = the code for the 3' partner of the closing basepair, note: here it is not an index of the input RNA sequence!
*/
int dl_dangle_dg(enum base_t dangle, enum base_t i, enum base_t j);

/*
   symmetric case to dl_dangle_dg
       X          (X = some closed structure)
     |   |
     i - j        (i and j form the closing basepair)
     |    dangle  (dangle = 3' dangling base)
     5'  3'
*/
int dr_dangle_dg(enum base_t i, enum base_t j, enum base_t dangle);
