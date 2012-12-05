class RNALib(parameters:String) {
	
	@native def loadParams(file:String):Unit
	@native def loadSequence(seq:String):Unit
	@native def clearSequence:Unit
	@native def clearParams:Unit

	@native def termau_energy(i:Int, j:Int):Int
	@native def hl_energy(i:Int, j:Int):Int
	@native def hl_energy_stem(i:Int, j:Int):Int
	@native def il_energy(i:Int, j:Int, k:Int, l:Int):Int
	@native def bl_energy(bl:Int, i:Int, j:Int, br:Int, Xright:Int):Int
	@native def br_energy(bl:Int, i:Int, j:Int, br:Int, Xleft:Int):Int
	@native def sr_energy(i:Int, j:Int):Int
	@native def sr_pk_energy(a:Char, b:Char, c:Char, d:Char):Int
	@native def dl_energy(i:Int, j:Int):Int
	@native def dr_energy(i:Int, j:Int, n:Int):Int
	@native def dli_energy(i:Int, j:Int):Int
	@native def dri_energy(i:Int, j:Int):Int
	@native def ext_mismatch_energy(i:Int, j:Int, n:Int):Int
	@native def ml_mismatch_energy(i:Int, j:Int):Int
	@native def ml_energy:Int
	@native def ul_energy:Int
	@native def sbase_energy:Int
	@native def ss_energy(i:Int, j:Int):Int

	/*
	//for MacroState partition function
	int dl_dangle_dg(enum base_t dangle, enum base_t i, enum base_t j);
	int dr_dangle_dg(enum base_t i, enum base_t j, enum base_t dangle);

	// not in rna.hh
	double mk_pf(double x);
	double scale(int x);

	bool iupac_match(char base, char iupac_base);
	*/
}


