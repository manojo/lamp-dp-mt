# uncomment to ignore all failures and see all of the results
#.IGNORE
SHELL=/usr/bin/sh

all_tests : general_tests
	-@\rm -f xyz
	@echo "\n----------------------------------------------------"
	@echo "All tests successful"
	@echo "----------------------------------------------------"


#=====================================================================
general_tests : general_greeting fs inorm test2 test4 durbin
	@echo "general tests successful"

general_greeting :
	@echo "\n----------------------------------------------------"
	@echo "Begin general tests"
	@echo "----------------------------------------------------"
	@echo "Sorry, Tests are not available...."

fs :
	read_alpha <fs.alpha >fs.ast
	code_gen -p 10 <fs.ast 1>xyz 2>&1
	diff xyz fs.c

inorm :
	read_alpha -L <inorm.inf.alpha >inorm.ast
	code_gen <inorm.ast 1>xyz 2>&1
	diff xyz inorm.c

test2 :
	read_alpha -L <test2.inf.alpha >test2.ast
	code_gen <test2.ast 1>xyz 2>&1
	diff xyz test2.c

test4 :
	read_alpha -L <test4.inf.alpha >test4.ast
	code_gen <test4.ast 1>xyz 2>&1
	diff xyz test4.c

durbin :
	read_alpha -L <durbin.inf.alpha >durbin.inf.ast
	code_gen -p 2 <durbin.inf.ast 1>xyz 2>&1
	diff xyz durbin.c
