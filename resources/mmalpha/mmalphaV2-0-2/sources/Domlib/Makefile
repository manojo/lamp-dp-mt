# To compile domlib with cygwin, you need Visual C++ installed on the machine
# Otherwise it should be OK with gcc

# Modification done here by P. Quinton, April 30, 2005. Instead of calling 
# systematically Makefile.linux, the suffix depends on the OS type. This
# modification was done for Mac OS X
#
# This makefile

all:	
	@if [ "${OSTYPE}" = "cygwin" ]; then make -f Makefile.Visual  ; else  make -f Makefile.${OSTYPE} ; fi

# Same modification here
clean:
	@if [ "${OSTYPE}" = "cygwin" ]; then make -f Makefile.Visual clean ; else  make -f Makefile.${OSTYPE} clean ; fi

# Added checkvars. 
checkvars: .phony
	if [ "${OSTYPE}" = "cygwin" ]; then make -f Makefile.Visual checkvars ; else  make -f Makefile.${OSTYPE} checkvars ; fi

.phony: