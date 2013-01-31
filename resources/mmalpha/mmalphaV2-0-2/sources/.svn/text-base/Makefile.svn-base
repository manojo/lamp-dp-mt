#
#   Main Makefile to compile source files for MMALPHA
#
#   Assumes that environment variables MMALPHA and OSTYPE are set
#
#   The documentation is in $MMALPHA/doc/Developers/Compiling
#
#   make clean -- > cleans some directories
#   make checkvars -- > prints out the values of the variables. May help in case of problem
#   make all -- > makes for all programs put in DIR definition (a few lines under)
#   make Domlib or something else
#

#   If make with no argument, sends a message
nothing:
	@echo "usage: make all"
	@echo "       make clean"
	@echo "       make checkvars"
	@echo "       make Domlib etc... to make one file"

#
# Pretty was added here, otherwise, Write_Alpha does not compile.
# PQ. April 30, 2005
# Note that Pip does not compile properly. Also, Write_C
# uses a kludge...

DIR =   Pretty Read_Alpha Write_Alpha Code_Gen Write_C Domlib
#DIR =   Pretty Domlib Read_Alpha Write_Alpha Code_Gen Pip 
#DIR =   Pretty

# Added Sept. 20 2007. Not sure of it
# Adds a dependence for Read_Alpha. 
# To make it, go in directory, and run make for the makefile in this directory
Read_Alpha: ../lib.$(OSTYPE) ../bin.$(OSTYPE)
	cd Read_Alpha; make

# Added Sept. 20 2007. Not sure of it
# To make it, go in directory, and run make for the makefile in this directory
Write_C: ../lib.$(OSTYPE) ../bin.$(OSTYPE)
	cd Write_C; make

# Added Sept. 20 2007. Not sure of it
# To make it, go in directory, and run make for the makefile in this directory
Write_Alpha: ../lib.$(OSTYPE) ../bin.$(OSTYPE)
	cd Write_Alpha; make

# Added Sept. 20 2007. Not sure of it
# To make it, go in directory, and run make for the makefile in this directory
Domlib: ../lib.$(OSTYPE) ../bin.$(OSTYPE)
	cd Domlib; make

# Added Sept. 20 2007. Not sure of it
# To make it, go in directory, and run make for the makefile in this directory
Pretty: ../lib.$(OSTYPE) ../bin.$(OSTYPE)
	cd Pretty; make

# make all. If a file was touched in a library or a binary
# run all
all: ../lib.$(OSTYPE) ../bin.$(OSTYPE)
	@for file in $(DIR); do \
	  (echo --------------------------------- make $$file ---**; \
	  cd $$file; make ;) \
	done

# make clean. Remove all files in DIR and call make in directory
clean: .phony
	@for file in $(DIR); do \
	  (echo --------------------------------- clean $$file ---; \
	  cd $$file; rm -f *~; make -f Makefile clean;) \
	done;

# create directory ./lib.$(OSTYPE) if needed
../lib.$(OSTYPE):
	mkdir $@

# create directory ./bin.$(OSTYPE) if needed
../bin.$(OSTYPE):
	mkdir $@

# This was added on September 23, 2007 to check the values of variables
checkvars: .phony
	@for file in $(DIR); do \
	  (echo --------------------------------- checkvars $$file ---; \
	  cd $$file; make -f Makefile checkvars;) \
	done;

.phony: 
