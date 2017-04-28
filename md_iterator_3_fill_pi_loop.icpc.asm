# mark_description "Intel(R) C++ Intel(R) 64 Compiler for applications running on Intel(R) 64, Version 17.0.2.174 Build 20170213";
# mark_description "";
# mark_description "-std=c++14 -fno-exceptions -fno-rtti -g0 -O3 -xAVX2 -fast -fstrict-aliasing -fomit-frame-pointer -fno-asynch";
# mark_description "ronous-unwind-tables -fno-dwarf2-cfi-asm -Wall -DFILL_PI_LOOP -fcode-asm -fsource-asm -no-ipo -S -o md_itera";
# mark_description "tor_3_fill_pi_loop.icpc.asm";
	.file "md_iterator_3.cpp"
	.text
..TXTST0:
# -- Begin  _Z15fill_pi_loop_NNlPd
	.text
# mark_begin;
       .align    16,0x90
	.globl _Z15fill_pi_loop_NNlPd
# --- fill_pi_loop_NN(std::ptrdiff_t, double *)
_Z15fill_pi_loop_NNlPd:
# parameter 1: %rdi
# parameter 2: %rsi
..B1.1:                         # Preds ..B1.0
                                # Execution count [1.00e+00]

### {

..L1:
                                                          #md_iterator_3.cpp:736.1

###     BOOST_BUILTIN_ASSUME((N % 32) == 0);
###     BOOST_BUILTIN_ASSUME_ALIGNED(A, 32);
### 
###     BOOST_DEMAND_VECTORIZATION
###     for (std::ptrdiff_t j = 0; j != N; ++j)
###         for (std::ptrdiff_t i = 0; i != N; ++i)

        testq     %rdi, %rdi                                    #md_iterator_3.cpp:742.9
        je        ..B1.8        # Prob 50%                      #md_iterator_3.cpp:742.9
                                # LOE rbx rbp rsi rdi r12 r13 r14 r15
..B1.2:                         # Preds ..B1.1
                                # Execution count [9.00e-01]
        cmpq      $2, %rdi                                      #md_iterator_3.cpp:741.5
        jl        ..B1.8        # Prob 10%                      #md_iterator_3.cpp:741.5
                                # LOE rbx rbp rsi rdi r12 r13 r14 r15
..B1.3:                         # Preds ..B1.2
                                # Execution count [4.00e-01]
        movq      %rdi, %rcx                                    #md_iterator_3.cpp:741.5

###             A[i + j * N] = 3.14F;

        movq      %rdi, %rax                                    #md_iterator_3.cpp:743.13
        andq      $-2, %rcx                                     #md_iterator_3.cpp:741.5
        vmovupd   .L_2il0floatpacket.0(%rip), %xmm0             #md_iterator_3.cpp:743.28
        xorl      %edx, %edx                                    #md_iterator_3.cpp:741.5
        shlq      $4, %rax                                      #md_iterator_3.cpp:743.13
                                # LOE rax rdx rcx rbx rbp rsi rdi r12 r13 r14 r15 xmm0
..B1.4:                         # Preds ..B1.6 ..B1.3
                                # Execution count [4.50e+00]
        xorl      %r8d, %r8d                                    #md_iterator_3.cpp:742.9
                                # LOE rax rdx rcx rbx rbp rsi rdi r8 r12 r13 r14 r15 xmm0
..B1.5:                         # Preds ..B1.5 ..B1.4
                                # Execution count [2.50e+01]
        lea       (%rsi,%r8,8), %r9                             #md_iterator_3.cpp:743.13
        incq      %r8                                           #md_iterator_3.cpp:742.9
        vmovsd    %xmm0, (%r9)                                  #md_iterator_3.cpp:743.13
        vmovhpd   %xmm0, (%r9,%rdi,8)                           #md_iterator_3.cpp:743.13
        cmpq      %rdi, %r8                                     #md_iterator_3.cpp:742.9
        jb        ..B1.5        # Prob 82%                      #md_iterator_3.cpp:742.9
                                # LOE rax rdx rcx rbx rbp rsi rdi r8 r12 r13 r14 r15 xmm0
..B1.6:                         # Preds ..B1.5
                                # Execution count [5.00e+00]
        addq      $2, %rdx                                      #md_iterator_3.cpp:741.5
        addq      %rax, %rsi                                    #md_iterator_3.cpp:741.5
        cmpq      %rcx, %rdx                                    #md_iterator_3.cpp:741.5
        jb        ..B1.4        # Prob 82%                      #md_iterator_3.cpp:741.5
                                # LOE rax rdx rcx rbx rbp rsi rdi r12 r13 r14 r15 xmm0
..B1.8:                         # Preds ..B1.6 ..B1.2 ..B1.1
                                # Execution count [1.00e+00]

### }

        ret                                                     #md_iterator_3.cpp:744.1
        .align    16,0x90
                                # LOE
# mark_end;
	.type	_Z15fill_pi_loop_NNlPd,@function
	.size	_Z15fill_pi_loop_NNlPd,.-_Z15fill_pi_loop_NNlPd
	.data
# -- End  _Z15fill_pi_loop_NNlPd
	.text
# -- Begin  _Z15fill_pi_loop_NMllPd
	.text
# mark_begin;
       .align    16,0x90
	.globl _Z15fill_pi_loop_NMllPd
# --- fill_pi_loop_NM(std::ptrdiff_t, std::ptrdiff_t, double *)
_Z15fill_pi_loop_NMllPd:
# parameter 1: %rdi
# parameter 2: %rsi
# parameter 3: %rdx
..B2.1:                         # Preds ..B2.0
                                # Execution count [1.00e+00]

### {

..L2:
                                                          #md_iterator_3.cpp:751.1
        movq      %rdi, %r8                                     #md_iterator_3.cpp:751.1

###     BOOST_BUILTIN_ASSUME((N % 32) == 0);
###     BOOST_BUILTIN_ASSUME((M % 32) == 0);
###     BOOST_BUILTIN_ASSUME_ALIGNED(A, 32);
### 
###     BOOST_DEMAND_VECTORIZATION
###     for (std::ptrdiff_t j = 0; j != M; ++j)
###         for (std::ptrdiff_t i = 0; i != N; ++i)

        testq     %rsi, %rsi                                    #md_iterator_3.cpp:758.9
        je        ..B2.10       # Prob 50%                      #md_iterator_3.cpp:758.9
                                # LOE rdx rbx rbp rsi r8 r12 r13 r14 r15
..B2.2:                         # Preds ..B2.1
                                # Execution count [9.00e-01]
        cmpq      $2, %rsi                                      #md_iterator_3.cpp:757.5
        jl        ..B2.10       # Prob 10%                      #md_iterator_3.cpp:757.5
                                # LOE rdx rbx rbp rsi r8 r12 r13 r14 r15
..B2.3:                         # Preds ..B2.2
                                # Execution count [9.00e-01]
        xorl      %edi, %edi                                    #md_iterator_3.cpp:757.5

###             A[i + j * N] = 3.14F;

        movq      %r8, %rcx                                     #md_iterator_3.cpp:759.13
        andq      $-2, %rsi                                     #md_iterator_3.cpp:757.5
        vmovupd   .L_2il0floatpacket.0(%rip), %xmm0             #md_iterator_3.cpp:759.28
        xorl      %eax, %eax                                    #md_iterator_3.cpp:757.5
        shlq      $4, %rcx                                      #md_iterator_3.cpp:759.13
                                # LOE rax rdx rcx rbx rbp rsi rdi r8 r12 r13 r14 r15 xmm0
..B2.4:                         # Preds ..B2.8 ..B2.3
                                # Execution count [5.00e+00]
        xorl      %r10d, %r10d                                  #md_iterator_3.cpp:758.9
        testq     %r8, %r8                                      #md_iterator_3.cpp:758.41
        je        ..B2.8        # Prob 10%                      #md_iterator_3.cpp:758.41
                                # LOE rax rdx rcx rbx rbp rsi rdi r8 r10 r12 r13 r14 r15 xmm0
..B2.5:                         # Preds ..B2.4
                                # Execution count [4.50e+00]
        lea       (%rdx,%rax), %r9                              #md_iterator_3.cpp:759.13
                                # LOE rax rdx rcx rbx rbp rsi rdi r8 r9 r10 r12 r13 r14 r15 xmm0
..B2.6:                         # Preds ..B2.6 ..B2.5
                                # Execution count [2.50e+01]
        lea       (%r9,%r10,8), %r11                            #md_iterator_3.cpp:759.13
        incq      %r10                                          #md_iterator_3.cpp:758.9
        vmovsd    %xmm0, (%r11)                                 #md_iterator_3.cpp:759.13
        vmovhpd   %xmm0, (%r11,%r8,8)                           #md_iterator_3.cpp:759.13
        cmpq      %r8, %r10                                     #md_iterator_3.cpp:758.9
        jb        ..B2.6        # Prob 82%                      #md_iterator_3.cpp:758.9
                                # LOE rax rdx rcx rbx rbp rsi rdi r8 r9 r10 r12 r13 r14 r15 xmm0
..B2.8:                         # Preds ..B2.6 ..B2.4
                                # Execution count [5.00e+00]
        addq      $2, %rdi                                      #md_iterator_3.cpp:757.5
        addq      %rcx, %rax                                    #md_iterator_3.cpp:757.5
        cmpq      %rsi, %rdi                                    #md_iterator_3.cpp:757.5
        jb        ..B2.4        # Prob 82%                      #md_iterator_3.cpp:757.5
                                # LOE rax rdx rcx rbx rbp rsi rdi r8 r12 r13 r14 r15 xmm0
..B2.10:                        # Preds ..B2.8 ..B2.1 ..B2.2
                                # Execution count [1.00e+00]

### }

        ret                                                     #md_iterator_3.cpp:760.1
        .align    16,0x90
                                # LOE
# mark_end;
	.type	_Z15fill_pi_loop_NMllPd,@function
	.size	_Z15fill_pi_loop_NMllPd,.-_Z15fill_pi_loop_NMllPd
	.data
# -- End  _Z15fill_pi_loop_NMllPd
	.text
# -- Begin  __sti__$E
	.text
# mark_begin;
       .align    16,0x90
# --- __sti__$E()
__sti__$E:
..B3.1:                         # Preds ..B3.0
                                # Execution count [1.00e+00]
..L3:
                                                          #
        pushq     %rsi                                          #

###   static ios_base::Init __ioinit;

        movl      $_ZN39_INTERNAL_17_md_iterator_3_cpp_794821caSt8__ioinitE, %edi #/opt/gcc/6.3.0/snos/include/g++/iostream:74.25
#       std::ios_base::Init::Init(std::ios_base::Init *)
        call      _ZNSt8ios_base4InitC1Ev                       #/opt/gcc/6.3.0/snos/include/g++/iostream:74.25
                                # LOE rbx rbp r12 r13 r14 r15
..B3.2:                         # Preds ..B3.1
                                # Execution count [1.00e+00]
        movl      $_ZNSt8ios_base4InitD1Ev, %edi                #/opt/gcc/6.3.0/snos/include/g++/iostream:74.25
        movl      $_ZN39_INTERNAL_17_md_iterator_3_cpp_794821caSt8__ioinitE, %esi #/opt/gcc/6.3.0/snos/include/g++/iostream:74.25
        movl      $__dso_handle, %edx                           #/opt/gcc/6.3.0/snos/include/g++/iostream:74.25
        addq      $8, %rsp                                      #/opt/gcc/6.3.0/snos/include/g++/iostream:74.25
#       __cxa_atexit()
        jmp       __cxa_atexit                                  #/opt/gcc/6.3.0/snos/include/g++/iostream:74.25
        .align    16,0x90
                                # LOE
# mark_end;
	.type	__sti__$E,@function
	.size	__sti__$E,.-__sti__$E
	.data
# -- End  __sti__$E
	.bss
	.align 4
	.align 1
_ZN39_INTERNAL_17_md_iterator_3_cpp_794821caSt8__ioinitE:
	.type	_ZN39_INTERNAL_17_md_iterator_3_cpp_794821caSt8__ioinitE,@object
	.size	_ZN39_INTERNAL_17_md_iterator_3_cpp_794821caSt8__ioinitE,1
	.space 1	# pad
	.section .rodata, "a"
	.align 16
	.align 16
.L_2il0floatpacket.0:
	.long	0x60000000,0x40091eb8,0x60000000,0x40091eb8
	.type	.L_2il0floatpacket.0,@object
	.size	.L_2il0floatpacket.0,16
	.section .ctors, "wa"
	.align 8
__init_0:
	.type	__init_0,@object
	.size	__init_0,8
	.quad	__sti__$E
	.data
	.hidden __dso_handle
# mark_proc_addr_taken __sti__$E;
	.section .note.GNU-stack, ""
# End
