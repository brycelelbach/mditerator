#! /bin/bash
#LLVMROOT=`realpath ~/development/llvm/INSTALL_RELEASE`
LLVMROOT=`realpath ~/development/gor-llvm/INSTALL_RELEASE`
#LLVMROOT=`realpath /project/projectdirs/m888/wash/development/gor-llvm/INSTALL_RELEASE`

FLAGS="
       -stdlib=libc++
       -std=c++1z -fcoroutines-ts
       -fno-exceptions -fno-rtti
       -O3 -fvectorize
       -fomit-frame-pointer
       -fno-asynchronous-unwind-tables -fno-unwind-tables
      "
#       -fno-asynchronous-unwind-tables

export LD_LIBRARY_PATH=${LLVMROOT}/lib:${LD_LIBRARY_PATH}

#${LLVMROOT}/bin/clang++ ${FLAGS} -Wl,-rpath=${LLVMROOT}/lib fib_generator.cpp -o fib_generator
${LLVMROOT}/bin/clang++ ${FLAGS} -c fib_generator.cpp -o fib_generator.o
${LLVMROOT}/bin/clang++ ${FLAGS} -S fib_generator.cpp -o fib_generator.asm
${LLVMROOT}/bin/clang++ ${FLAGS} -emit-llvm -S fib_generator.cpp -o fib_generator.ir

