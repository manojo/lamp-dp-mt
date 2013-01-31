#
# Makefile for automatic tests
#
#

WorkSpace = $(OSTYPE).WorkSpace
CC = gcc

#================================================== 
#
# list of the file witch support all the parser switch
#
AllSwitch = cos3 cosparam mat1 mat2 pile test2 test3 test4 testsqrt strange MV1 boolOperator free


#
# list of the file parsed only with no switch
#
NoOptionOnly = controlbis delay ex1 merge2stream

#
# list of the file parsed only with the switch -s
#
Switch_s_only =
#
# list of the file parsed only with the switch -q
#
Switch_q_only =
#
# list of the file parsed only with the switch -L
#
Switch_L_only = 

NoSwitchFile = $(AllSwitch) $(NoOptionOnly)
Switch_q_file = $(AllSwitch) $(Switch_q_only)
Switch_s_file = $(AllSwitch) $(Switch_s_only)
Switch_L_file = $(AllSwitch) $(Switch_L_only)

#================================================== 
## for test the warning messages of the parser
#
# list of the file witch produce warning messages with all the parser switch
#
WAllSwitch =

#
# list of the file witch produce warning messages with no switch
#
WNoOptionOnly = 

#
# list of the file witch produce warning messages with the switch -s
#
WSwitch_s_only =

#
# list of the file witch produce warning messages with the switch -q
#
WSwitch_q_only = controlbis ex1

#
# list of the file witch produce warning messages with the switch -L
#
WSwitch_L_only = 

WNoSwitchFile = nofile $(WAllSwitch) $(WNoOptionOnly)
WSwitch_q_file = nofile $(WAllSwitch) $(WSwitch_q_only)
WSwitch_s_file = nofile $(WAllSwitch) $(WSwitch_s_only)
WSwitch_L_file = nofile $(WAllSwitch) $(WSwitch_L_only)

#================================================== 
## for test the error messages of the parser
#
# list of the file witch produce error messages with all the parser switch
#
EAllSwitch = free

#
# list of the file witch produce error messages with no switch
#
ENoOptionOnly =

#
# list of the file witch produce error messages with the switch -s
#
ESwitch_s_only = control controlbis delay ex1 merge2stream

#
# list of the file witch produce error messages with the switch -q
#
ESwitch_q_only = control delay merge2stream

#
# list of the file witch produce error messages with the switch -L
#
ESwitch_L_only = control

ENoSwitchFile = nofile $(EAllSwitch) $(ENoOptionOnly)
ESwitch_q_file = nofile $(EAllSwitch) $(ESwitch_q_only)
ESwitch_s_file = nofile $(EAllSwitch) $(ESwitch_s_only)
ESwitch_L_file = nofile $(EAllSwitch) $(ESwitch_L_only)


#
# list of the run test results yet definied and used for reference
#
RunResult :sh= ls *.out # $(File:%=$(WorkSpace)/%.out)

#------------------------------------------------------------------------------
# usage of this makefile
#
#
__usage__:
	@echo "usage: make allTest"
	@echo "       make parseTest"
	@echo "       make compilTest"
	@echo "       make runTest"
	@echo "       make warningTest"
	@echo "       make errorTest"
	@echo "       make updateOutputResults"
	@echo "       make clean"
	@echo ""
	@echo " allTest    : execute parseTest, compilTest, runTest, warningTest, errorTest"
	@echo
	@echo " parseTest  : parses the alpha programs with the different switchs (-s, -q, -L)"
	@echo " compilTest : compils the C files"
	@echo " runTest    : executes the file parse with the swith -q"
	@echo
	@echo " warningTest: tests the warning messages of the parser"
	@echo " errorTest  : tests the error messages of the parser"
	@echo
	@echo " updateOutputResults:"
	@echo "              replaces the refence results by the new results"
	@echo
	@echo " clean      : remove the work directory"
	@echo ""

#------------------------------------------------------------------------------
# runs all the tests
#
allTest: $(MMALPHA)/bin.$(OSTYPE)/write_c
	@echo "**************************************** parser tests ***"
	@make parseTest
	@echo
	@echo "**************************************** compil tests ***"
	@make compilTest
	@echo
	@echo "**************************************** runtime tests **"
	@make runTest
	@echo
	@echo "**************************************** warning tests **"
	@make warningTest
	@echo
	@echo "****************************************** error tests **"
	@make errorTest
	@echo

#------------------------------------------------------------------------------
# tests all the parser switch
#
parseTest: $(MMALPHA)/bin.$(OSTYPE)/write_c
	@echo "===================== tests parser with no switch ======="
	@make $(NoSwitchFile:%=$(WorkSpace)/%.c) 
	@echo
	@echo "===================== tests parser with the switch -q ===="
	@make $(Switch_q_file:%=$(WorkSpace)/%.q.c)
	@echo
	@echo "===================== tests parser with the switch -s ===="
	@make $(Switch_s_file:%=$(WorkSpace)/%.s.c)
	@echo
	@echo "===================== tests parser with the switch -L ===="
	@make $(Switch_L_file:%=$(WorkSpace)/%.nl.c)

#------------------------------------------------------------------------------
# tests the result of the parser: compil all the C file
#
compilTest: $(MMALPHA)/bin.$(OSTYPE)/write_c
	@echo "===================== compil file parsed with no switch =="
	@make $(NoSwitchFile:%=$(WorkSpace)/%)
	@echo
	@echo "===================== compil file parsed with switch -q =="
	@make $(Switch_q_file:%=$(WorkSpace)/%.q)
	@echo
	@echo "===================== compil file parsed with switch -s =="
	@make $(Switch_s_file:%=$(WorkSpace)/%.s.o)
	@echo
	@echo "===================== compil file parsed with switch -L =="
	@make $(Switch_L_file:%=$(WorkSpace)/%.nl)



#------------------------------------------------------------------------------
# tests the warning messages of the parser
#
warningTest: $(MMALPHA)/bin.$(OSTYPE)/write_c
	@echo "============== tests parser warning with no switch ======="
	@make $(WNoSwitchFile:%=$(WorkSpace)/%.w.c) 
	@echo
	@echo "============= tests parser warning with the switch -q ===="
	@make $(WSwitch_q_file:%=$(WorkSpace)/%.q.w.c)
	@echo
	@echo "============= tests parser warning with the switch -s ===="
	@make $(WSwitch_s_file:%=$(WorkSpace)/%.s.w.c)
	@echo
	@echo "============= tests parser warning with the switch -L ===="
	@make $(WSwitch_L_file:%=$(WorkSpace)/%.nl.w.c)

errorTest:  $(MMALPHA)/bin.$(OSTYPE)/write_c
	@echo "================ tests parser error with no switch ======="
	@make $(ENoSwitchFile:%=$(WorkSpace)/%.e.c) 
	@echo
	@echo "=============== tests parser error with the switch -q ===="
	@make $(ESwitch_q_file:%=$(WorkSpace)/%.q.e.c)
	@echo
	@echo "=============== tests parser error with the switch -s ===="
	@make $(ESwitch_s_file:%=$(WorkSpace)/%.s.e.c)
	@echo
	@echo "=============== tests parser error with the switch -L ===="
	@make $(ESwitch_L_file:%=$(WorkSpace)/%.nl.e.c)



$(WorkSpace)/%: $(WorkSpace)/%.c
	@echo ---------------------------------------- compil $*
	@$(CC) -g $< -lm -o $@

%.c.diff: $(WorkSpace)/%.c
	-diff $*.c $<


#------------------------------------------------------------------------------
# tests with no switch
#
$(WorkSpace)/%.c: %.alpha $(WorkSpace) $(MMALPHA)/bin.$(OSTYPE)/write_c
	@echo ---------------------------------------- write_c $<
	@read_alpha < $< | write_c -o $@
	@echo


#------------------------------------------------------------------------------
# tests the switch -L: no loop nest for the input variables
#
$(WorkSpace)/%.nl.c: %.alpha $(WorkSpace) $(MMALPHA)/bin.$(OSTYPE)/write_c
	@echo ---------------------------------------- write_c -L $<
	@read_alpha < $< | write_c -L -o $@
	@echo


#------------------------------------------------------------------------------
#  tests the switch -s
#
$(WorkSpace)/%.s.c: %.alpha $(WorkSpace) $(MMALPHA)/bin.$(OSTYPE)/write_c
	@echo ---------------------------------------- write_c -s $<
	@read_alpha < $< | write_c -s -o $@
	@echo

$(WorkSpace)/%.s.o: $(WorkSpace)/%.s.c
	@echo ---------------------------------------- compil $*
	@$(CC) -c -g -o $@ $< 



#------------------------------------------------------------------------------
#  for make run time tests
#  In the same time, tests the swicth -q
#
runTest: $(RunResult:%=$(WorkSpace)/%)

$(WorkSpace)/%.out: $(WorkSpace)/%.q
	@echo ---------------------------------------- run test for $*
	@if test -f $*.in; then \
	  $< < $*.in > $@; \
        else \
	  $< > $@; \
	fi
	-diff $*.out $@

#------------------------------------------------------------------------------# for multiple run test for on executable file
#
# the first result test is named <runfile>.out
# the other must be named <runfile>.n.out (1 <= 1 <= 9)
#
$(WorkSpace)/%.1.q: $(WorkSpace)/%.q
	@rm -f $@
	@ln -s $*.q $@
$(WorkSpace)/%.2.q: $(WorkSpace)/%.q
	@rm -f $@
	@ln -s $*.q $@
$(WorkSpace)/%.3.q: $(WorkSpace)/%.q
	@rm -f $@
	@ln -s $*.q $@
$(WorkSpace)/%.4.q: $(WorkSpace)/%.q
	@rm -f $@
	@ln -s $*.q $@
$(WorkSpace)/%.5.q: $(WorkSpace)/%.q
	@rm -f $@
	@ln -s $*.q $@
$(WorkSpace)/%.6.q: $(WorkSpace)/%.q
	@rm -f $@
	@ln -s $*.q $@
$(WorkSpace)/%.7.q: $(WorkSpace)/%.q
	@rm -f $@
	@ln -s $*.q $@
$(WorkSpace)/%.8.q: $(WorkSpace)/%.q
	@rm -f $@
	@ln -s $*.q $@
$(WorkSpace)/%.9.q: $(WorkSpace)/%.q
	@rm -f $@
	@ln -s $*.q $@



#------------------------------------------------------------------------------
# quiet programs (no prompt for the input or the output)
#
$(WorkSpace)/%.q.c: %.alpha $(WorkSpace) $(MMALPHA)/bin.$(OSTYPE)/write_c
	@echo ---------------------------------------- write_c -q $<
	@read_alpha < $< | write_c -q -o $@
	@@echo

#=========================================================== Warning tests ====
#------------------------------------------------------------------------------
# tests with no switch
#
$(WorkSpace)/%.w.c: %.alpha $(WorkSpace) $(MMALPHA)/bin.$(OSTYPE)/write_c
	@echo ++++++++++++++++++++++++++++++++ a warning message must appear 
	@echo ---------------------------------------- write_c $<
	@read_alpha < $< | write_c -o $@
	@echo


#------------------------------------------------------------------------------
# tests the switch -L: no loop nest for the input variables
#
$(WorkSpace)/%.nl.w.c: %.alpha $(WorkSpace) $(MMALPHA)/bin.$(OSTYPE)/write_c
	@echo ++++++++++++++++++++++++++++++++ a warning message must appear 
	@echo ---------------------------------------- write_c -L $<
	@read_alpha < $< | write_c -L -o $@
	@echo
#------------------------------------------------------------------------------
# quiet programs (no prompt for the input or the output)
#
$(WorkSpace)/%.q.w.c: %.alpha $(WorkSpace) $(MMALPHA)/bin.$(OSTYPE)/write_c
	@echo ++++++++++++++++++++++++++++++++ a warning message must appear 
	@echo ---------------------------------------- write_c -q $<
	@read_alpha < $< | write_c -q -o $@
	@@echo

#------------------------------------------------------------------------------
#  tests the switch -s
#
$(WorkSpace)/%.s.w.c: %.alpha $(WorkSpace) $(MMALPHA)/bin.$(OSTYPE)/write_c
	@echo ++++++++++++++++++++++++++++++++ a warning message must appear 
	@echo ---------------------------------------- write_c -s $<
	@read_alpha < $< | write_c -s -o $@
	@echo

#============================================================= Error tests ====
#------------------------------------------------------------------------------
# tests with no switch
#
$(WorkSpace)/%.e.c: %.alpha $(WorkSpace) $(MMALPHA)/bin.$(OSTYPE)/write_c
	@echo ++++++++++++++++++++++++++++++++ a error message must appear 
	@echo ---------------------------------------- write_c $<
	@@if read_alpha < $< | write_c -L -o $@; then \
	  echo ; \
	  echo "\07****************************************** No ERROR"; \
	fi
	@echo


#------------------------------------------------------------------------------
# tests the switch -L: no loop nest for the input variables
#
$(WorkSpace)/%.nl.e.c: %.alpha $(WorkSpace) $(MMALPHA)/bin.$(OSTYPE)/write_c
	@echo ++++++++++++++++++++++++++++++++ a error message must appear 
	@echo ---------------------------------------- write_c -s $<
	@@if read_alpha < $< | write_c -L -o $@; then \
	  echo ; \
	  echo "\07****************************************** No ERROR"; \
	fi
	@echo
#------------------------------------------------------------------------------
# quiet programs (no prompt for the input or the output)
#
$(WorkSpace)/%.q.e.c: %.alpha $(WorkSpace) $(MMALPHA)/bin.$(OSTYPE)/write_c
	@echo ++++++++++++++++++++++++++++++++ a error message must appear 
	@echo ---------------------------------------- comput quiet file for $<
	@@if read_alpha < $< | write_c -q -o $@; then \
	  echo ; \
	  echo "\07****************************************** No ERROR"; \
	fi
	@@echo

#------------------------------------------------------------------------------
#  tests the switch -s
#
$(WorkSpace)/%.s.e.c: %.alpha $(WorkSpace) $(MMALPHA)/bin.$(OSTYPE)/write_c
	@echo ++++++++++++++++++++++++++++++++ a error message must appear 
	@echo ---------------------------------------- write_c -s $<
	@@if read_alpha < $< | write_c -s -o $@; then \
	  echo ; \
	  echo "\07****************************************** No ERROR"; \
	fi
	@echo


$(WorkSpace)/nofile%.w.c:
	@echo "nothing to do for " > $@
$(WorkSpace)/nofile%.e.c:
	@echo "nothing to do for " > $@


###############################################################################
updateOutputResults: runTest
	rm -f *.out
	cp $(WorkSpace)/*.out .

$(WorkSpace):
	@mkdir $(WorkSpace)

clean:
	rm -fr $(WorkSpace)


###############################################################################
#   for special test
#
#------------------------------------------------------------------------------
#  free.alpha is a system with one parameter => write_c needs the switch -p
#
#
$(WorkSpace)/free.c: free.alpha $(WorkSpace) $(MMALPHA)/bin.$(OSTYPE)/write_c
	@echo ---------------------------------------- write_c -p 10 free
	@rm -f $@
	@read_alpha < free.alpha | write_c -p 10 -o $@
	@echo
$(WorkSpace)/free.q.c: free.alpha $(WorkSpace) $(MMALPHA)/bin.$(OSTYPE)/write_c
	@echo ---------------------------------------- write_c -q -p 10 free
	@rm -f $@
	@read_alpha < free.alpha | write_c -q -p 10 -o $@
	@@echo
$(WorkSpace)/free.s.c: free.alpha $(WorkSpace) $(MMALPHA)/bin.$(OSTYPE)/write_c
	@echo ---------------------------------------- write_c-s -p 10 free
	@rm -f $@
	@read_alpha < free.alpha | write_c -s -p 10 -o $@
	@echo
$(WorkSpace)/free.nl.c: free.alpha $(WorkSpace) $(MMALPHA)/bin.$(OSTYPE)/write_c
	@echo ---------------------------------------- write_c -L -p 10 free
	@rm -f $@
	@read_alpha < free.alpha | write_c -L -p 10 -o $@
	@echo

# end of the Makefile
