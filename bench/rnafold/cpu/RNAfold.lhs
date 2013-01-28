#import stdlib.adp

> #algebratype{
> 
> type FS_Algebra base comp = (   
>             base -> comp -> comp ,  -- sadd
> 	    comp -> comp -> comp ,  -- cadd
> 
> 	     base -> comp -> base -> comp, --is
> 	     base -> comp -> base -> comp, --sr
> 	     base -> base -> (Int,Int) -> base -> base         -> comp,   --hl
> 	     base -> base -> (Int,Int) -> comp -> base -> base -> comp,   --bl
> 	     base -> base -> comp -> (Int,Int) -> base -> base -> comp,   --br
> 
> 	     base -> base -> (Int,Int) -> comp -> (Int,Int) -> base -> base -> comp, --il
> 	     base -> base -> base         -> comp -> base         -> base -> base -> comp,  --il11 
> 	     base -> base -> base         -> comp -> base -> base -> base -> base -> comp,  --il12 
> 	     base -> base -> base -> base -> comp         -> base -> base -> base -> comp,  --il21 
> 	     base -> base -> base -> base -> comp -> base -> base -> base -> base -> comp,  --il22 
> 
> 	     base-> base->         comp        -> base-> base -> comp,--ml
> 	     base-> base-> base -> comp 	    -> base-> base -> comp,--mldl
> 	     base-> base->         comp -> base-> base-> base -> comp,--mldr
> 	     base-> base-> base -> comp -> base-> base-> base -> comp,--mldlr
> 
> 	     base -> comp -> base -> comp, --dl
> 	     base -> comp -> base -> comp, --dr
> 	     base -> comp -> base -> comp, --dlr
> 	     base -> comp -> base -> comp, --edl
> 	     base -> comp -> base -> comp, --edr
> 	     base -> comp -> base -> comp, --edlr
> 	     comp -> comp,		   -- drem
> 	     comp -> comp -> comp,     -- cons (in fact it is append)
> 	     comp ->  comp,	       -- ul
> 	     comp ->  comp,	       -- pul
> 	     comp -> (Int,Int) -> comp,   -- addss
> 	     (Int,Int) -> comp -> comp,   -- ssadd
> 
> 	     base -> comp,  --nil
>              comp -> comp -> comp, --combine
> 	     [comp] -> [comp]  --h
> 	   ) 	      	     
>  
> }

> #extern termaupenalty :: (Int, Int) -> Int
> #extern sr_energy :: (Int, Int) -> Int
> #extern hl_energy :: (Int, Int) -> Int
> #extern bl_energy :: (Int, Int, Int, Int) -> Int
> #extern br_energy :: (Int, Int, Int, Int) -> Int
> #extern il_energy :: (Int, Int, Int, Int) -> Int
> #extern il11_energy :: Int -> Int -> Int
> #extern il21_energy :: Int -> Int -> Int
> #extern il12_energy :: Int -> Int -> Int
> #extern il22_energy :: Int -> Int -> Int
> #extern dli_energy  :: (Int, Int) -> Int
> #extern dri_energy  :: (Int, Int) -> Int
> #extern dl_energy  :: (Int, Int) -> Int
> #extern dr_energy  :: (Int, Int) -> Int
> #extern ss_energy :: (Int, Int) -> Int

> #algebra[mfe]{
> 
>  mfe :: FS_Algebra Int Int 
>  mfe =  (sadd,cadd,is,sr,hl,bl,br, il, il11, il12, il21, il22, 
> 	         ml, mldl, mldr, mldlr, dl, dr, dlr, edl, edr, edlr,
> 	         drem, cons, ul, pul, addss, ssadd, nil, combine, h) where
>       sadd  lb e = e 
>       cadd  e1 e = e1 + e
>       
>       is  lloc     e rloc    = e  + termaupenalty(lloc+1,rloc) 
>       sr  lb       e rb     = e + sr_energy (lb,rb) 
>       hl  llb lb _   rb rrb =     hl_energy (lb,rb) + sr_energy (llb,rrb) 
>       bl  llb bl1 (i,j) e br rrb = e + bl_energy (bl1,i,j,br) + sr_energy (llb,rrb)
>       br  llb bl e (i,j) br1 rrb = e + br_energy (bl,i,j,br1) + sr_energy (llb,rrb)
>       
>       il llb lb (i,j) e (k,l) rb rrb    = e + sr_energy (llb,rrb) + il_energy (i,j,k,l)
>       il11  lllb  llb     lb e rb       rrb rrrb = e + il11_energy llb  rrb  + sr_energy (lllb , rrrb)
>       il21 llllb lllb llb lb e rb       rrb rrrb = e + il21_energy lllb rrb  + sr_energy (llllb, rrrb)
>       il12  lllb  llb     lb e rb rrb rrrb rrrrb = e + il12_energy llb  rrrb + sr_energy (lllb ,rrrrb)
>       il22 llllb lllb llb lb e rb rrb rrrb rrrrb = e + il22_energy lllb rrrb + sr_energy (llllb,rrrrb)
>       
>       ml    llb bl    e    br rrb = 380 + e + sr_energy (llb,rrb) + termaupenalty(bl,br)
>       mldl  llb bl dl e    br rrb = 380 + e + dli_energy (bl,br) + sr_energy (llb,rrb) + termaupenalty(bl,br)
>       mldr  llb bl    e dr br rrb = 380 + e + dri_energy (bl,br) + sr_energy (llb,rrb) + termaupenalty(bl,br)
>       mldlr llb bl dl e dr br rrb = 380 + e + dli_energy (bl,br) + dri_energy (bl,br) + sr_energy (llb,rrb) + termaupenalty(bl,br)
>       dl    dl1 e rloc = e + dl_energy (dl1+1,rloc)
>       dr  lloc e dr1   = e + dr_energy (lloc+1,dr1-1)
>       dlr   dl e dr   = e + dl_energy (dl+1,dr-1) + dr_energy (dl+1,dr-1)
>       edl   dl e rloc = e + dl_energy (dl+1,rloc) + termaupenalty(dl+1,rloc)
>       edr lloc e dr   = e + dr_energy (lloc+1,dr-1) + termaupenalty(lloc+1,dr-1)
>       edlr  dl e dr   = e + dl_energy (dl+1,dr-1) + dr_energy (dl+1,dr-1) + termaupenalty(dl+1,dr-1)
>       drem     e      = e 
>       
>       cons  e1 e   = e1 + e
>       ul       e   = 40 + e
>       pul      e   =      e
>       addss    e (i,j) =      e + ss_energy (i,j)
>       ssadd (i,j)  e   = 40 + e + ss_energy (i,j)
>       nil _ = 0
>       combine  a b     = a + b
>       
>       h   es = [minimum es]
> }

> #extern dots :: (Int,Int) -> String

> #algebra[pp]{
> 
>       pp :: FS_Algebra Int String 
>       pp =   (sadd,cadd,is,sr,hl,bl,br, il, il11, il12, il21, il22, 
>       	   ml, mldl, mldr, mldlr, dl, dr, dlr, edl, edr, edlr,
>       	   drem, cons, ul, pul, addss, ssadd, nil, combine, h) where
>       sadd  lb e = "." ++ e
>       cadd  x  e = x ++ e
>       
>       is _ x _ = x
>       sr  lb e rb = "(" ++ e ++ ")"	
>       hl  llb lb (i,j)   rb rrb = "((" ++ dots (i,j) ++"))"	
>       bl  llb bl (i,j) e br rrb = "((" ++ dots (i,j) ++ e ++"))"
>       br  llb bl e (i,j) br rrb = "((" ++ e ++ dots (i,j) ++"))"
>       
>       il   llb lb (i1,j1) x (i2,j2) rb rrb = "((" ++ dots (i1,j1)  ++ x ++ dots (i2,j2) ++ "))" 
>       il11 _ _ _   x   _ _ _   = "((."  ++ x ++  ".))"
>       il12 _ _ _   x _ _ _ _   = "((."  ++ x ++ "..))"
>       il21 _ _ _ _ x   _ _ _   = "((.." ++ x ++  ".))"
>       il22 _ _ _ _ x _ _ _ _   = "((.." ++ x ++ "..))"
>       
>       ml    llb bl    x    br rrb = "((" ++ x ++ "))" 
>       mldl  llb bl dl x    br rrb = "((."++ x ++ "))"
>       mldr  llb bl    x dr br rrb = "((" ++ x ++ ".))" 
>       mldlr llb bl dl x dr br rrb = "((."++ x ++ ".))"
>       dl    dl x _  = "." ++ x	  
>       dr    _  x dr =       x  ++"."	  
>       dlr   dl x dr = "." ++ x ++"."	  
>       edl   dl x _  = "." ++ x	  
>       edr   _  x dr =        x ++"."	  
>       edlr  dl x dr = "." ++ x ++"."	       
>       drem     x    = x	  
>       
>       cons  c1 c = c1 ++ c
>       ul  c1 = c1
>       pul  c1 = c1
>       addss  c1 (i,j) = c1 ++ dots (i,j)
>       ssadd  (i,j) x = dots (i,j) ++ x		
>       nil _ = "" 
>       combine  a b     = a ++ b
>       
>       h es = [id es] 
> }

> #extern lbase :: Parser Int
> #extern loc :: Parser Int
> #extern stackpairing :: Filter

> #grammar{

> rnafold alg f = axiom struct where
>    (sadd,cadd,is,sr,hl,bl,br, il, il11, il12, il21, il22, ml, mldl, mldr, mldlr, dl, dr, dlr, edl, edr, edlr, drem, cons, ul, pul, addss, ssadd, nil, combine, h) = alg

>    struct        = tabulated (
> 	              sadd <<< lbase    ~~~ struct |||
>                     cadd  <<< initstem ~~~ struct |||
>                     nil  <<< empty ... h) 
> 
>    initstem = tabulated (is <<< loc ~~~ closed ~~~ loc ... h)
>    closed   = tabulated (
> 		     stack ||| ((hairpin ||| leftB   ||| rightB ||| iloop  ||| multiloop) `with` stackpairing) ... h)
> 
>    stack     = (sr   <<< lbase ~~~ closed ~~~ lbase)  `with` basepairing ... h
>    hairpin   = hl   <<< lbase ~~~ lbase ~~~ (region `with` (minsize 3))        ~~~ lbase ~~~ lbase ... h
>    leftB     = bl   <<< lbase ~~~ lbase ~~~ region   ~~~ initstem   ~~~ lbase ~~~ lbase ... h
>    rightB    = br   <<< lbase ~~~ lbase ~~~ initstem ~~~ region     ~~~ lbase ~~~ lbase ... h
>    iloop     = il   <<< lbase ~~~ lbase ~~~ (region  `with` (maxsize 30))      ~~~ closed ~~~ 
> 	                                       (region  `with` (maxsize 30))      ~~~ lbase ~~~ lbase ... h
>    multiloop = mldl  <<< lbase ~~~ lbase ~~~ lbase ~~~ ml_components           ~~~ lbase ~~~ lbase |||
>                  mldr  <<< lbase ~~~ lbase ~~~ 	  ml_components ~~~ lbase    ~~~ lbase ~~~ lbase |||
>                  mldlr <<< lbase ~~~ lbase ~~~ lbase ~~~ ml_components ~~~ lbase ~~~ lbase ~~~ lbase |||
>                  ml    <<< lbase ~~~ lbase ~~~ 	  ml_components              ~~~ lbase ~~~ lbase ... h
>    ml_components = combine <<< block ~~~ comps ... h
>    comps     = tabulated (
> 	          cons  <<< block ~~~ comps    |||
>                   block                        |||
>                   addss <<< block ~~~ region   ... h)
> 
>    block    = tabulated (
> 	         ul      <<<		initstem    |||
> 	         ssadd   <<< region ~~~ initstem    ... h)
> 
> }


