package v4.examples
import v4._

// Zuker folding (Minimum Free Energy)
// ----------------------------------------------------------------------------
// Variant based on Haskell RNAFold-1.99

trait Zuker2Sig extends RNASignature {
}

trait Zuker2Grammar extends Zuker2Sig {

  // base' :: Primary -> DIM2 -> (Scalar Nuc)
  // base' inp (Z:.i:.j) = Scalar $ index inp (Z:.i)

  //-- | Nucleotide, second one to the right. The assertion allows a size of one or
  // -- two to capture special cases of looking outside of the bounds (used by
  // -- @justStemF@ in RNAfold).

  // baseLr' :: Primary -> DIM2 -> (Scalar (Nuc :!: Nuc))
  // baseLr' inp (Z:.i:.j)
  //   = assert (let (_,Z:.n) = bounds inp in (i+1==j || i+2==j) && i>=0 && i+1<=n)
  //   . Scalar $ (index inp (Z:.i) :!: index inp (Z:.i+1))

  // baselR' :: Primary -> DIM2 -> (Scalar (Nuc :!: Nuc))
  // baselR' inp (Z:.i:.j)
  //   = assert (let (_,Z:.n) = bounds inp in i+1==j && i>0 && i<=n)
  //   . Scalar $ (index inp (Z:.i-1) :!: index inp (Z:.i))

  // -- | A 'Primary' together with the lowest included nucleotide and the highest included nucleotide.
  // primary' :: Primary -> DIM2 -> (Scalar (Primary :!: Int :!: Int))
  // primary' inp (Z:.i:.j)
  //   = assert (let (_,Z:.u) = bounds inp in i>=0 && j-1<=u && i<=j)
  //   $ Scalar (inp :!: i :!: j-1)

  // -- | A 'Primary' together with the lowest included nucleotide and the highest included nucleotide.
  // primaryPR' :: Primary -> DIM2 -> (Scalar (Primary :!: Int :!: Int))
  // primaryPR' inp (Z:.i:.j)
  //   = assert (let (_,Z:.u) = bounds inp in i>=0 && j-2<=u && i<=j)
  //   $ Scalar (inp :!: i :!: j)

  // -- | A 'Primary' together with the lowest included nucleotide and the highest included nucleotide.
  // primaryPL' :: Primary -> DIM2 -> (Scalar (Primary :!: Int :!: Int))
  // primaryPL' inp (Z:.i:.j)
  //   = assert (let (_,Z:.u) = bounds inp in i>0 && j-1<=u && i<=j)
  //   $ Scalar (inp :!: i-1 :!: j-1)

  /*
  lazy val iif = primary ~(3,30,1,maxN)~   weak  ~(1,maxN,3,30)~  primary ^^ iloopIF aggregate hS // hS=min (from 999999)
  lazy val mif = block   ~(1,maxN,1,maxN)~ comps                          ^^ multiIF aggregate hS

  val weak:Tabulate = tabulate("we",
    baseLr     ~(1,1,1,maxN)~   mif      ~(1,maxN,1,1)~   baselR     ^^ multiOF
  | baseLr     ~(1,1,1,maxN)~   iif      ~(1,maxN,1,1)~   baselR     ^^ iloopOF
  | primary    ~(3,3,1,maxN)~   weak     ~(1,maxN,5,31)~  primary    ^^ iloop1NF
  | primary    ~(5,31,1,maxN)~  weak     ~(1,maxN,3,3)~   primary    ^^ iloopN1F
  | baseLr     ~(1,1,1,maxN)~   weak     ~(1,maxN,3,31)~  primary    ^^ bulgeRF
  | primary    ~(3,31,1,maxN)~  weak     ~(1,maxN,1,1)~   baselR     ^^ bulgeLF
  | primaryPR  ~(1,4,1,maxN)~   weak     ~(1,maxN,1,4)~   primaryPL  ^^ tinyloopF
  | baseLr     ~(1,1,1,maxN)~   primary  ~(1,maxN,1,1)~   baselR     ^^ hairpinF
  ) aggregate h filter baseparing)

  val block:Tabulate = tabulate("bl",(
    baseLr ~(1,1,1,maxN)~ weak  ~(1,maxN,1,1)~ baselR ^^ justStemF // adjustStream n
  | base   ~(1,1,1,maxN)~ block                       ^^ regionStemF
  ) aggregate h)

  val comps:Tabulate = tabulate("co",(
    block ~(1,maxN,1,maxN)~ reglen ^^ bsF
  | block ~(1,maxN,1,maxN)~ comps  ^^ bcF
  | block                          ^^ iD
  ) aggregate h)

  val struct:Tabulate = tabulate("st",(
    weak                           ^^ iD
  | base ~(1,1,0,maxN)~    struct  ^^ rSF
  | weak ~(1,maxN,1,maxN)~ struct  ^^ cmF
  | empty                          ^^ nilF
  ) aggregate h filter (constrained (\(Z:.i:.j) -> j==n))
  val axiom = struct
*/

/*
(*~+) = makeLeft_MinRight (3,31) 1
(+~*) = makeMinLeft_Right 1 (3,31)
(&~+) = makeLeft_MinRight (1,4) 1
(+~&) = makeMinLeft_Right 1 (1,4)
(---~+) = makeLeft_MinRight (3,3) 1
(+~@) = makeMinLeft_Right 1 (5,31)
(+~---) = makeMinLeft_Right 1 (3,3)
(@~+) = makeLeft_MinRight (5,31) 1
(#~~) = makeLeft_MinRight (3,30) 1 // The structure on the left is a subword with size 2-28.
(~~#) xs ys = Box mk step xs ys where // The structure on the right is a subword with size 2-30 + inspect the stack an reduce the maximal size
*/

}