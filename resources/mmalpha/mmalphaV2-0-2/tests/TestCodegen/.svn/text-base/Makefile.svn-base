#for EXEC suffix
include ../../sources/MakeIncludes/Makefile.$(OSTYPE)
#SUFFIX=.exe

# This Makefile must be called with the
#  variables FILE and TEST set 
# for instance : make "FILE=MatMult" "TEST=test1" 
# use: make "FILE=MatMult" "TEST=test1" buildTest to buid the test

all	: $(TEST)

################ Generic rules 

%$(SUFFIX): 	%.c
	gcc  $< -o $@

$(TEST)	:	C/$(FILE)$(SUFFIX)
	$< <testFile/$(TEST).in >xyz
	diff  testFile/$(TEST).out xyz

clean: 
	\rm -rf $(FILE)$(EXEC)
	\rm -rf xyz


####used  for building the tests: 
buildTest:	
	gcc  goodC/$(FILE).c -o goodC/$(FILE)$(SUFFIX)
	goodC/$(FILE)$(SUFFIX) <testFile/$(TEST).in >testFile/$(TEST).out
