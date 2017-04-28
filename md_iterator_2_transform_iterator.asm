	.text
	.file	"md_iterator_2.cpp"
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3
.LCPI0_0:
	.quad	4614253070451212288     # double 3.1400001049041748
	.text
	.globl	_Z18transform_iteratorlRNSt3__16vectorIdNS_9allocatorIdEEEE
	.p2align	4, 0x90
	.type	_Z18transform_iteratorlRNSt3__16vectorIdNS_9allocatorIdEEEE,@function
_Z18transform_iteratorlRNSt3__16vectorIdNS_9allocatorIdEEEE: # @_Z18transform_iteratorlRNSt3__16vectorIdNS_9allocatorIdEEEE
# BB#0:
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	movq	(%rsi), %r14
	movq	%rdi, %r8
	shlq	$4, %r8
	leaq	96(%r14,%rdi,8), %r9
	leaq	(%r14,%rdi,8), %r11
	movabsq	$4614253070451212288, %rcx # imm = 0x40091EB860000000
	vbroadcastsd	.LCPI0_0(%rip), %ymm0
	leaq	96(%r14), %r15
	movq	%rdi, %r10
	.p2align	4, 0x90
.LBB0_1:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_2 Depth 2
                                        #     Child Loop BB0_3 Depth 2
                                        #     Child Loop BB0_6 Depth 2
                                        #     Child Loop BB0_8 Depth 2
	movq	%rdi, %rsi
	movq	%r15, %rbx
	movq	%rdi, %rax
	movq	%r14, %rdx
	cmpq	$16, %rdi
	jae	.LBB0_2
	.p2align	4, 0x90
.LBB0_3:                                #   Parent Loop BB0_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%rcx, (%rdx)
	addq	$8, %rdx
	addq	$-1, %rax
	jne	.LBB0_3
	jmp	.LBB0_4
	.p2align	4, 0x90
.LBB0_2:                                #   Parent Loop BB0_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovups	%ymm0, -96(%rbx)
	vmovups	%ymm0, -64(%rbx)
	vmovups	%ymm0, -32(%rbx)
	vmovups	%ymm0, (%rbx)
	subq	$-128, %rbx
	addq	$-16, %rsi
	jne	.LBB0_2
.LBB0_4:                                #   in Loop: Header=BB0_1 Depth=1
	cmpq	$16, %rdi
	jae	.LBB0_5
# BB#7:                                 #   in Loop: Header=BB0_1 Depth=1
	movq	%r11, %rax
	movq	%rdi, %rdx
	.p2align	4, 0x90
.LBB0_8:                                #   Parent Loop BB0_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%rcx, (%rax)
	addq	$8, %rax
	addq	$-1, %rdx
	jne	.LBB0_8
	jmp	.LBB0_9
	.p2align	4, 0x90
.LBB0_5:                                #   in Loop: Header=BB0_1 Depth=1
	movq	%r9, %rsi
	movq	%rdi, %rax
	.p2align	4, 0x90
.LBB0_6:                                #   Parent Loop BB0_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovups	%ymm0, -96(%rsi)
	vmovups	%ymm0, -64(%rsi)
	vmovups	%ymm0, -32(%rsi)
	vmovups	%ymm0, (%rsi)
	subq	$-128, %rsi
	addq	$-16, %rax
	jne	.LBB0_6
.LBB0_9:                                #   in Loop: Header=BB0_1 Depth=1
	addq	%r8, %r15
	addq	%r8, %r14
	addq	%r8, %r9
	addq	%r8, %r11
	addq	$-2, %r10
	jne	.LBB0_1
# BB#10:
	popq	%rbx
	popq	%r14
	popq	%r15
	vzeroupper
	retq
.Lfunc_end0:
	.size	_Z18transform_iteratorlRNSt3__16vectorIdNS_9allocatorIdEEEE, .Lfunc_end0-_Z18transform_iteratorlRNSt3__16vectorIdNS_9allocatorIdEEEE


	.ident	"clang version 5.0.0 (git@github.com:GorNishanov/clang.git 7fe33d27853beaa85b039482586ef86039a74b56) (git@github.com:GorNishanov/llvm.git bb958011044a060bda6af65d0e50dfbb52a8a604)"
	.section	".note.GNU-stack","",@progbits
