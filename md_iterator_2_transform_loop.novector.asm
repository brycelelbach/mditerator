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
	movq	%rdi, -8(%rsp)
	movq	%rsi, -16(%rsp)
	movq	-16(%rsp), %rsi
	movq	%rsi, -16(%rsp)
	movq	$0, -24(%rsp)
.LBB0_1:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_3 Depth 2
	movq	-24(%rsp), %rax
	cmpq	-8(%rsp), %rax
	jge	.LBB0_8
# BB#2:                                 #   in Loop: Header=BB0_1 Depth=1
	movq	$0, -32(%rsp)
.LBB0_3:                                #   Parent Loop BB0_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-32(%rsp), %rax
	cmpq	-8(%rsp), %rax
	jge	.LBB0_6
# BB#4:                                 #   in Loop: Header=BB0_3 Depth=2
	movsd	.LCPI0_0(%rip), %xmm0   # xmm0 = mem[0],zero
	movq	-16(%rsp), %rax
	movq	-32(%rsp), %rcx
	movq	-24(%rsp), %rdx
	imulq	-8(%rsp), %rdx
	addq	%rdx, %rcx
	movsd	%xmm0, (%rax,%rcx,8)
# BB#5:                                 #   in Loop: Header=BB0_3 Depth=2
	movq	-32(%rsp), %rax
	addq	$1, %rax
	movq	%rax, -32(%rsp)
	jmp	.LBB0_3
.LBB0_6:                                #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_7
.LBB0_7:                                #   in Loop: Header=BB0_1 Depth=1
	movq	-24(%rsp), %rax
	addq	$1, %rax
	movq	%rax, -24(%rsp)
	jmp	.LBB0_1
.LBB0_8:
	retq
.Lfunc_end0:
	.size	_Z14transform_looplPd, .Lfunc_end0-_Z14transform_looplPd


	.ident	"clang version 5.0.0 (git@github.com:GorNishanov/clang.git 7fe33d27853beaa85b039482586ef86039a74b56) (git@github.com:GorNishanov/llvm.git bb958011044a060bda6af65d0e50dfbb52a8a604)"
	.section	".note.GNU-stack","",@progbits
