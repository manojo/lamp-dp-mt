# always has this line (shared config)
include ../MakeIncludes/Makefile.config

# flags to pass to the compiler (e.g. include paths)
CPPFLAGS	= -I$(POLYDIR)  -g
# flags to pass to the linker (e.g. library path)

# library to link again
LOADLIBES	=  # -lgmp -lpoly -lpolymsg

# files to remove when making clean
DUMMY		= lex.c yacc.c *.output y.tab.h

# name of the executable
NAME		= read_alpha

# local components of the program
OBJS		= $(OBJDIR)/read_alpha.o \
		  $(OBJDIR)/node.o \
		  $(POLYOBJS) 
#$(POLYMSG)

# libraries to link again, same as above (these are for make dependencies)
LIBS		= $(LIBDIR)/libpoly.a \
		  # $(LIBDIR)/libpolymsg.a

# always has this line, this the default target (the rule is defined
# in ../MakeIncludes/Makefile.rules)
$(NAME) : $(BINDIR)/$(NAME)
	@# gnu-make needs this empty line to avoid implicit rules

# special rules or dependencies for .o files (default is defined in
# ../MakeIncludes/Makefile.rules)

# Dependency between read_alpha.o, the c files and the header files
$(OBJDIR)/read_alpha.o : read_alpha.c yacc.c lex.c \
		node.h nodetypes.h

# Dependency between yacc.c and yacc.y
yacc.c : yacc.y

# Dependency between lex.c and lex.l
lex.c: lex.l

#always has this line (default rules)
include ../MakeIncludes/Makefile.rules

#  Added May 2008
#  Checks and list various variables
checkvars: .phony
	make -f ../MakeIncludes/Makefile.checkvars checkvars

# Do not know what it is
t1:	t1.c
	gcc -c   t1.c -o t1.o
	gcc   -mwindows -o t1 t1.o

# apparently unused
test:  virtual
#	cd test;make;cd ..

virtual:	

.phony: 