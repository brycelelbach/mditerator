###############################################################################
# Copyright (c) 2015-6 Bryce Adelstein Lelbach aka wash <brycelelbach@gmail.com>
#
# Distributed under the Boost Software License, Version 1.0. (See accompanying
# file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
###############################################################################

# ARCH=AVX|AVX2|AVX512 (default: AVX)
# RUN=0|1              (default: 1)
# DEBUG=0|1            (default: 0)
# ASSERTS=0|1          (default: 0)
# STATIC=0|1           (default: 1 if not debug)

LLVMROOT=/global/homes/w/wash/development/gor-llvm/INSTALL_RELEASE

LLVMCXX=$(LLVMROOT)/bin/clang++
INTELCXX=icpc
GNUCXX=g++

LLVMOPTREPORT=$(LLVMROOT)/bin/llvm-opt-report

CXXFLAGS=
LINKFLAGS=

# Warnings.
CXXFLAGS=-Wall -Wno-unused

# Language and library dialect.
LLVMCXXFLAGS=-stdlib=libc++ -std=c++1z -fcoroutines-ts
INTELCXXFLAGS=-std=c++14 
GCCFLAGS=-std=c++1z

# Workaround loop-idiom memset replacement bug in Clang and GCC.
LLVMCXXFLAGS+=-fno-builtin-memset
INTELCXXFLAGS+=
GCCFLAGS+=-fno-builtin
 
# Ensure libc++ links correctly for Clang/LLVM.
LLVMLINKFLAGS+=-L$(LLVMROOT)/lib -Wl,-rpath,$(LLVMROOT)/lib

# Optimization diagnostics.
LLVMDIAGFLAGS=-Rpass=loop-vectorize -Rpass-missed=loop-vectorize -Rpass-analysis=loop-vectorize
INTELDIAGFLAGS=
GNUDIAGFLAGS=

# Optimization diagnostic report.
define LLVMREPORTFLAGS
  -Xclang -opt-record-file -Xclang $(1)
endef
define INTELREPORTFLAGS
  -qopt-report=5 -qopt-report-file=$(1) 
endef
define GNUREPORT
  -fopt-info-vec-all=$(1)
endef

# Assembly generation.
LLVMASMFLAGS=
INTELASMFLAGS=-fcode-asm -fsource-asm -no-ipo
GNUASMFLAGS=

# Optimized IR generation.
LLVMOPTIRFLAGS=-emit-llvm

# Unoptimized IR generation.
LLVMUNOPTIRFLAGS=-emit-llvm -Xclang -disable-llvm-passes

ifeq ($(NERSC_HOST),cori)
  ifeq ($(ARCH),)
    ARCH=AVX2
  endif
endif
ifeq ($(NERSC_HOST),edison)
  ifeq ($(ARCH),)
    ARCH=AVX
  endif
endif

ifeq ($(ARCH),AVX512)
  BUILD_TYPE=avx512

  CXXFLAGS+=-DMDITERATOR_ARCH_AVX512

  LLVMCXXFLAGS+=-march=knl
  INTELCXXFLAGS+=-xMIC-AVX512
  GNUCXXFLAGS+=-march=knl
else ifeq ($(ARCH),AVX2)
  BUILD_TYPE=avx2

  CXXFLAGS+=-DMDITERATOR_ARCH_AVX2

  LLVMCXXFLAGS+=-march=haswell
  INTELCXXFLAGS+=-xCORE-AVX2
  GNUCXXFLAGS+=-march=haswell
else
  BUILD_TYPE=avx

  CXXFLAGS+=-DTSB_ARCH_AVX

  LLVMCXXFLAGS+=-march=ivybridge
  INTELCXXFLAGS+=-xAVX
  GNUCXXFLAGS+=-march=ivybridge
endif

ifeq ($(RUN),)
  RUN=1
endif

ifeq ($(DEBUG),1)     # DEBUG == 1
  BUILD_TYPE:=$(BUILD_TYPE).debug

  # Optimization and debugging level.
  CXXFLAGS+=-ggdb -O0

  ifeq ($(STATIC),1)
    $(error Debug builds must be dynamic.)
  endif               # DEBUG == 0
else
  BUILD_TYPE:=$(BUILD_TYPE).release

  # Optimization and debugging level.
  CXXFLAGS+=-g0 -O3 -fstrict-aliasing -fno-exceptions -fno-rtti

  # Cleaner assembly generation.
  CXXFLAGS+=-fomit-frame-pointer -fno-asynchronous-unwind-tables
  LLVMCXXFLAGS+=-fno-unwind-tables
  INTELCXXFLAGS+=-fno-dwarf2-cfi-asm
  GNUCXXFLAGS+=-fno-unwind-tables

  # Vectorizer.
  LLVMCXXFLAGS+=-fvectorize -fveclib=SVML
  INTELCXXFLAGS+=
  GNUCXXFLAGS+=-ftree-vectorize

  # Fast math mode.
  LLVMCXXFLAGS+=-ffast-math
  INTELCXXFLAGS+=-fast
  GNUCXXFLAGS+=-ffast-math   
endif

ifeq ($(ASSERTS),1)  # ASSERTS == 1
  BUILD_TYPE:=$(BUILD_TYPE).asserts-on
  CXXFLAGS+=-DBOOST_CHECK_ASSUMPTIONS
else                 # ASSERTS == 0
  BUILD_TYPE:=$(BUILD_TYPE).asserts-off
  CXXFLAGS+=-DNDEBUG
endif

ifeq ($(STATIC),1)   # STATIC == 1
  BUILD_TYPE:=$(BUILD_TYPE).static
  CXXFLAGS+=-static
else                 # STATIC == 0
  BUILD_TYPE:=$(BUILD_TYPE).dynamic
endif

CXXFLAGS+=-DMDITERATOR_BUILD_TYPE=\"$(BUILD_TYPE)\"

TESTS=\
  test_index_generator.llvm \
  test_index_iterator_pair.llvm \
  test_index_iterator_pair.intel \
  test_index_iterator_pair.gnu \
  test_index_iterator_sentinel_range.llvm \
  test_index_iterator_sentinel_range.intel \
  test_index_iterator_sentinel_range.gnu

KERNELS=\
  memset_2d_index_generator.llvm \
  memset_2d_index_iterator_pair.llvm \
  memset_2d_index_iterator_pair.intel \
  memset_2d_index_iterator_pair.gnu \
  memset_2d_index_iterator_sentinel_range.llvm \
  memset_2d_index_iterator_sentinel_range.intel \
  memset_2d_index_iterator_sentinel_range.gnu \
  memset_2d_reference.llvm \
  memset_2d_reference.intel \
  memset_2d_reference.gnu \
  memset_3d_index_generator.llvm \
  memset_3d_reference.llvm \
  memset_3d_reference.intel \
  memset_3d_reference.gnu \
  stream_triad_index_generator.llvm \
  stream_triad_reference.llvm \
  stream_triad_reference.intel \
  stream_triad_reference.gnu \
  matrix_multiply_index_generator.llvm \
  matrix_multiply_reference.llvm \
  matrix_multiply_reference.intel \
  matrix_multiply_reference.gnu \
  stencil_3d_7point_index_generator.llvm \
  stencil_3d_7point_reference.llvm \
  stencil_3d_7point_reference.intel \
  stencil_3d_7point_reference.gnu

KERNELASMS=$(KERNELS:=.asm)

LLVMKERNELS=$(filter %.llvm,$(KERNELS))

KERNELOPTIRS=$(LLVMKERNELS:=.opt.ir)

KERNELUNOPTIRS=$(LLVMKERNELS:=.unopt.ir)

KERNELREPORTS=$(KERNELS:=.report)

DIRECTORY=$(CURDIR)/build

RULER=********************************************************************************

###############################################################################

all: $(TESTS) kernel-asms kernel-opt-irs kernel-unopt-irs kernel-reports

kernel-asms: $(KERNELASMS)

kernel-opt-irs: $(KERNELOPTIRS)

kernel-unopt-irs: $(KERNELUNOPTIRS)

kernel-reports: $(KERNELREPORTS)

directory: $(DIRECTORY)/

clean:
	@echo "Cleaning build directory"
	@rm -f $(DIRECTORY)/*
	@if [ -d "$(DIRECTORY)" ]; then rmdir $(DIRECTORY); fi

.PHONY: directory kernel-asms kernel-opt-irs kernel-unopt-irs kernel-reports clean

%.llvm : %.cpp directory
	@echo "$(RULER)" 
	@echo "Building $(*F).llvm"
	$(LLVMCXX) $(CXXFLAGS) $(LLVMCXXFLAGS) $(LLVMDIAGFLAGS) $< -o $(CURDIR)/build/$(*F).llvm $(LINKFLAGS) $(LLVMLINKFLAGS)
	@if [ $(RUN) -eq 1 ]; then echo "$(RULER)"; echo "Running $(*F).llvm"; build/$(*F).llvm; fi
	@echo "$(RULER)"
	@echo

%.intel : %.cpp directory
	@echo "$(RULER)" 
	@echo "Building $(*F).intel"
	$(INTELCXX) $(CXXFLAGS) $(INTELCXXFLAGS) $(INTELDIAGFLAGS) $< -o $(CURDIR)/build/$(*F).intel $(LINKFLAGS) $(INTELLINKFLAGS)
	@if [ $(RUN) -eq 1 ]; then echo "$(RULER)"; echo "Running $(*F).intel"; build/$(*F).intel; fi
	@echo "$(RULER)"
	@echo

%.gnu : %.cpp directory
	@echo "$(RULER)" 
	@echo "Building $(*F).gnu"
	$(GNUCXX) $(CXXFLAGS) $(GNUCXXFLAGS) $(GNUDIAGFLAGS) $< -o $(CURDIR)/build/$(*F).gnu $(LINKFLAGS) $(GNULINKFLAGS)
	@if [ $(RUN) -eq 1 ]; then echo "$(RULER)"; echo "Running $(*F).gnu"; build/$(*F).gnu; fi
	@echo "$(RULER)"
	@echo


%.llvm.asm : %.cpp directory
	@echo "$(RULER)" 
	@echo "Generating assembly for $(*F).llvm"
	$(LLVMCXX) $(CXXFLAGS) $(LLVMCXXFLAGS) $(LLVMDIAGFLAGS) $(LLVMASMFLAGS) -S $< -o $(CURDIR)/build/$(*F).llvm.asm
	@echo "$(RULER)"
	@echo

%.intel.asm : %.cpp directory
	@echo "$(RULER)" 
	@echo "Generating assembly for $(*F).intel"
	$(INTELCXX) $(CXXFLAGS) $(INTELCXXFLAGS) $(INTELDIAGFLAGS) $(INTELASMFLAGS) -S $< -o $(CURDIR)/build/$(*F).intel.asm
	@echo "$(RULER)"
	@echo

%.gnu.asm : %.cpp directory
	@echo "$(RULER)" 
	@echo "Generating assembly for $(*F).gnu"
	$(GNUCXX) $(CXXFLAGS) $(GNUCXXFLAGS) $(GNUDIAGFLAGS) $(GNUASMFLAGS) -S $< -o $(CURDIR)/build/$(*F).gnu.asm
	@echo "$(RULER)"
	@echo


%.llvm.opt.ir : %.cpp directory
	@echo "$(RULER)" 
	@echo "Generating optimized IR for $(*F).llvm"
	$(LLVMCXX) $(CXXFLAGS) $(LLVMCXXFLAGS) $(LLVMDIAGFLAGS) $(LLVMOPTIRFLAGS) -S $< -o $(CURDIR)/build/$(*F).llvm.opt.ir
	@echo "$(RULER)"
	@echo

%.llvm.unopt.ir : %.cpp directory
	@echo "$(RULER)" 
	@echo "Generating unoptimized IR for $(*F).llvm"
	$(LLVMCXX) $(CXXFLAGS) $(LLVMCXXFLAGS) $(LLVMDIAGFLAGS) $(LLVMUNOPTIRFLAGS) -S $< -o $(CURDIR)/build/$(*F).llvm.unopt.ir
	@echo "$(RULER)"
	@echo


%.llvm.report : %.cpp directory
	@echo "$(RULER)" 
	@echo "Generating optimization report for $(*F).llvm"
	$(LLVMCXX) $(CXXFLAGS) $(LLVMCXXFLAGS) $(LLVMDIAGFLAGS) $(LLVMASMFLAGS) $(call LLVMREPORTFLAGS,$(CURDIR)/build/$(*F).llvm.yaml) -c $< -o /dev/null 
	$(LLVMOPTREPORT) -r $(CURDIR) -o $(CURDIR)/build/$(*F).llvm.report $(CURDIR)/build/$(*F).llvm.yaml
	@echo "$(RULER)"
	@echo

%.intel.report : %.cpp directory
	@echo "$(RULER)" 
	@echo "Generating optimization report for $(*F).intel"
	$(INTELCXX) $(CXXFLAGS) $(INTELCXXFLAGS) $(INTELDIAGFLAGS) $(INTELASMFLAGS) $(call INTELREPORTFLAGS,$(CURDIR)/build/$(*F).intel.report) -c $< -o /dev/null 
	@echo "$(RULER)"
	@echo

%.gnu.report : %.cpp directory
	@echo "$(RULER)" 
	@echo "Generating optimization report for $(*F).gnu"
	$(GNUCXX) $(CXXFLAGS) $(GNUCXXFLAGS) $(GNUDIAGFLAGS) $(GNUASMFLAGS) $(call GNUREPORTFLAGS,$(CURDIR)/build/$(*F).gnu.report) -c $< -o /dev/null
	@echo "$(RULER)"
	@echo


$(DIRECTORY)/:
	@mkdir -p $@ 

