	.text
	.file	"md_iterator_2.cpp"
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3
.LCPI0_0:
	.quad	4614253070451212288     # double 3.1400001049041748
	.text
	.globl	_Z14transform_looplPd
	.p2align	4, 0x90
	.type	_Z14transform_looplPd,@function
_Z14transform_looplPd:                  # @_Z14transform_looplPd
# BB#0:
	testq	%rdi, %rdi
	jle	.LBB0_9
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
                                        #     Child Loop BB0_4 Depth 2
                                        #     Child Loop BB0_7 Depth 2
                                        #     Child Loop BB0_11 Depth 2
	movq	%rdi, %rdx
	movq	%r14, %rbx
	movq	%rsi, %rcx
	movq	%rdi, %rax
	cmpq	$16, %rdi
	jae	.LBB0_3
	.p2align	4, 0x90
.LBB0_4:                                #   Parent Loop BB0_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%r15, (%rcx)
	addq	$8, %rcx
	addq	$-1, %rax
	jne	.LBB0_4
	jmp	.LBB0_5
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
.LBB0_5:                                #   in Loop: Header=BB0_2 Depth=1
	cmpq	$16, %rdi
	jae	.LBB0_6
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
.LBB0_6:                                #   in Loop: Header=BB0_2 Depth=1
	movq	%r9, %rdx
	movq	%rdi, %rcx
	.p2align	4, 0x90
.LBB0_7:                                #   Parent Loop BB0_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovaps	%ymm0, -96(%rdx)
	vmovaps	%ymm0, -64(%rdx)
	vmovaps	%ymm0, -32(%rdx)
	vmovaps	%ymm0, (%rdx)
	subq	$-128, %rdx
	addq	$-16, %rcx
	jne	.LBB0_7
.LBB0_12:                               #   in Loop: Header=BB0_2 Depth=1
	addq	%r8, %r14
	addq	%r8, %rsi
	addq	%r8, %r9
	addq	%r8, %r11
	addq	$-2, %r10
	jne	.LBB0_2
# BB#8:
	popq	%rbx
	popq	%r14
	popq	%r15
.LBB0_9:
	vzeroupper
	retq
.Lfunc_end0:
	.size	_Z14transform_looplPd, .Lfunc_end0-_Z14transform_looplPd


	.ident	"clang version 5.0.0 (git@github.com:GorNishanov/clang.git 7fe33d27853beaa85b039482586ef86039a74b56) (git@github.com:GorNishanov/llvm.git bb958011044a060bda6af65d0e50dfbb52a8a604)"
	.section	".note.GNU-stack","",@progbits
