
# A dynamic programming evaluator generated by GAP-C.
# 
#   GAP-C version:
#     gapc-2012.07.23
# 
#   GAP-C call:
#     gapc -t -i mfe adpfold.gap 
# 
# 


SED = sed
RTLIB = rtlib

RTLIB_LDFLAGS = $(RT_LDFLAGS)
RTLIB_LDLIBS = $(RT_LDLIBS)
RTLIB_CPPFLAGS = $(RT_CPPFLAGS)

ifeq "$(origin NO_CONFIG_MF)" "undefined"
$(info Including global makefile /opt/local/share/gapc/config.mf)
-include /opt/local/share/gapc/config.mf
endif

-include gapc_local.mf

ifdef MF
$(info Including extra makefile $(MF))
include $(MF)
endif

CXXFILES =  out_main.cc out.cc

DEPS = $(CXXFILES:.cc=.d)
OFILES = $(CXXFILES:.cc=.o) string.o

out : $(OFILES)
	$(CXX) -o $@ $^  $(LDFLAGS) $(LDLIBS)

out_main.cc : $(RTLIB)/generic_main.cc out.cc
	echo '#include "out.hh"' > $@
	cat $(RTLIB)/generic_main.cc >> out_main.cc

ifneq ($(filter $(CXX),g++ icc),)
-include $(DEPS)

%.o : %.cc
	$(CXX) -MMD -MP $(CPPFLAGS) $(CXXFLAGS) $< -c -o $@ \
         && $(SED) -e 's/[^ ]\+boost[^ \n]\+//' $*.d > _t && mv _t $*.d
endif

.PHONY: clean
clean:
	rm -f $(OFILES) out out_main.cc

string.o: $(RTLIB)/string.cc
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $< -o $@
