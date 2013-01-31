#
#   This is the makefile for Write_C
#

#   Assumes that MMALPHA and OSTYPE are defined 

#   Call Makefile.config in sources/MakeIncludes
include ../MakeIncludes/Makefile.config

# flags to pass to the compiler (e.g. include paths)
CPPFLAGS	= -I$(POLYDIR) -I$(CODEGENDIR)

# flags to pass to the linker (e.g. library path)
LDFLAGS		= -L$(LIBDIR) #-mwindows

# library to link again
LOADLIBES	= # -lpoly -lpolymsg -lcodegen -lpretty

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


#  Added May 2008
#  Checks and list various variables
checkvars: .phony
	make -f ../MakeIncludes/Makefile.checkvars checkvars

.phony:
