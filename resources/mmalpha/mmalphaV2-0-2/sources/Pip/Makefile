include ../MakeIncludes/Makefile.config

NAME		= pip64
PIPDIR 	= $(MMALPHA)/sources/Pip
PIPLIBNAME = piplib-1.3.3

pip64:  $(PIPDIR)/$(PIPLIBNAME)/Makefile $(PIPDIR)/bin/Pip64

$(PIPDIR)/$(PIPLIBNAME)/README:
	@echo "Please install PipLib in Directory: "
	@echo $(PIPDIR)
	@echo 


$(PIPDIR)/$(PIPLIBNAME)/Makefile: $(PIPDIR)/$(PIPLIBNAME)/README
	@echo "Warning if you have downloaded a new version of Pip"
	@echo "You should have set the MAXCOL constant to 4000 in type.h"
	cd $(PIPDIR)/$(PIPLIBNAME);./configure --prefix=$(PIPDIR) --enable-llint-version

$(PIPDIR)/bin/Pip64: 	$(PIPDIR)/$(PIPLIBNAME)/Makefile
	cd $(PIPDIR)/$(PIPLIBNAME); $(MAKE);$(MAKE)  install
	cp bin/pip64$(SUFFIX) $(BINDIR)/pip$(SUFFIX)

clean:
	\rm -rf bin lib 	include $(OBJDIR)
	cd $(PIPDIR)/$(PIPLIBNAME); $(MAKE)  distclean

.PHONY:	