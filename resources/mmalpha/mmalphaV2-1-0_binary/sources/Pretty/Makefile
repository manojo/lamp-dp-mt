#
#  Version modified by PQ, April 2010
#
#  Define the Object directory, depending on the OS Type.
#  Assumes that environment variable $OSTYPE is set
#  
#  Includes the common config file in MakeIncludes
include ../MakeIncludes/Makefile.config

#  May I remove the following ?
#  When make all is run, depends on the existence of the Object directory
#  and on the definition of binary pretty in this object directory
#all : $(OBJDIR) $(OBJDIR)/pretty

#  Rule to create the pretty binary. Depends on source files, object files,
#  lex files. Action: compile and link pretty
$(OBJDIR)/pretty: item.h readitem.c $(OBJDIR)/writeitem.o writeitem.h \
	$(OBJDIR)/lex.c $(OBJDIR)/itemprocs.o itemprocs.h
	$(CC) -g -o $(OBJDIR)/pretty -I$(OBJDIR) writeitem.c readitem.c \
		$(OBJDIR)/itemprocs.o

#  To produce lex.c file (depends on lex.l), run flex, then move the
#  result in object directory
$(OBJDIR)/lex.c: $(OBJDIR) lex.l
	flex lex.l
	mv lex.yy.c $(OBJDIR)/lex.c

#  To produce itemprocs object, compile it
$(OBJDIR)/itemprocs.o: $(OBJDIR) itemprocs.c itemprocs.h item.h
	$(CC) -c -g -o $(OBJDIR)/itemprocs.o itemprocs.c

#  Same for writeitem
$(OBJDIR)/writeitem.o: $(OBJDIR) writeitem.c writeitem.h item.h
	$(CC) -c -g -o $(OBJDIR)/writeitem.o writeitem.c

#  If object directory does not exist, create it
$(OBJDIR) :
	mkdir $(OBJDIR)

#  Never seen this...
itemprocs.h:
	echo "/* temporary itemprocs.h */" >itemprocs.h
	cextract +a +w72 -H_itemprocs_ -o itemprocs.h itemprocs.c

writeitem.h:
	echo "/* temporary writeitem.h */" >writeitem.h
	cextract +a +w72 -H_writeitem_ -o writeitem.h writeitem.c

#  To clean stuff, remove pretty, remove content of object directory
.phony: clean
clean:
	rm -f pretty lex.c *.o
	rm -rf $(OBJDIR)

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
# Check value of OBJDIR
	@echo "----- OBJDIR = "$(OBJDIR);
	@if [ "$(OBJDIR)" = "" ]; then echo "*** Variable OBJDIR is not set"; fi
	@if [ ! -d $(OBJDIR) ]; then echo "***OBJDIR was not created. Please, create it."; fi
	@echo "----- NEEDOBJDIR = "$(NEEDOBJDIR)
	@if [ "$(NEEDOBJDIR)" = "" ]; then echo "*** Variable NEEDOBJDIR is not set"; fi
	@echo "----- MAKEFILES = "$(MAKEFILES)
	@echo "----- LD = "$(LD)
	@echo "----- NAME = "$(NAME)
	@echo "----- DIR = "$(DIR)
	@echo "----- SHELL = "$(SHELL);
	@echo "----- CXX = "$(CXX)




