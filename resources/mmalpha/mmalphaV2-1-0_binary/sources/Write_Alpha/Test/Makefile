# run "make -i" to ignore all failures and see all of the results

all	: all_tests

all_tests : general_tests array_tests
	-@rm -f xyz 
	@echo "\n----------------------------------------------------"
	@echo "All tests successful"
	@echo "----------------------------------------------------"


#=====================================================================
general_tests :  
	make OPTIONS=	 dom1.test 
	@echo "general tests successful"

array_tests :  
	make OPTIONS=-a red1.test 
	@echo "general tests successful"

#supressed:  san1 san2 san3 w1 red1 convertc mathead index R5 z1 
# (source files missing) 
# durbin w1 not correct alpha files 

general_greeting :
	@echo "\n----------------------------------------------------"
	@echo "Begin general tests"
	@echo "----------------------------------------------------"


%.test: %.ast
	write_alpha $(OPTIONS) -i $< -o xyz 
	diff -w xyz $(<:.ast=.alpha)
