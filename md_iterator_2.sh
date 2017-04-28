#! /bin/bash
#LLVMROOT=`realpath ~/development/llvm/INSTALL_RELEASE`
LLVMROOT=`realpath ~/development/gor-llvm/INSTALL_RELEASE`
#LLVMROOT=`realpath /project/projectdirs/m888/wash/development/gor-llvm/INSTALL_RELEASE`

FLAGS="
       -stdlib=libc++
       -std=c++1z -fcoroutines-ts
       -fno-exceptions -fno-rtti
       -g0 -O3 -fvectorize -march=native
       -fstrict-aliasing
       -fomit-frame-pointer
       -fno-asynchronous-unwind-tables -fno-unwind-tables
       -fverbose-asm
       -Rpass=loop-vectorize
       -Rpass-analysis=loop-vectorize
       -Wall
      "

export LD_LIBRARY_PATH=${LLVMROOT}/lib:${LD_LIBRARY_PATH}

#${LLVMROOT}/bin/clang++ ${FLAGS} -DTRANSFORM_ITERATOR -DTEST -Wl,-rpath=${LLVMROOT}/lib md_iterator_2.cpp -o md_iterator_2
#${LLVMROOT}/bin/clang++ ${FLAGS} -c fib_generator.cpp -o fib_generator.o
${LLVMROOT}/bin/clang++ ${FLAGS} -DTRANSFORM_ITERATOR -S md_iterator_2.cpp -o md_iterator_2_transform_iterator.asm
${LLVMROOT}/bin/clang++ ${FLAGS} -DTRANSFORM_ITERATOR -emit-llvm -S md_iterator_2.cpp -o md_iterator_2_transform_iterator.ir
${LLVMROOT}/bin/clang++ ${FLAGS} -DTRANSFORM_LOOP -S md_iterator_2.cpp -o md_iterator_2_transform_loop.asm
${LLVMROOT}/bin/clang++ ${FLAGS} -DTRANSFORM_LOOP -emit-llvm -S md_iterator_2.cpp -o md_iterator_2_transform_loop.ir

