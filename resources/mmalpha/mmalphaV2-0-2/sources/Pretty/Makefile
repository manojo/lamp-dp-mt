#
#  This make file is very simple.
#

#  Define the Object directory, depending on the OS Type.
#  Assumes that environment variable $OSTYPE is set
#
OBJ_DIR = Obj.$(OSTYPE)

#  When make all is run, depends on the existence of the Object directory
#  and on the definition of binary pretty
all : $(OBJ_DIR) $(OBJ_DIR)/pretty

#  Rule to create pretty binary. Depends on source files, object files,
#  lex files. Action : compile  files
$(OBJ_DIR)/pretty: item.h readitem.c $(OBJ_DIR)/writeitem.o writeitem.h \
	$(OBJ_DIR)/lex.c $(OBJ_DIR)/itemprocs.o itemprocs.h
	gcc -g -o $(OBJ_DIR)/pretty -I$(OBJ_DIR) writeitem.c readitem.c \
		$(OBJ_DIR)/itemprocs.o

#  To produce lex.c file (depends on lex.l), run flex, then move the
#  result in object directory
$(OBJ_DIR)/lex.c: $(OBJ_DIR) lex.l
	flex lex.l
	mv lex.yy.c $(OBJ_DIR)/lex.c

#  To produce itemprocs object, compile it
$(OBJ_DIR)/itemprocs.o: $(OBJ_DIR) itemprocs.c itemprocs.h item.h
	gcc -c -g -o $(OBJ_DIR)/itemprocs.o itemprocs.c

#  Same for writeitem
$(OBJ_DIR)/writeitem.o: $(OBJ_DIR) writeitem.c writeitem.h item.h
	gcc -c -g -o $(OBJ_DIR)/writeitem.o writeitem.c

#  If object directory does not exist, create it
$(OBJ_DIR) :
	mkdir $(OBJ_DIR)

#  Never seen this...
itemprocs.h:
	echo "/* temporary itemprocs.h */" >itemprocs.h
	cextract +a +w72 -H_itemprocs_ -o itemprocs.h itemprocs.c

writeitem.h:
	echo "/* temporary writeitem.h */" >writeitem.h
	cextract +a +w72 -H_writeitem_ -o writeitem.h writeitem.c

#  To clean stuff, remove pretty, remove content of object directory
clean:
	rm -f pretty lex.c *.o
	rm -rf $(OBJ_DIR)

#  Added Jan 2009
#  Checks and list various variables
checkvars: .phony
	make -f ../MakeIncludes/Makefile.checkvars checkvars
