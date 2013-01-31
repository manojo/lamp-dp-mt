# Generated automatically from Makefile.in by configure.
#
#  /**-------------------------------------------------------------------**
#   **                            PIP/PipLib                             **
#   **-------------------------------------------------------------------**
#   **                           makefile.in                             **
#   **-------------------------------------------------------------------**
#   **                   First version: july 28th 2001                   **
#   **-------------------------------------------------------------------**/
#
# makefile.in (or makefile if generated) of PIP/PipLib. makefile.in is not a
# makefile, you must run the 'configure' shellscript to generate the makefile
# thanks to this file.


#/*****************************************************************************
# *                     Variables substituted with configure                  *
# *****************************************************************************/

#             PipLib's version.
VERSION     = 1.3.3
#             versions to compile.
TO_BUILD    =  64 
#             Target architecture and system
TARGET      = i686-apple-darwin8.10.1
#             C compiler.
CC          = gcc
#             Tool to create symbolic links.
LN_S        = ln -s
#             Tool to provide speed access to archives.
RANLIB      = ranlib
#             Shared library extension 
SHEXT       = so
#             Executable suffix 
EXEC_SUFFIX = 
#             Extra flags
EXTRA_FLAGS = 
#             Extra libraries
EXTRA_LIBS  = 
#             Extra includes
EXTRA_INC   = 
#             Bits for integers
INT_BITS    = 32
#             Flags fos integers
INT_DFLAGS  = -DLINEAR_VALUE_IS_INT
#             Bits for long long
LONG_BITS   = 64
#             Flags for long long
LONG_DFLAGS = -DLINEAR_VALUE_IS_LONGLONG
#             Bits for mp
MP_BITS     = MP
#             Flags for mp
MP_DFLAGS   = -DLINEAR_VALUE_IS_MP
#             Architecture-independent installation directory.     
prefix      = /Users/quinton/mmalpha/sources/Pip
#             Architecture-dependent installation directory.     
exec_prefix = ${prefix}
#             Installation software. 
INSTALL     = /usr/bin/install -c
#             Packages to build.         
PACKAGES    = piplibshared piplibstatic pip
#             Packages to install.
TO_INSTALL  = install_piplibshared install_piplibstatic install_pip


#/*****************************************************************************
# *                            PipLib's variables                             *
# *****************************************************************************/


# Directory of PipLib's sources (.c).
PIPLIB_SRC = ./source
# Directory of PipLib's include (.h).
PIPLIB_INC = ./include
# Directory for object files and software and library before installation, its
# name depends on architecture and on operating system.
PIPLIB_OBJ = ./obj$(BITS)_$(TARGET)
# PipLib's installation subdirectories.
PIPLIB_INS_BIN = $(exec_prefix)/bin
PIPLIB_INS_LIB = $(exec_prefix)/lib
PIPLIB_INS_INC = $(prefix)/include


#/*****************************************************************************
# *                         Compiler and linker options                       *
# *****************************************************************************/


INCFLAGS = -I $(PIPLIB_INC) $(EXTRA_INC)
LDFLAGS  = $(EXTRA_LIBS)
CFLAGS   = -c $(INCFLAGS) -fomit-frame-pointer -O2 $(EXTRA_FLAGS) $(DFLAGS)


#/*****************************************************************************
# *                                   Rules                                   *
# *****************************************************************************/


# objects for libraries making
OBJL =  $(PIPLIB_OBJ)/piplib.o $(PIPLIB_OBJ)/integrer.o $(PIPLIB_OBJ)/tab.o \
	 $(PIPLIB_OBJ)/traiter.o $(PIPLIB_OBJ)/sol.o 

# objects for software making
OBJ = $(PIPLIB_OBJ)/maind.o $(OBJL)

all : $(TO_BUILD:%=%all)

$(INT_BITS)all :
	@echo "-----"
	@echo "Making all for" $(INT_BITS) "bits version."
	$(MAKE) "BITS=$(INT_BITS)" "DFLAGS=$(INT_DFLAGS)" tobuild

$(LONG_BITS)all :
	@echo "-----"
	@echo "Making all for" $(LONG_BITS) "bits version."
	$(MAKE) "BITS=$(LONG_BITS)" "DFLAGS=$(LONG_DFLAGS)" tobuild
	
$(MP_BITS)all :
	@echo "-----"
	@echo "Making all for" $(MP_BITS) "version."
	$(MAKE) "BITS=$(MP_BITS)" "DFLAGS=$(MP_DFLAGS)" tobuild
	
tobuild : $(PACKAGES)

pip : $(PIPLIB_OBJ) $(OBJ)
	@echo "             /*-----------------------------------------------*"
	@echo "              *                 MAKING PIP                    *"
	@echo "              *-----------------------------------------------*/"
	$(CC) $(OBJ) -o $(PIPLIB_OBJ)/pip$(BITS)$(EXEC_SUFFIX) $(LDFLAGS)

piplibshared : $(PIPLIB_OBJ) $(OBJ)
	@echo "             /*-----------------------------------------------*"
	@echo "              *              MAKING PipLib (shared)           *"
	@echo "              *-----------------------------------------------*/"
	$(LD) $(OBJL) -o $(PIPLIB_OBJ)/libpiplib$(BITS).$(SHEXT).$(VERSION) \
	-lc -shared -fPIC $(LDFLAGS)
	$(LDCONFIG)

piplibstatic: $(PIPLIB_OBJ) $(OBJ)
	@echo "             /*-----------------------------------------------*"
	@echo "              *            MAKING PipLib (static lib)         *"
	@echo "              *-----------------------------------------------*/"
	$(AR) q $(PIPLIB_OBJ)/libpiplib$(BITS).a.$(VERSION) $(OBJL)
	$(RANLIB) $(PIPLIB_OBJ)/libpiplib$(BITS).a.$(VERSION)

$(PIPLIB_OBJ)/piplib.o : $(PIPLIB_SRC)/piplib.c $(PIPLIB_INC)/piplib/piplib.h
	$(CC) $(CFLAGS) $(PIPLIB_SRC)/piplib.c \
	-o $(PIPLIB_OBJ)/piplib.o

$(PIPLIB_OBJ)/integrer.o : $(PIPLIB_SRC)/integrer.c \
	$(PIPLIB_INC)/piplib/piplib.h
	$(CC) $(CFLAGS) $(PIPLIB_SRC)/integrer.c \
	-o $(PIPLIB_OBJ)/integrer.o

$(PIPLIB_OBJ)/maind.o : $(PIPLIB_SRC)/maind.c $(PIPLIB_INC)/piplib/piplib.h
	$(CC) $(CFLAGS) $(PIPLIB_SRC)/maind.c \
	-o $(PIPLIB_OBJ)/maind.o

$(PIPLIB_OBJ)/tab.o : $(PIPLIB_SRC)/tab.c $(PIPLIB_INC)/piplib/piplib.h
	$(CC) $(CFLAGS)  $(PIPLIB_SRC)/tab.c \
	-o $(PIPLIB_OBJ)/tab.o

$(PIPLIB_OBJ)/traiter.o : $(PIPLIB_SRC)/traiter.c $(PIPLIB_INC)/piplib/piplib.h
	$(CC) $(CFLAGS)  $(PIPLIB_SRC)/traiter.c \
	-o $(PIPLIB_OBJ)/traiter.o

$(PIPLIB_OBJ)/sol.o : $(PIPLIB_SRC)/sol.c $(PIPLIB_INC)/piplib/piplib.h
	$(CC) $(CFLAGS)  $(PIPLIB_SRC)/sol.c \
	-o $(PIPLIB_OBJ)/sol.o


$(PIPLIB_OBJ):
	$(INSTALL) -d $(PIPLIB_OBJ)
	

clean :
	@echo "             /*-----------------------------------------------*"
	@echo "              *               CLEANING PIP/PipLib             *"
	@echo "              *-----------------------------------------------*/"
	$(RM) -rf obj*

distclean: clean
	@echo "             /*-----------------------------------------------*"
	@echo "              *             DISTCLEANING PIP/PipLib           *"
	@echo "              *-----------------------------------------------*/"
	$(RM) -f config.cache config.log config.status Makefile


install:: $(TO_BUILD:%=%install)

$(INT_BITS)install :
	@echo "-----"
	@echo "Installing all for" $(INT_BITS) "bits version."
	$(MAKE) "BITS=$(INT_BITS)" "DFLAGS=$(INT_DFLAGS)" toinstall

$(LONG_BITS)install :
	@echo "-----"
	@echo "Installing all for" $(LONG_BITS) "bits version."
	$(MAKE) "BITS=$(LONG_BITS)" "DFLAGS=$(LONG_DFLAGS)" toinstall
	
$(MP_BITS)install :
	@echo "-----"
	@echo "Installing all for" $(MP_BITS) "version."
	$(MAKE) "BITS=$(MP_BITS)" "DFLAGS=$(MP_DFLAGS)" toinstall
	
toinstall : $(TO_INSTALL)

install_pip:
	@echo "             /*-----------------------------------------------*"
	@echo "              *                 INSTALLING PIP                *"
	@echo "              *-----------------------------------------------*/"
	($(INSTALL) -d $(PIPLIB_INS_BIN) && \
	$(INSTALL) $(PIPLIB_OBJ)/pip$(BITS)$(EXEC_SUFFIX) $(PIPLIB_INS_BIN))

install_preparation:
	($(INSTALL) -d $(PIPLIB_INS_INC) && \
	$(INSTALL) -d $(PIPLIB_INS_INC)/piplib && \
	$(INSTALL) $(PIPLIB_INC)/piplib/*  $(PIPLIB_INS_INC)/piplib)

install_piplibshared: install_preparation
	@echo "             /*-----------------------------------------------*"
	@echo "              *            INSTALLING PipLib (shared)         *"
	@echo "              *-----------------------------------------------*/"
	rm -f  $(PIPLIB_INS_LIB)/libpiplib$(BITS).$(SHEXT)
	($(INSTALL) -d $(PIPLIB_INS_LIB) && \
	$(INSTALL) $(PIPLIB_OBJ)/libpiplib$(BITS).$(SHEXT).$(VERSION) \
	$(PIPLIB_INS_LIB) && \
	$(LN_S) $(PIPLIB_INS_LIB)/libpiplib$(BITS).$(SHEXT).$(VERSION) \
	$(PIPLIB_INS_LIB)/libpiplib$(BITS).$(SHEXT))
	
install_piplibstatic: install_preparation
	@echo "             /*-----------------------------------------------*"
	@echo "              *            INSTALLING PipLib (static)         *"
	@echo "              *-----------------------------------------------*/"
	rm -f  $(PIPLIB_INS_LIB)/libpiplib$(BITS).a
	($(INSTALL) -d $(PIPLIB_INS_LIB) && \
	$(INSTALL) $(PIPLIB_OBJ)/libpiplib$(BITS).a.$(VERSION) \
	$(PIPLIB_INS_LIB) && \
	$(LN_S) $(PIPLIB_INS_LIB)/libpiplib$(BITS).a.$(VERSION) \
	$(PIPLIB_INS_LIB)/libpiplib$(BITS).a)
	
check:
	$(MAKE) test -C test

uninstall :
	@echo "             /*-----------------------------------------------*"
	@echo "              *             UNINSTALLING PIP/PipLib           *"
	@echo "              *-----------------------------------------------*/"
	rm -f $(PIPLIB_INS_LIB)/libpiplib*
	rm -rf $(PIPLIB_INS_INC)/piplib
	rm -f $(PIPLIB_INS_BIN)/pip32$(EXEC_SUFFIX) \
	$(PIPLIB_INS_BIN)/pip64$(EXEC_SUFFIX) \
	$(PIPLIB_INS_BIN)/pipMP$(EXEC_SUFFIX)
	
total:
	@echo "             /*-----------------------------------------------*"
	@echo "              *                   PIP/PipLib                  *"
	@echo "              *-----------------------------------------------*/"
	$(MAKE) uninstall
	$(MAKE) clean
	$(MAKE)
	$(MAKE) install

tgz: distclean
	(cd .. && \
	tar cvf piplib-$(VERSION).tar piplib-$(VERSION) && \
	gzip piplib-$(VERSION).tar)

