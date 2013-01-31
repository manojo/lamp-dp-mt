# always has this line (shared config)
include ../MakeIncludes/Makefile.config

# flags to pass to the compiler (e.g. include paths)
CPPFLAGS	= -I$(POLYDIR)

# flags to pass to the linker (e.g. library path)
LDFLAGS		= -L$(LIBDIR) # -mwindows

# library to link against
LOADLIBES	= # -lgmp  -lpoly -lpolymsg -lpretty

# files to remove when making clean
DUMMY		= lex.c yacc.c *.output y.tab.h

# name of the executable
NAME		= write_alpha

# local components of the program
OBJS		= $(OBJDIR)/yacc.o \
		  $(OBJDIR)/nodeprocs.o \
		  $(OBJDIR)/node2item.o \
		  $(POLYOBJS) $(POLYMSG)  $(PRETTYOBJS)

# libraries to link again, same as above (these are for make dependencies)
LIBS		= $(LIBDIR)/libpoly.a \
		  $(LIBDIR)/libpretty.a\
		  $(LIBDIR)/libpolymsg.a\
		  $(LIBDIR)/libpolyx.a 

# always has this line, this the default target (the rule is defined
# in ../MakeIncludes/Makefile.rules)
$(NAME) : $(BINDIR)/$(NAME)
	@# gnu-make needs this empty line to avoid implicit rules

# special rules or dependencies for .o files (default is defined in
# ../MakeIncludes/Makefile.rules)

# Rules for yacc.o
$(OBJDIR)/yacc.o : yacc.c lex.c node.h nodeprocs.h node2item.h \
	$(PRETTYDIR)/item.h

# Rules for yacc.c
yacc.c : yacc.y

# Rules for lex.c
lex.c: lex.l

# Rules for nodeproce.o
$(OBJDIR)/nodeprocs.o: $(NEEDOBJDIR) $(MAKEFILES) nodeprocs.h node.h

# Rules for node2item.o
$(OBJ_DIR)/node2item.o: $(NEEDOBJDIR) $(MAKEFILES) node2item.h nodeprocs.h node.h \
	$(PRETTYDIR)/item.h

#always has this line (default rules)
include ../MakeIncludes/Makefile.rules

#  Added May 2008
#  Checks and list various variables
checkvars: .phony
	make -f Makefile.checkvars checkvars
	make -f ../MakeIncludes/Makefile.checkvars checkvars

.phony: 
