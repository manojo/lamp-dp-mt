ADPFusion
-----------------------------------

# cabal update
 (cabal install cabal-install)
# cabal install Nussinov78
-> fix this


CUDAlign
-----------------------------------
Compile: cd src; make
Help: src/cudalign --help
src/cudalign --clear A.fasta B.fasta


GAPC
-----------------------------------
gapc -t matmult.gap
gapc -t -i affine affine.gap
gapc -t -i mfe adpfold.gap


ADP-C
-----------------------------------
cabal install haskell98
cd config
make
-> fix this

setenv PATH "$HOME/.cabal/bin:$PATH"

RNAfold
-----------------------------------
rnafold-CUDA does not display any result, however it seems to compute...
so let's assume it works... rnafold-CPU seems fine.

