	.text
	.file	"md_iterator_3.cpp"
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3
.LCPI0_0:
	.quad	4614253070451212288     # double 3.1400001049041748
	.text
	.globl	_Z15fill_pi_loop_NNlPd
	.p2align	4, 0x90
	.type	_Z15fill_pi_loop_NNlPd,@function
_Z15fill_pi_loop_NNlPd:                 # @_Z15fill_pi_loop_NNlPd
# BB#0:
	testq	%rdi, %rdi
	je	.LBB0_8
# BB#1:
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	movq	%rdi, %r8
	shlq	$4, %r8
	leaq	96(%rsi,%rdi,8), %r9
	leaq	(%rsi,%rdi,8), %r11
	movabsq	$4614253070451212288, %r15 # imm = 0x40091EB860000000
	vbroadcastsd	.LCPI0_0(%rip), %ymm0
	leaq	96(%rsi), %r14
	movq	%rdi, %r10
	.p2align	4, 0x90
.LBB0_2:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_3 Depth 2
                                        #     Child Loop BB0_9 Depth 2
                                        #     Child Loop BB0_6 Depth 2
                                        #     Child Loop BB0_11 Depth 2
	movq	%rdi, %rdx
	movq	%r14, %rbx
	movq	%rsi, %rcx
	movq	%rdi, %rax
	cmpq	$16, %rdi
	jae	.LBB0_3
	.p2align	4, 0x90
.LBB0_9:                                #   Parent Loop BB0_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%r15, (%rcx)
	addq	$8, %rcx
	addq	$-1, %rax
	jne	.LBB0_9
	jmp	.LBB0_4
	.p2align	4, 0x90
.LBB0_3:                                #   Parent Loop BB0_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovaps	%ymm0, -96(%rbx)
	vmovaps	%ymm0, -64(%rbx)
	vmovaps	%ymm0, -32(%rbx)
	vmovaps	%ymm0, (%rbx)
	subq	$-128, %rbx
	addq	$-16, %rdx
	jne	.LBB0_3
.LBB0_4:                                #   in Loop: Header=BB0_2 Depth=1
	cmpq	$16, %rdi
	jae	.LBB0_5
# BB#10:                                #   in Loop: Header=BB0_2 Depth=1
	movq	%r11, %rax
	movq	%rdi, %rcx
	.p2align	4, 0x90
.LBB0_11:                               #   Parent Loop BB0_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%r15, (%rax)
	addq	$8, %rax
	addq	$-1, %rcx
	jne	.LBB0_11
	jmp	.LBB0_12
	.p2align	4, 0x90
.LBB0_5:                                #   in Loop: Header=BB0_2 Depth=1
	movq	%r9, %rdx
	movq	%rdi, %rcx
	.p2align	4, 0x90
.LBB0_6:                                #   Parent Loop BB0_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovaps	%ymm0, -96(%rdx)
	vmovaps	%ymm0, -64(%rdx)
	vmovaps	%ymm0, -32(%rdx)
	vmovaps	%ymm0, (%rdx)
	subq	$-128, %rdx
	addq	$-16, %rcx
	jne	.LBB0_6
.LBB0_12:                               #   in Loop: Header=BB0_2 Depth=1
	addq	%r8, %r14
	addq	%r8, %rsi
	addq	%r8, %r9
	addq	%r8, %r11
	addq	$-2, %r10
	jne	.LBB0_2
# BB#7:
	popq	%rbx
	popq	%r14
	popq	%r15
.LBB0_8:
	vzeroupper
	retq
.Lfunc_end0:
	.size	_Z15fill_pi_loop_NNlPd, .Lfunc_end0-_Z15fill_pi_loop_NNlPd

	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3
.LCPI1_0:
	.quad	4614253070451212288     # double 3.1400001049041748
	.text
	.globl	_Z15fill_pi_loop_NMllPd
	.p2align	4, 0x90
	.type	_Z15fill_pi_loop_NMllPd,@function
_Z15fill_pi_loop_NMllPd:                # @_Z15fill_pi_loop_NMllPd
# BB#0:
	testq	%rsi, %rsi
	je	.LBB1_9
# BB#1:
	testq	%rdi, %rdi
	je	.LBB1_9
# BB#2:
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	movq	%rdi, %r8
	shlq	$4, %r8
	leaq	96(%rdx,%rdi,8), %r9
	leaq	(%rdx,%rdi,8), %r10
	movabsq	$4614253070451212288, %r14 # imm = 0x40091EB860000000
	vbroadcastsd	.LCPI1_0(%rip), %ymm0
	leaq	96(%rdx), %r11
	.p2align	4, 0x90
.LBB1_3:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_4 Depth 2
                                        #     Child Loop BB1_10 Depth 2
                                        #     Child Loop BB1_7 Depth 2
                                        #     Child Loop BB1_12 Depth 2
	movq	%rdi, %r15
	movq	%r11, %rbx
	movq	%rdx, %rcx
	movq	%rdi, %rax
	cmpq	$16, %rdi
	jae	.LBB1_4
	.p2align	4, 0x90
.LBB1_10:                               #   Parent Loop BB1_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%r14, (%rcx)
	addq	$8, %rcx
	addq	$-1, %rax
	jne	.LBB1_10
	jmp	.LBB1_5
	.p2align	4, 0x90
.LBB1_4:                                #   Parent Loop BB1_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovaps	%ymm0, -96(%rbx)
	vmovaps	%ymm0, -64(%rbx)
	vmovaps	%ymm0, -32(%rbx)
	vmovaps	%ymm0, (%rbx)
	subq	$-128, %rbx
	addq	$-16, %r15
	jne	.LBB1_4
.LBB1_5:                                #   in Loop: Header=BB1_3 Depth=1
	cmpq	$16, %rdi
	jae	.LBB1_6
# BB#11:                                #   in Loop: Header=BB1_3 Depth=1
	movq	%r10, %rax
	movq	%rdi, %rcx
	.p2align	4, 0x90
.LBB1_12:                               #   Parent Loop BB1_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%r14, (%rax)
	addq	$8, %rax
	addq	$-1, %rcx
	jne	.LBB1_12
	jmp	.LBB1_13
	.p2align	4, 0x90
.LBB1_6:                                #   in Loop: Header=BB1_3 Depth=1
	movq	%r9, %rax
	movq	%rdi, %rcx
	.p2align	4, 0x90
.LBB1_7:                                #   Parent Loop BB1_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovaps	%ymm0, -96(%rax)
	vmovaps	%ymm0, -64(%rax)
	vmovaps	%ymm0, -32(%rax)
	vmovaps	%ymm0, (%rax)
	subq	$-128, %rax
	addq	$-16, %rcx
	jne	.LBB1_7
.LBB1_13:                               #   in Loop: Header=BB1_3 Depth=1
	addq	%r8, %r11
	addq	%r8, %rdx
	addq	%r8, %r9
	addq	%r8, %r10
	addq	$-2, %rsi
	jne	.LBB1_3
# BB#8:
	popq	%rbx
	popq	%r14
	popq	%r15
.LBB1_9:
	vzeroupper
	retq
.Lfunc_end1:
	.size	_Z15fill_pi_loop_NMllPd, .Lfunc_end1-_Z15fill_pi_loop_NMllPd


	.ident	"clang version 5.0.0 (git@github.com:GorNishanov/clang.git 7fe33d27853beaa85b039482586ef86039a74b56) (git@github.com:GorNishanov/llvm.git bb958011044a060bda6af65d0e50dfbb52a8a604)"
	.section	".note.GNU-stack","",@progbits
