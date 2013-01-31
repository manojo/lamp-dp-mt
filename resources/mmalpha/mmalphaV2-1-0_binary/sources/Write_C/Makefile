#
#  Version modified by PQ, April 2010
#
#   Assumes that MMALPHA and OSTYPE are defined 
#
#  Include the shared config file#
include ../MakeIncludes/Makefile.config

# flags to pass to the compiler (e.g. include paths)
CPPFLAGS	= -I$(POLYDIR) -I$(CODEGENDIR)

# flags to pass to the linker (e.g. library path)
LDFLAGS		= -L$(LIBDIR) #-mwindows

# files to remove when making clean
DUMMY		= *.output yacc.c 

# name of the executable
NAME		= write_c

# local components of the program
OBJS		= $(OBJDIR)/yacc.o \
		  $(POLYOBJS) $(POLYMSG) $(PRETTYOBJS) $(CODEGENOBJS) 

# libraries to link again, same as above (these are for make dependencies)
LIBS		= $(LIBDIR)/libpoly.a \
		  $(LIBDIR)/libpolymsg.a \
		  $(LIBDIR)/libcodegen.a \
		  $(LIBDIR)/libpretty.a

# always has this line, this the default target (the rule is defined
# in ../MakeIncludes/Makefile.rules)
$(NAME) : $(BINDIR)/$(NAME)
	@# gnu-make needs this empty line to avoid implicit rules

# special rules for .o files (default is defined in
# ../MakeIncludes/Makefile.rules)
$(OBJDIR)/yacc.o : yacc.c $(CODEGENDIR)/lex.c 
$(OBJDIR)/gen.o : $(CODEGENDIR)/Obj.darwin/gen.o
	cp $(CODEGENDIR)/Obj.darwin/gen.o $(OBJDIR)/gen.o
$(OBJDIR)/nodeprocs.o : $(CODEGENDIR)/Obj.darwin/nodeprocs.o
	cp $(CODEGENDIR)/Obj.darwin/nodeprocs.o $(OBJDIR)/nodeprocs.o

#always has this line (default rules)
include ../MakeIncludes/Makefile.rules

#  Checks and lists variables
.phony: checkvars
checkvars: 
#
# Check value of MMALPHA. Checks if there exists a Domlib directory in it
	@echo "----- MMALPHA = "$(MMALPHA);
	@if [ ! -d $(MMALPHA)/sources/Domlib ]; then echo "***MMALPHA is probably wrong."; fi
#
# Check value of CC
	@echo "----- CC = "$(CC);
	@if [ "$(CC)" = "" ]; then echo "*** Variable CC is not set"; fi
#
# Check value of BINDIR, the binary directory
	@echo "----- BINDIR = "$(BINDIR);
	@if [ "$(BINDIR)" = "" ]; then echo "*** Variable BINDIR is not set"; fi
	@if [ ! -d $(BINDIR) ]; then echo "*** Binary directory does not exist."; fi
#
# Check value of LIBDIR, the directory of libraries
	@echo "----- LIBDIR = "$(LIBDIR);
	@if [ "$(LIBDIR)" = "" ]; then echo "*** Variable LIBDIR is not set"; fi
	@if [ ! -d $(LIBDIR) ]; then echo "*** Library directory does not exist."; fi
#
# Check value of OBJDIR
	@echo "----- OBJDIR = "$(OBJDIR);
	@if [ "$(OBJDIR)" = "" ]; then echo "*** Variable OBJDIR is not set"; fi
	@if [ ! -d $(OBJDIR) ]; then echo "***OBJDIR was not created. Please, create it."; fi
#
# Check value of POLYDIR
	@echo "----- POLYDIR = "$(POLYDIR);
	@if [ "$(POLYDIR)" = "" ]; then echo "*** Variable POLYDIR is not set"; fi
	@if [ ! -d $(POLYDIR) ]; then echo "***Directory POLYDIR does not exist."; fi
#
# Check value of POLYOBJS
	@echo "----- POLYOBJS = "$(POLYOBJS);
	@if [ "$(POLYOBJS)" = "" ]; then echo "*** Variable POLYOBJS is not set"; fi
#
# Check value of POLYINCLUDE
	@echo "----- POLYINCLUDE = "$(POLYINCLUDE);
	@if [ "$(POLYINCLUDE)" = "" ]; then echo "*** Variable POLYINCLUDE is not set"; fi
	@if [ ! -d $(POLYINCLUDE) ]; then echo "***Directory POLYINCLUDE does not exist."; fi
#
# Check value of NEEDOBJDIR
	@echo "----- NEEDOBJDIR = "$(NEEDOBJDIR)
	@if [ "$(NEEDOBJDIR)" = "" ]; then echo "*** Variable NEEDOBJDIR is not set"; fi
	@echo "----- MAKEFILES = "$(MAKEFILES)
	@echo "----- LD = "$(LD)
	@echo "----- LDFLAGS = "$(LDFLAGS)
	@echo "----- OBJS = "$(OBJS)
	@echo "----- SHELL = "$(SHELL);
	@echo "----- CFLAGS = "$(CFLAGS);
	@echo "----- CODEGENDIR = "$(CODEGENDIR);
	@echo "----- CODEGENOBJS = "$(CODEGENOBJS);
	@echo "----- CPPFLAGS = "$(CPPFLAGS);
	@echo "----- LFFLAGS = "$(LDFLAGS);
	@echo "----- CXX = "$(CXX)

.phony:
