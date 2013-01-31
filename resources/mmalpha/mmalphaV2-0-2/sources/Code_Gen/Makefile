# always has this line (shared config)
include ../MakeIncludes/Makefile.config

# flags to pass to the compiler (e.g. include paths)
CPPFLAGS	= -I$(POLYDIR)

# flags to pass to the linker (e.g. library path)
LDFLAGS		= -L$(LIBDIR) # -mwindows

# library to link again
LOADLIBES	= #-lgmp  -lpoly -lpolymsg -lcodegen -lpretty

# files to remove when making clean
DUMMY		= lex.c yacc.c *.output

# name of the executable
NAME		= code_gen

# local components of the program
OBJS		= $(OBJDIR)/yacc.o \
		  $(POLYOBJS) $(POLYMSG) $(CODEGENOBJS) $(PRETTYOBJS)

# libraries to link against, same as above (these are for make dependencies)
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
$(OBJDIR)/yacc.o : yacc.y lex.c gen.c

#always has this line (default rules)
include ../MakeIncludes/Makefile.rules
