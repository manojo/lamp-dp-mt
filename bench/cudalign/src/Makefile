.SUFFIXES : .cu .cubin

#maxregisters := 32

SMVERSIONFLAGS	:= --gpu-architecture=sm_30

CUDA_INSTALL_PATH ?= /usr/local/cuda
CUDA_SDK_PATH ?= /Developer/GPU

# detect OS
OSLOWER = $(shell uname -s 2>/dev/null | tr [:upper:] [:lower:])
# Basic directory setup for SDK
# (override directories only if they are not already defined)
SRCDIR     ?=
ROOTDIR    ?= .
ROOTBINDIR ?= $(ROOTDIR)/bin
BINDIR     ?= $(ROOTBINDIR)/$(OSLOWER)
ROOTOBJDIR ?= ../obj
LIBDIR     := $(CUDA_SDK_PATH)/lib
COMMONDIR  := $(CUDA_SDK_PATH)/common
# check if verbose
ifeq ($(verbose), 1)
	VERBOSE :=
else
	VERBOSE := @
endif
	VERBOSE :=
# Compilers
NVCC       := $(CUDA_INSTALL_PATH)/bin/nvcc
CXX        := g++
# Includes
INCLUDES  += -I. -I$(CUDA_INSTALL_PATH)/include
# Compiler-specific flags
NVCCFLAGS := $(COMMON_FLAGS) -m64
CXXFLAGS  := $(CXXWARN_FLAGS) $(COMMON_FLAGS) -Wpointer-arith
# Common flags
COMMONFLAGS += $(INCLUDES) -O3
# Libs
LIB := -L$(CUDA_INSTALL_PATH)/lib -L$(LIBDIR)

ifeq ($(USEDRVAPI),1)
   LIB += -lcuda ${OPENGLLIB} $(PARAMGLLIB) $(RENDERCHECKGLLIB) $(CUDPPLIB) ${LIB}
else
   LIB += -lcudart ${OPENGLLIB} $(PARAMGLLIB) $(RENDERCHECKGLLIB) $(CUDPPLIB) ${LIB}
endif

#LIB += -lcutil


################################################################################
# Check for input flags and set compiler flags appropriately
################################################################################
ifeq ($(fastmath), 1)
	NVCCFLAGS += -use_fast_math
endif

ifeq ($(keep), 1)
	NVCCFLAGS += -keep
	NVCC_KEEP_CLEAN := *.i* *.cubin *.cu.c *.cudafe* *.fatbin.c *.ptx
endif

# Add cudacc flags
NVCCFLAGS += $(CUDACCFLAGS)

# Add common flags
NVCCFLAGS += $(COMMONFLAGS)
CXXFLAGS  += $(COMMONFLAGS)

NVCCFLAGS   += --compiler-options -fno-strict-aliasing
CXXFLAGS    += -fno-strict-aliasing
#CXXFLAGS    += -fno-strict-aliasing -ggdb

ifeq ($(nvcc_warn_verbose),1)
	NVCCFLAGS += $(addprefix --compiler-options ,$(CXXWARN_FLAGS))
	NVCCFLAGS += --compiler-options -fno-strict-aliasing
endif
################################################################################
# Set up object files
################################################################################
OBJDIR := $(ROOTOBJDIR)/$(BINSUBDIR)
OBJS +=  $(patsubst %.cpp,$(OBJDIR)/%.cpp.o,$(notdir $(CCFILES)))
OBJS +=  $(patsubst %.c,$(OBJDIR)/%.c.o,$(notdir $(CFILES)))
OBJS +=  $(patsubst %.cu,$(OBJDIR)/%.cu.o,$(notdir $(CUFILES)))

cudalign: makedirectories $(OBJDIR)/main.o $(OBJDIR)/Sequence.o $(OBJDIR)/Alignment.o $(OBJDIR)/Job.o $(OBJDIR)/SpecialRowReader.o $(OBJDIR)/SpecialRowWriter.o $(OBJDIR)/MidpointsFile.o $(OBJDIR)/stage1.o $(OBJDIR)/stage2.o $(OBJDIR)/stage3.o $(OBJDIR)/stage4.o $(OBJDIR)/stage5.o $(OBJDIR)/stage6.o $(OBJDIR)/cuda_util.o $(OBJDIR)/Properties.o $(OBJDIR)/Timer.o $(OBJDIR)/FileBuffer.o $(OBJDIR)/SocketBuffer.o $(OBJDIR)/Buffer.o
	$(VERBOSE)$(CXX) $(CXXFLAGS) -fPIC $(OBJDIR)*.o $(LIB) -lcuda -lpthread -Xlinker -rpath $(CUDA_INSTALL_PATH)/lib -o cudalign

makedirectories:
	$(VERBOSE)mkdir -p $(OBJDIR)

$(OBJDIR)/main.o: main/main.cpp
	$(VERBOSE)$(CXX) $(CXXFLAGS) -c main/main.cpp -o $(OBJDIR)/main.o

$(OBJDIR)/Timer.o: common/Timer.cpp common/Timer.hpp
	$(VERBOSE)$(CXX) $(CXXFLAGS) common/Timer.cpp -c -o $(OBJDIR)/Timer.o

$(OBJDIR)/Sequence.o: common/Sequence.cpp common/Sequence.hpp
	$(VERBOSE)$(CXX) $(CXXFLAGS) common/Sequence.cpp -c -o $(OBJDIR)/Sequence.o

$(OBJDIR)/Alignment.o: common/Alignment.cpp common/Alignment.hpp
	$(VERBOSE)$(CXX) $(CXXFLAGS) common/Alignment.cpp -c -o $(OBJDIR)/Alignment.o

$(OBJDIR)/Job.o: common/Job.cpp common/Job.hpp
	$(VERBOSE)$(CXX) $(CXXFLAGS) common/Job.cpp -c -o $(OBJDIR)/Job.o

$(OBJDIR)/Properties.o: common/Properties.cpp common/Properties.hpp
	$(VERBOSE)$(CXX) $(CXXFLAGS) common/Properties.cpp -c -o $(OBJDIR)/Properties.o

$(OBJDIR)/SpecialRowReader.o: common/SpecialRowReader.cpp common/SpecialRowReader.hpp
	$(VERBOSE)$(CXX) $(CXXFLAGS) common/SpecialRowReader.cpp -c -o $(OBJDIR)/SpecialRowReader.o

$(OBJDIR)/SpecialRowWriter.o: common/SpecialRowWriter.cpp common/SpecialRowWriter.hpp
	$(VERBOSE)$(CXX) $(CXXFLAGS) common/SpecialRowWriter.cpp -c -o $(OBJDIR)/SpecialRowWriter.o

$(OBJDIR)/MidpointsFile.o: common/MidpointsFile.cpp common/MidpointsFile.hpp
	$(VERBOSE)$(CXX) $(CXXFLAGS) common/MidpointsFile.cpp -c -o $(OBJDIR)/MidpointsFile.o

$(OBJDIR)/Buffer.o: common/buffer/Buffer.cpp common/buffer/Buffer.hpp
	$(VERBOSE)$(CXX) $(CXXFLAGS) common/buffer/Buffer.cpp -lpthread -c -o $(OBJDIR)/Buffer.o

$(OBJDIR)/FileBuffer.o: common/buffer/FileBuffer.cpp common/buffer/FileBuffer.hpp
	$(VERBOSE)$(CXX) $(CXXFLAGS) common/buffer/FileBuffer.cpp -lpthread -c -o $(OBJDIR)/FileBuffer.o

$(OBJDIR)/SocketBuffer.o: common/buffer/SocketBuffer.cpp common/buffer/SocketBuffer.hpp
	$(VERBOSE)$(CXX) $(CXXFLAGS) common/buffer/SocketBuffer.cpp -lpthread -c -o $(OBJDIR)/SocketBuffer.o

$(OBJDIR)/stage1.o: stage1/sw_stage1.cu stage1/sw_stage1.h common/cuda_configs.hpp
	$(VERBOSE)$(NVCC) $(NVCCFLAGS) -maxrregcount 32 $(SMVERSIONFLAGS) -o $(OBJDIR)/stage1.o -c stage1/sw_stage1.cu

$(OBJDIR)/stage2.o: stage2/sw_stage2.cu stage2/sw_stage2_common.inc.cu common/cuda_configs.hpp
	$(VERBOSE)$(NVCC) $(NVCCFLAGS) -maxrregcount 32 $(SMVERSIONFLAGS) -o $(OBJDIR)/stage2.o -c stage2/sw_stage2.cu

$(OBJDIR)/stage3.o: stage3/sw_stage3.cu stage2/sw_stage2_common.inc.cu common/cuda_configs.hpp
	$(VERBOSE)$(NVCC) $(NVCCFLAGS) -maxrregcount 32 $(SMVERSIONFLAGS) -o $(OBJDIR)/stage3.o -c stage3/sw_stage3.cu

$(OBJDIR)/stage4.o: stage4/sw_stage4.cu stage4/sw_stage4.h common/cuda_configs.hpp
	$(VERBOSE)$(NVCC) $(NVCCFLAGS) -maxrregcount 16 $(SMVERSIONFLAGS) -o $(OBJDIR)/stage4.o -c stage4/sw_stage4.cu

$(OBJDIR)/stage5.o: stage5/sw_stage5.cu stage5/sw_stage5.h common/cuda_configs.hpp
	$(VERBOSE)$(NVCC) $(NVCCFLAGS) -maxrregcount 16 $(SMVERSIONFLAGS) -o $(OBJDIR)/stage5.o -c stage5/sw_stage5.cu

$(OBJDIR)/stage6.o: stage6/sw_stage6.cpp stage6/sw_stage6.h common/cuda_configs.hpp
	$(VERBOSE)$(CXX) $(CXXFLAGS) -L/usr/lib/ -o $(OBJDIR)/stage6.o -c stage6/sw_stage6.cpp

$(OBJDIR)/cuda_util.o: common/cuda_util.cu
	$(VERBOSE)$(NVCC) $(NVCCFLAGS) $(SMVERSIONFLAGS) -o $(OBJDIR)/cuda_util.o -c common/cuda_util.cu


clean:
	rm -rf $(OBJDIR) cudalign
