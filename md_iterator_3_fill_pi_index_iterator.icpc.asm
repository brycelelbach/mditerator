# mark_description "Intel(R) C++ Intel(R) 64 Compiler for applications running on Intel(R) 64, Version 17.0.2.174 Build 20170213";
# mark_description "";
# mark_description "-std=c++14 -fno-exceptions -fno-rtti -g0 -O3 -xAVX2 -fast -fstrict-aliasing -fomit-frame-pointer -fno-asynch";
# mark_description "ronous-unwind-tables -fno-dwarf2-cfi-asm -Wall -DFILL_PI_INDEX_ITERATOR -fcode-asm -fsource-asm -no-ipo -S -";
# mark_description "o md_iterator_3_fill_pi_index_iterator.icpc.asm";
	.file "md_iterator_3.cpp"
	.text
..TXTST0:
# -- Begin  _Z40fill_pi_index_iterator_sentinel_range_NNlRSt6vectorIdSaIdEE
	.text
# mark_begin;
       .align    16,0x90
	.globl _Z40fill_pi_index_iterator_sentinel_range_NNlRSt6vectorIdSaIdEE
# --- fill_pi_index_iterator_sentinel_range_NN(std::ptrdiff_t, std::vector<double, std::allocator<double>> &)
_Z40fill_pi_index_iterator_sentinel_range_NNlRSt6vectorIdSaIdEE:
# parameter 1: %rdi
# parameter 2: %rsi
..B1.1:                         # Preds ..B1.0
                                # Execution count [1.00e+00]

### {

..L1:
                                                          #md_iterator_3.cpp:688.1
        pushq     %rbp                                          #md_iterator_3.cpp:688.1
        movq      %rsp, %rbp                                    #md_iterator_3.cpp:688.1
        andq      $-32, %rsp                                    #md_iterator_3.cpp:688.1
        movq      %rdi, %r11                                    #md_iterator_3.cpp:688.1

###     double* __restrict__ A = vA.data();

        movq      (%rsi), %r10                                  #md_iterator_3.cpp:689.33

### 
###     BOOST_BUILTIN_ASSUME((N % 32) == 0);
###     BOOST_BUILTIN_ASSUME_ALIGNED(A, 32);
###    
###     auto&& r   = index_2d_iterator_sentinel_range{N, N};

        vpxor     %xmm14, %xmm14, %xmm14                        #md_iterator_3.cpp:694.54
        vmovups   %xmm14, -64(%rsp)                             #md_iterator_3.cpp:694.54
                                # LOE rbx r10 r11 r12 r13 r14 r15 xmm14
..B1.2:                         # Preds ..B1.1
                                # Execution count [1.00e+00]
        vmovups   %xmm14, -32(%rsp)                             #md_iterator_3.cpp:694.54
                                # LOE rbx r10 r11 r12 r13 r14 r15 xmm14
..B1.3:                         # Preds ..B1.2
                                # Execution count [1.00e+00]
        vmovd     %r11, %xmm5                                   #md_iterator_3.cpp:694.54
        vmovhpd   -24(%rsp), %xmm5, %xmm1                       #md_iterator_3.cpp:694.54
        vmovhpd   -56(%rsp), %xmm5, %xmm0                       #md_iterator_3.cpp:694.54
        vmovups   %xmm1, -80(%rsp)                              #md_iterator_3.cpp:694.54
        vmovups   %xmm0, -96(%rsp)                              #md_iterator_3.cpp:694.54
        movq      -72(%rsp), %rcx                               #md_iterator_3.cpp:694.54
        movq      -96(%rsp), %r9                                #md_iterator_3.cpp:694.54
        movq      -88(%rsp), %rsi                               #md_iterator_3.cpp:694.54
        movq      %r11, -64(%rsp)                               #md_iterator_3.cpp:694.54
        movq      %r11, -32(%rsp)                               #md_iterator_3.cpp:694.54

###     auto first = r.begin();
###     auto last  = r.end();
### 
###     BOOST_DEMAND_VECTORIZATION
###     for (; first != last; ++first)

        cmpq      %r11, %rcx                                    #md_iterator_3.cpp:699.12
        je        ..B1.21       # Prob 78%                      #md_iterator_3.cpp:699.12
                                # LOE rcx rbx rsi r9 r10 r11 r12 r13 r14 r15 xmm5 xmm14
..B1.4:                         # Preds ..B1.3
                                # Execution count [2.20e-01]
        movq      %r11, %rax                                    #md_iterator_3.cpp:694.54
        movq      %rsi, %r8                                     #md_iterator_3.cpp:699.5
        subq      %rcx, %rax                                    #md_iterator_3.cpp:694.54
        subq      %r9, %r8                                      #md_iterator_3.cpp:699.5
        imulq     %r9, %rax                                     #md_iterator_3.cpp:699.5
        addq      %rax, %r8                                     #md_iterator_3.cpp:699.5

###     {

        je        ..B1.21       # Prob 50%                      #md_iterator_3.cpp:700.5
                                # LOE rcx rbx rsi r8 r9 r10 r11 r12 r13 r14 r15 xmm5 xmm14
..B1.5:                         # Preds ..B1.4
                                # Execution count [1.98e-01]
        cmpq      $2, %r8                                       #md_iterator_3.cpp:700.5
        jl        ..B1.22       # Prob 10%                      #md_iterator_3.cpp:700.5
                                # LOE rcx rbx rsi r8 r9 r10 r11 r12 r13 r14 r15 xmm5 xmm14
..B1.6:                         # Preds ..B1.5
                                # Execution count [0.00e+00]
        vmovd     %r9, %xmm7                                    #md_iterator_3.cpp:694.54
        vmovd     %rsi, %xmm10                                  #md_iterator_3.cpp:694.54
        vpbroadcastq %xmm5, %xmm5                               #md_iterator_3.cpp:684.6
        movq      %r8, %rdi                                     #md_iterator_3.cpp:700.5
        vpbroadcastq %xmm7, %xmm7                               #md_iterator_3.cpp:694.54
        movq      %r10, %rdx                                    #md_iterator_3.cpp:692.5
        xorl      %eax, %eax                                    #md_iterator_3.cpp:700.5
        vmovd     %rcx, %xmm0                                   #md_iterator_3.cpp:694.54
        vmovdqu   .L_2il0floatpacket.8(%rip), %xmm13            #md_iterator_3.cpp:700.5

###         auto pos = *first;
###         A[pos.i + pos.j * N] = 3.14F;

        vpsrlq    $32, %xmm5, %xmm6                             #md_iterator_3.cpp:702.27
        vmovdqu   .L_2il0floatpacket.9(%rip), %xmm12            #md_iterator_3.cpp:700.5
        vpcmpeqd  %xmm2, %xmm2, %xmm2                           #md_iterator_3.cpp:699.5
        vmovdqu   .L_2il0floatpacket.10(%rip), %xmm1            #md_iterator_3.cpp:702.9
        andq      $-2, %rdi                                     #md_iterator_3.cpp:700.5
        vpbroadcastq %xmm10, %xmm10                             #md_iterator_3.cpp:694.54
        vpbroadcastq %xmm0, %xmm0                               #md_iterator_3.cpp:694.54
        vmovupd   .L_2il0floatpacket.11(%rip), %xmm3            #md_iterator_3.cpp:702.32
        vmovddup  8+.L_2il0floatpacket.11(%rip), %xmm4          #md_iterator_3.cpp:702.32
        vmovdqu   %xmm7, -64(%rsp)                              #md_iterator_3.cpp:694.54[spill]
        movq      %r14, -96(%rsp)                               #md_iterator_3.cpp:694.54[spill]
        movq      %r15, -88(%rsp)                               #md_iterator_3.cpp:694.54[spill]
        movq      %rbx, -80(%rsp)                               #md_iterator_3.cpp:694.54[spill]
        xorl      %ebx, %ebx                                    #md_iterator_3.cpp:694.54
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11 r12 r13 xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm10 xmm12 xmm13 xmm14
..B1.7:                         # Preds ..B1.11 ..B1.6
                                # Execution count [0.00e+00]
        vpaddq    %xmm2, %xmm12, %xmm9                          #md_iterator_3.cpp:699.5
        vpsrldq   $8, %xmm9, %xmm8                              #md_iterator_3.cpp:699.5
        vmovdqa   %xmm10, %xmm11                                #md_iterator_3.cpp:694.54
        vpcmpgtq  %xmm8, %xmm9, %xmm15                          #md_iterator_3.cpp:699.5
        vmovdqa   %xmm0, %xmm7                                  #md_iterator_3.cpp:694.54
        vpblendvb %xmm15, %xmm9, %xmm8, %xmm8                   #md_iterator_3.cpp:699.5
        vpcmpeqq  %xmm1, %xmm14, %xmm15                         #md_iterator_3.cpp:699.5
        vmovd     %xmm8, %r15                                   #md_iterator_3.cpp:699.5
        vpxor     %xmm15, %xmm2, %xmm8                          #md_iterator_3.cpp:699.5
        vptest    %xmm2, %xmm8                                  #md_iterator_3.cpp:699.5
        je        ..B1.11       # Prob 20%                      #md_iterator_3.cpp:699.5
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11 r12 r13 r15 xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm14
..B1.8:                         # Preds ..B1.7
                                # Execution count [9.90e-01]
        vmovdqu   %xmm12, -48(%rsp)                             #md_iterator_3.cpp:699.5[spill]
        movq      %rbx, %r14                                    #md_iterator_3.cpp:699.5
        vmovdqu   -64(%rsp), %xmm13                             #md_iterator_3.cpp:699.5[spill]
        vmovdqu   .L_2il0floatpacket.12(%rip), %xmm14           #md_iterator_3.cpp:699.5
        .align    16,0x90
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11 r12 r13 r14 r15 xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B1.9:                         # Preds ..B1.9 ..B1.8
                                # Execution count [5.50e+00]
        vmovd     %r14, %xmm15                                  #md_iterator_3.cpp:699.5
        incq      %r14                                          #md_iterator_3.cpp:699.5
        vpbroadcastq %xmm15, %xmm12                             #md_iterator_3.cpp:699.5
        vpcmpgtq  %xmm12, %xmm9, %xmm15                         #md_iterator_3.cpp:699.5
        vpaddq    %xmm14, %xmm11, %xmm12                        #md_iterator_3.cpp:695.10
        vpand     %xmm15, %xmm8, %xmm8                          #md_iterator_3.cpp:699.5
        vpblendvb %xmm8, %xmm12, %xmm11, %xmm15                 #md_iterator_3.cpp:695.10
        vpcmpeqq  %xmm15, %xmm13, %xmm11                        #md_iterator_3.cpp:699.5
        vpand     %xmm11, %xmm8, %xmm12                         #md_iterator_3.cpp:699.5
        vpandn    %xmm15, %xmm12, %xmm11                        #md_iterator_3.cpp:695.10
        vpaddq    %xmm14, %xmm7, %xmm15                         #md_iterator_3.cpp:695.10
        vpblendvb %xmm12, %xmm15, %xmm7, %xmm7                  #md_iterator_3.cpp:695.10
        cmpq      %r15, %r14                                    #md_iterator_3.cpp:699.5
        jb        ..B1.9        # Prob 82%                      #md_iterator_3.cpp:699.5
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11 r12 r13 r14 r15 xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B1.10:                        # Preds ..B1.9
                                # Execution count [9.90e-01]
        vmovdqu   -48(%rsp), %xmm12                             #[spill]
        vmovdqu   .L_2il0floatpacket.8(%rip), %xmm13            #
        vpxor     %xmm14, %xmm14, %xmm14                        #
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11 r12 r13 xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm10 xmm11 xmm12 xmm13 xmm14
..B1.11:                        # Preds ..B1.10 ..B1.7
                                # Execution count [1.10e+00]
        vpsrlq    $32, %xmm7, %xmm8                             #md_iterator_3.cpp:702.27
        addq      $2, %rax                                      #md_iterator_3.cpp:700.5
        vpmuludq  %xmm7, %xmm6, %xmm9                           #md_iterator_3.cpp:702.27
        vpmuludq  %xmm5, %xmm8, %xmm15                          #md_iterator_3.cpp:702.27
        vpmuludq  %xmm5, %xmm7, %xmm7                           #md_iterator_3.cpp:702.27
        vpaddq    %xmm15, %xmm9, %xmm8                          #md_iterator_3.cpp:702.27
        vpaddq    %xmm13, %xmm12, %xmm12                        #md_iterator_3.cpp:700.5
        vpaddq    %xmm13, %xmm1, %xmm1                          #md_iterator_3.cpp:702.9
        vpsllq    $32, %xmm8, %xmm9                             #md_iterator_3.cpp:702.27
        vpaddq    %xmm7, %xmm9, %xmm7                           #md_iterator_3.cpp:702.27
        vpaddq    %xmm7, %xmm11, %xmm11                         #md_iterator_3.cpp:702.27
        vpunpckhqdq %xmm11, %xmm11, %xmm7                       #md_iterator_3.cpp:702.9
        vmovd     %xmm11, %r14                                  #md_iterator_3.cpp:702.9
        vmovd     %xmm7, %r15                                   #md_iterator_3.cpp:702.9
        vmovq     %xmm3, (%rdx,%r14,8)                          #md_iterator_3.cpp:702.9
        vmovq     %xmm4, (%rdx,%r15,8)                          #md_iterator_3.cpp:702.9
        cmpq      %rdi, %rax                                    #md_iterator_3.cpp:700.5
        jb        ..B1.7        # Prob 82%                      #md_iterator_3.cpp:700.5
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11 r12 r13 xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm10 xmm12 xmm13 xmm14
..B1.12:                        # Preds ..B1.11
                                # Execution count [1.98e-01]
        movq      -96(%rsp), %r14                               #[spill]
        movq      -88(%rsp), %r15                               #[spill]
        movq      -80(%rsp), %rbx                               #[spill]
                                # LOE rcx rbx rsi rdi r8 r9 r10 r11 r12 r13 r14 r15
..B1.13:                        # Preds ..B1.12 ..B1.22
                                # Execution count [2.20e-01]
        cmpq      %r8, %rdi                                     #md_iterator_3.cpp:700.5
        jae       ..B1.21       # Prob 9%                       #md_iterator_3.cpp:700.5
                                # LOE rcx rbx rsi rdi r8 r9 r10 r11 r12 r13 r14 r15
..B1.14:                        # Preds ..B1.13
                                # Execution count [1.98e-01]
        movq      %r13, -72(%rsp)                               #md_iterator_3.cpp:702.32[spill]
        movq      $0x40091eb860000000, %rax                     #md_iterator_3.cpp:702.32
        movq      %r14, -96(%rsp)                               #md_iterator_3.cpp:702.32[spill]
        xorl      %r14d, %r14d                                  #md_iterator_3.cpp:702.32
        movq      %r15, -88(%rsp)                               #md_iterator_3.cpp:702.32[spill]
        movq      %rbx, -80(%rsp)                               #md_iterator_3.cpp:702.32[spill]
                                # LOE rax rcx rsi rdi r8 r9 r10 r11 r12 r14
..B1.15:                        # Preds ..B1.19 ..B1.14
                                # Execution count [1.10e+00]
        movq      %rsi, %r13                                    #md_iterator_3.cpp:695.5
        movq      %rcx, %rbx                                    #md_iterator_3.cpp:695.5
        movq      %r14, %rdx                                    #md_iterator_3.cpp:699.5
        testq     %rdi, %rdi                                    #md_iterator_3.cpp:699.5
        je        ..B1.19       # Prob 10%                      #md_iterator_3.cpp:699.5
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11 r12 r13 r14
..B1.17:                        # Preds ..B1.15 ..B1.17
                                # Execution count [5.50e+00]
        incq      %r13                                          #md_iterator_3.cpp:699.5
        incq      %rdx                                          #md_iterator_3.cpp:699.5
        cmpq      %r13, %r9                                     #md_iterator_3.cpp:699.5
        lea       1(%rbx), %r15                                 #md_iterator_3.cpp:699.5
        cmove     %r15, %rbx                                    #md_iterator_3.cpp:699.5
        cmove     %r14, %r13                                    #md_iterator_3.cpp:699.5
        cmpq      %rdi, %rdx                                    #md_iterator_3.cpp:699.5
        jb        ..B1.17       # Prob 82%                      #md_iterator_3.cpp:699.5
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11 r12 r13 r14
..B1.19:                        # Preds ..B1.17 ..B1.15
                                # Execution count [1.10e+00]
        imulq     %r11, %rbx                                    #md_iterator_3.cpp:702.27
        addq      %rbx, %r13                                    #md_iterator_3.cpp:702.27
        incq      %rdi                                          #md_iterator_3.cpp:700.5
        movq      %rax, (%r10,%r13,8)                           #md_iterator_3.cpp:702.9
        cmpq      %r8, %rdi                                     #md_iterator_3.cpp:700.5
        jb        ..B1.15       # Prob 82%                      #md_iterator_3.cpp:700.5
                                # LOE rax rcx rsi rdi r8 r9 r10 r11 r12 r14
..B1.20:                        # Preds ..B1.19
                                # Execution count [1.98e-01]
        movq      -72(%rsp), %r13                               #[spill]
        movq      -96(%rsp), %r14                               #[spill]
        movq      -88(%rsp), %r15                               #[spill]
        movq      -80(%rsp), %rbx                               #[spill]
                                # LOE rbx r12 r13 r14 r15
..B1.21:                        # Preds ..B1.3 ..B1.4 ..B1.13 ..B1.20
                                # Execution count [1.00e+00]

###     }
### }

        movq      %rbp, %rsp                                    #md_iterator_3.cpp:704.1
        popq      %rbp                                          #md_iterator_3.cpp:704.1
        ret                                                     #md_iterator_3.cpp:704.1
                                # LOE
..B1.22:                        # Preds ..B1.5
                                # Execution count [1.98e-02]: Infreq
        xorl      %edi, %edi                                    #md_iterator_3.cpp:700.5
        jmp       ..B1.13       # Prob 100%                     #md_iterator_3.cpp:700.5
        .align    16,0x90
                                # LOE rcx rbx rsi rdi r8 r9 r10 r11 r12 r13 r14 r15
# mark_end;
	.type	_Z40fill_pi_index_iterator_sentinel_range_NNlRSt6vectorIdSaIdEE,@function
	.size	_Z40fill_pi_index_iterator_sentinel_range_NNlRSt6vectorIdSaIdEE,.-_Z40fill_pi_index_iterator_sentinel_range_NNlRSt6vectorIdSaIdEE
	.data
# -- End  _Z40fill_pi_index_iterator_sentinel_range_NNlRSt6vectorIdSaIdEE
	.text
# -- Begin  _Z40fill_pi_index_iterator_sentinel_range_NMllRSt6vectorIdSaIdEE
	.text
# mark_begin;
       .align    16,0x90
	.globl _Z40fill_pi_index_iterator_sentinel_range_NMllRSt6vectorIdSaIdEE
# --- fill_pi_index_iterator_sentinel_range_NM(std::ptrdiff_t, std::ptrdiff_t, std::vector<double, std::allocator<double>> &)
_Z40fill_pi_index_iterator_sentinel_range_NMllRSt6vectorIdSaIdEE:
# parameter 1: %rdi
# parameter 2: %rsi
# parameter 3: %rdx
..B2.1:                         # Preds ..B2.0
                                # Execution count [1.00e+00]

### {

..L2:
                                                          #md_iterator_3.cpp:711.1
        pushq     %rbp                                          #md_iterator_3.cpp:711.1
        movq      %rsp, %rbp                                    #md_iterator_3.cpp:711.1
        andq      $-32, %rsp                                    #md_iterator_3.cpp:711.1
        movq      %rsi, %rax                                    #md_iterator_3.cpp:711.1

###     double* __restrict__ A = vA.data();

        movq      (%rdx), %r10                                  #md_iterator_3.cpp:712.33

### 
###     BOOST_BUILTIN_ASSUME((N % 32) == 0);
###     BOOST_BUILTIN_ASSUME((M % 32) == 0);
###     BOOST_BUILTIN_ASSUME_ALIGNED(A, 32);
###    
###     auto&& r   = index_2d_iterator_sentinel_range{N, M};

        vpxor     %xmm14, %xmm14, %xmm14                        #md_iterator_3.cpp:718.54
        vmovups   %xmm14, -64(%rsp)                             #md_iterator_3.cpp:718.54
        movq      %rdi, %r11                                    #md_iterator_3.cpp:711.1
                                # LOE rax rbx r10 r11 r12 r13 r14 r15 xmm14
..B2.2:                         # Preds ..B2.1
                                # Execution count [1.00e+00]
        vmovups   %xmm14, -32(%rsp)                             #md_iterator_3.cpp:718.54
                                # LOE rax rbx r10 r11 r12 r13 r14 r15 xmm14
..B2.3:                         # Preds ..B2.2
                                # Execution count [1.00e+00]
        vmovd     %rax, %xmm1                                   #md_iterator_3.cpp:718.54
        vmovd     %r11, %xmm5                                   #md_iterator_3.cpp:718.54
        vmovhpd   -24(%rsp), %xmm1, %xmm2                       #md_iterator_3.cpp:718.54
        vmovhpd   -56(%rsp), %xmm5, %xmm0                       #md_iterator_3.cpp:718.54
        vmovups   %xmm2, -80(%rsp)                              #md_iterator_3.cpp:718.54
        vmovups   %xmm0, -96(%rsp)                              #md_iterator_3.cpp:718.54
        movq      -72(%rsp), %rcx                               #md_iterator_3.cpp:718.54
        movq      -96(%rsp), %r9                                #md_iterator_3.cpp:718.54
        movq      -88(%rsp), %rsi                               #md_iterator_3.cpp:718.54
        movq      %r11, -64(%rsp)                               #md_iterator_3.cpp:718.54
        movq      %rax, -32(%rsp)                               #md_iterator_3.cpp:718.54

###     auto first = r.begin();
###     auto last  = r.end();
### 
###     BOOST_DEMAND_VECTORIZATION
###     for (; first != last; ++first)

        cmpq      %rax, %rcx                                    #md_iterator_3.cpp:723.12
        je        ..B2.21       # Prob 78%                      #md_iterator_3.cpp:723.12
                                # LOE rax rcx rbx rsi r9 r10 r11 r12 r13 r14 r15 xmm5 xmm14
..B2.4:                         # Preds ..B2.3
                                # Execution count [2.20e-01]
        subq      %rcx, %rax                                    #md_iterator_3.cpp:718.54
        movq      %rsi, %r8                                     #md_iterator_3.cpp:723.5
        imulq     %r9, %rax                                     #md_iterator_3.cpp:723.5
        subq      %r9, %r8                                      #md_iterator_3.cpp:723.5
        addq      %rax, %r8                                     #md_iterator_3.cpp:723.5

###     {

        je        ..B2.21       # Prob 50%                      #md_iterator_3.cpp:724.5
                                # LOE rcx rbx rsi r8 r9 r10 r11 r12 r13 r14 r15 xmm5 xmm14
..B2.5:                         # Preds ..B2.4
                                # Execution count [1.98e-01]
        cmpq      $2, %r8                                       #md_iterator_3.cpp:724.5
        jl        ..B2.22       # Prob 10%                      #md_iterator_3.cpp:724.5
                                # LOE rcx rbx rsi r8 r9 r10 r11 r12 r13 r14 r15 xmm5 xmm14
..B2.6:                         # Preds ..B2.5
                                # Execution count [0.00e+00]
        vmovd     %r9, %xmm7                                    #md_iterator_3.cpp:718.54
        vmovd     %rsi, %xmm10                                  #md_iterator_3.cpp:718.54
        vpbroadcastq %xmm5, %xmm5                               #md_iterator_3.cpp:706.6
        movq      %r8, %rdi                                     #md_iterator_3.cpp:724.5
        vpbroadcastq %xmm7, %xmm7                               #md_iterator_3.cpp:718.54
        movq      %r10, %rdx                                    #md_iterator_3.cpp:716.5
        xorl      %eax, %eax                                    #md_iterator_3.cpp:724.5
        vmovd     %rcx, %xmm0                                   #md_iterator_3.cpp:718.54
        vmovdqu   .L_2il0floatpacket.8(%rip), %xmm13            #md_iterator_3.cpp:724.5

###         auto pos = *first;
###         A[pos.i + pos.j * N] = 3.14F;

        vpsrlq    $32, %xmm5, %xmm6                             #md_iterator_3.cpp:726.27
        vmovdqu   .L_2il0floatpacket.9(%rip), %xmm12            #md_iterator_3.cpp:724.5
        vpcmpeqd  %xmm2, %xmm2, %xmm2                           #md_iterator_3.cpp:723.5
        vmovdqu   .L_2il0floatpacket.10(%rip), %xmm1            #md_iterator_3.cpp:726.9
        andq      $-2, %rdi                                     #md_iterator_3.cpp:724.5
        vpbroadcastq %xmm10, %xmm10                             #md_iterator_3.cpp:718.54
        vpbroadcastq %xmm0, %xmm0                               #md_iterator_3.cpp:718.54
        vmovupd   .L_2il0floatpacket.11(%rip), %xmm3            #md_iterator_3.cpp:726.32
        vmovddup  8+.L_2il0floatpacket.11(%rip), %xmm4          #md_iterator_3.cpp:726.32
        vmovdqu   %xmm7, -64(%rsp)                              #md_iterator_3.cpp:718.54[spill]
        movq      %r14, -96(%rsp)                               #md_iterator_3.cpp:718.54[spill]
        movq      %r15, -88(%rsp)                               #md_iterator_3.cpp:718.54[spill]
        movq      %rbx, -80(%rsp)                               #md_iterator_3.cpp:718.54[spill]
        xorl      %ebx, %ebx                                    #md_iterator_3.cpp:718.54
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11 r12 r13 xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm10 xmm12 xmm13 xmm14
..B2.7:                         # Preds ..B2.11 ..B2.6
                                # Execution count [0.00e+00]
        vpaddq    %xmm2, %xmm12, %xmm9                          #md_iterator_3.cpp:723.5
        vpsrldq   $8, %xmm9, %xmm8                              #md_iterator_3.cpp:723.5
        vmovdqa   %xmm10, %xmm11                                #md_iterator_3.cpp:718.54
        vpcmpgtq  %xmm8, %xmm9, %xmm15                          #md_iterator_3.cpp:723.5
        vmovdqa   %xmm0, %xmm7                                  #md_iterator_3.cpp:718.54
        vpblendvb %xmm15, %xmm9, %xmm8, %xmm8                   #md_iterator_3.cpp:723.5
        vpcmpeqq  %xmm1, %xmm14, %xmm15                         #md_iterator_3.cpp:723.5
        vmovd     %xmm8, %r15                                   #md_iterator_3.cpp:723.5
        vpxor     %xmm15, %xmm2, %xmm8                          #md_iterator_3.cpp:723.5
        vptest    %xmm2, %xmm8                                  #md_iterator_3.cpp:723.5
        je        ..B2.11       # Prob 20%                      #md_iterator_3.cpp:723.5
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11 r12 r13 r15 xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm14
..B2.8:                         # Preds ..B2.7
                                # Execution count [9.90e-01]
        vmovdqu   %xmm12, -48(%rsp)                             #md_iterator_3.cpp:723.5[spill]
        movq      %rbx, %r14                                    #md_iterator_3.cpp:723.5
        vmovdqu   -64(%rsp), %xmm13                             #md_iterator_3.cpp:723.5[spill]
        vmovdqu   .L_2il0floatpacket.12(%rip), %xmm14           #md_iterator_3.cpp:723.5
        .align    16,0x90
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11 r12 r13 r14 r15 xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.9:                         # Preds ..B2.9 ..B2.8
                                # Execution count [5.50e+00]
        vmovd     %r14, %xmm15                                  #md_iterator_3.cpp:723.5
        incq      %r14                                          #md_iterator_3.cpp:723.5
        vpbroadcastq %xmm15, %xmm12                             #md_iterator_3.cpp:723.5
        vpcmpgtq  %xmm12, %xmm9, %xmm15                         #md_iterator_3.cpp:723.5
        vpaddq    %xmm14, %xmm11, %xmm12                        #md_iterator_3.cpp:719.10
        vpand     %xmm15, %xmm8, %xmm8                          #md_iterator_3.cpp:723.5
        vpblendvb %xmm8, %xmm12, %xmm11, %xmm15                 #md_iterator_3.cpp:719.10
        vpcmpeqq  %xmm15, %xmm13, %xmm11                        #md_iterator_3.cpp:723.5
        vpand     %xmm11, %xmm8, %xmm12                         #md_iterator_3.cpp:723.5
        vpandn    %xmm15, %xmm12, %xmm11                        #md_iterator_3.cpp:719.10
        vpaddq    %xmm14, %xmm7, %xmm15                         #md_iterator_3.cpp:719.10
        vpblendvb %xmm12, %xmm15, %xmm7, %xmm7                  #md_iterator_3.cpp:719.10
        cmpq      %r15, %r14                                    #md_iterator_3.cpp:723.5
        jb        ..B2.9        # Prob 82%                      #md_iterator_3.cpp:723.5
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11 r12 r13 r14 r15 xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.10:                        # Preds ..B2.9
                                # Execution count [9.90e-01]
        vmovdqu   -48(%rsp), %xmm12                             #[spill]
        vmovdqu   .L_2il0floatpacket.8(%rip), %xmm13            #
        vpxor     %xmm14, %xmm14, %xmm14                        #
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11 r12 r13 xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm10 xmm11 xmm12 xmm13 xmm14
..B2.11:                        # Preds ..B2.10 ..B2.7
                                # Execution count [1.10e+00]
        vpsrlq    $32, %xmm7, %xmm8                             #md_iterator_3.cpp:726.27
        addq      $2, %rax                                      #md_iterator_3.cpp:724.5
        vpmuludq  %xmm7, %xmm6, %xmm9                           #md_iterator_3.cpp:726.27
        vpmuludq  %xmm5, %xmm8, %xmm15                          #md_iterator_3.cpp:726.27
        vpmuludq  %xmm5, %xmm7, %xmm7                           #md_iterator_3.cpp:726.27
        vpaddq    %xmm15, %xmm9, %xmm8                          #md_iterator_3.cpp:726.27
        vpaddq    %xmm13, %xmm12, %xmm12                        #md_iterator_3.cpp:724.5
        vpaddq    %xmm13, %xmm1, %xmm1                          #md_iterator_3.cpp:726.9
        vpsllq    $32, %xmm8, %xmm9                             #md_iterator_3.cpp:726.27
        vpaddq    %xmm7, %xmm9, %xmm7                           #md_iterator_3.cpp:726.27
        vpaddq    %xmm7, %xmm11, %xmm11                         #md_iterator_3.cpp:726.27
        vpunpckhqdq %xmm11, %xmm11, %xmm7                       #md_iterator_3.cpp:726.9
        vmovd     %xmm11, %r14                                  #md_iterator_3.cpp:726.9
        vmovd     %xmm7, %r15                                   #md_iterator_3.cpp:726.9
        vmovq     %xmm3, (%rdx,%r14,8)                          #md_iterator_3.cpp:726.9
        vmovq     %xmm4, (%rdx,%r15,8)                          #md_iterator_3.cpp:726.9
        cmpq      %rdi, %rax                                    #md_iterator_3.cpp:724.5
        jb        ..B2.7        # Prob 82%                      #md_iterator_3.cpp:724.5
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11 r12 r13 xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm10 xmm12 xmm13 xmm14
..B2.12:                        # Preds ..B2.11
                                # Execution count [1.98e-01]
        movq      -96(%rsp), %r14                               #[spill]
        movq      -88(%rsp), %r15                               #[spill]
        movq      -80(%rsp), %rbx                               #[spill]
                                # LOE rcx rbx rsi rdi r8 r9 r10 r11 r12 r13 r14 r15
..B2.13:                        # Preds ..B2.12 ..B2.22
                                # Execution count [2.20e-01]
        cmpq      %r8, %rdi                                     #md_iterator_3.cpp:724.5
        jae       ..B2.21       # Prob 9%                       #md_iterator_3.cpp:724.5
                                # LOE rcx rbx rsi rdi r8 r9 r10 r11 r12 r13 r14 r15
..B2.14:                        # Preds ..B2.13
                                # Execution count [1.98e-01]
        movq      %r13, -72(%rsp)                               #md_iterator_3.cpp:726.32[spill]
        movq      $0x40091eb860000000, %rax                     #md_iterator_3.cpp:726.32
        movq      %r14, -96(%rsp)                               #md_iterator_3.cpp:726.32[spill]
        xorl      %r14d, %r14d                                  #md_iterator_3.cpp:726.32
        movq      %r15, -88(%rsp)                               #md_iterator_3.cpp:726.32[spill]
        movq      %rbx, -80(%rsp)                               #md_iterator_3.cpp:726.32[spill]
                                # LOE rax rcx rsi rdi r8 r9 r10 r11 r12 r14
..B2.15:                        # Preds ..B2.19 ..B2.14
                                # Execution count [1.10e+00]
        movq      %rsi, %r13                                    #md_iterator_3.cpp:719.5
        movq      %rcx, %rbx                                    #md_iterator_3.cpp:719.5
        movq      %r14, %rdx                                    #md_iterator_3.cpp:723.5
        testq     %rdi, %rdi                                    #md_iterator_3.cpp:723.5
        je        ..B2.19       # Prob 10%                      #md_iterator_3.cpp:723.5
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11 r12 r13 r14
..B2.17:                        # Preds ..B2.15 ..B2.17
                                # Execution count [5.50e+00]
        incq      %r13                                          #md_iterator_3.cpp:723.5
        incq      %rdx                                          #md_iterator_3.cpp:723.5
        cmpq      %r13, %r9                                     #md_iterator_3.cpp:723.5
        lea       1(%rbx), %r15                                 #md_iterator_3.cpp:723.5
        cmove     %r15, %rbx                                    #md_iterator_3.cpp:723.5
        cmove     %r14, %r13                                    #md_iterator_3.cpp:723.5
        cmpq      %rdi, %rdx                                    #md_iterator_3.cpp:723.5
        jb        ..B2.17       # Prob 82%                      #md_iterator_3.cpp:723.5
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11 r12 r13 r14
..B2.19:                        # Preds ..B2.17 ..B2.15
                                # Execution count [1.10e+00]
        imulq     %r11, %rbx                                    #md_iterator_3.cpp:726.27
        addq      %rbx, %r13                                    #md_iterator_3.cpp:726.27
        incq      %rdi                                          #md_iterator_3.cpp:724.5
        movq      %rax, (%r10,%r13,8)                           #md_iterator_3.cpp:726.9
        cmpq      %r8, %rdi                                     #md_iterator_3.cpp:724.5
        jb        ..B2.15       # Prob 82%                      #md_iterator_3.cpp:724.5
                                # LOE rax rcx rsi rdi r8 r9 r10 r11 r12 r14
..B2.20:                        # Preds ..B2.19
                                # Execution count [1.98e-01]
        movq      -72(%rsp), %r13                               #[spill]
        movq      -96(%rsp), %r14                               #[spill]
        movq      -88(%rsp), %r15                               #[spill]
        movq      -80(%rsp), %rbx                               #[spill]
                                # LOE rbx r12 r13 r14 r15
..B2.21:                        # Preds ..B2.3 ..B2.4 ..B2.13 ..B2.20
                                # Execution count [1.00e+00]

###     }
### }

        movq      %rbp, %rsp                                    #md_iterator_3.cpp:728.1
        popq      %rbp                                          #md_iterator_3.cpp:728.1
        ret                                                     #md_iterator_3.cpp:728.1
                                # LOE
..B2.22:                        # Preds ..B2.5
                                # Execution count [1.98e-02]: Infreq
        xorl      %edi, %edi                                    #md_iterator_3.cpp:724.5
        jmp       ..B2.13       # Prob 100%                     #md_iterator_3.cpp:724.5
        .align    16,0x90
                                # LOE rcx rbx rsi rdi r8 r9 r10 r11 r12 r13 r14 r15
# mark_end;
	.type	_Z40fill_pi_index_iterator_sentinel_range_NMllRSt6vectorIdSaIdEE,@function
	.size	_Z40fill_pi_index_iterator_sentinel_range_NMllRSt6vectorIdSaIdEE,.-_Z40fill_pi_index_iterator_sentinel_range_NMllRSt6vectorIdSaIdEE
	.data
# -- End  _Z40fill_pi_index_iterator_sentinel_range_NMllRSt6vectorIdSaIdEE
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
.L_2il0floatpacket.8:
	.long	0x00000002,0x00000000,0x00000002,0x00000000
	.type	.L_2il0floatpacket.8,@object
	.size	.L_2il0floatpacket.8,16
	.align 16
.L_2il0floatpacket.9:
	.long	0x00000001,0x00000000,0x00000002,0x00000000
	.type	.L_2il0floatpacket.9,@object
	.size	.L_2il0floatpacket.9,16
	.align 16
.L_2il0floatpacket.10:
	.long	0x00000000,0x00000000,0x00000001,0x00000000
	.type	.L_2il0floatpacket.10,@object
	.size	.L_2il0floatpacket.10,16
	.align 16
.L_2il0floatpacket.11:
	.long	0x60000000,0x40091eb8,0x60000000,0x40091eb8
	.type	.L_2il0floatpacket.11,@object
	.size	.L_2il0floatpacket.11,16
	.align 16
.L_2il0floatpacket.12:
	.long	0x00000001,0x00000000,0x00000001,0x00000000
	.type	.L_2il0floatpacket.12,@object
	.size	.L_2il0floatpacket.12,16
	.align 8
.L_2il0floatpacket.13:
	.long	0x60000000,0x40091eb8
	.type	.L_2il0floatpacket.13,@object
	.size	.L_2il0floatpacket.13,8
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
