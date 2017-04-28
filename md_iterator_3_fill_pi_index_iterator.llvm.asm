	.text
	.file	"md_iterator_3.cpp"
	.globl	_Z40fill_pi_index_iterator_sentinel_range_NNlRNSt3__16vectorIdNS_9allocatorIdEEEE
	.p2align	4, 0x90
	.type	_Z40fill_pi_index_iterator_sentinel_range_NNlRNSt3__16vectorIdNS_9allocatorIdEEEE,@function
_Z40fill_pi_index_iterator_sentinel_range_NNlRNSt3__16vectorIdNS_9allocatorIdEEEE: # @_Z40fill_pi_index_iterator_sentinel_range_NNlRNSt3__16vectorIdNS_9allocatorIdEEEE
# BB#0:
	movq	(%rsi), %r9
	xorl	%edx, %edx
	movabsq	$4614253070451212288, %r8 # imm = 0x40091EB860000000
	xorl	%esi, %esi
	.p2align	4, 0x90
.LBB0_1:                                # =>This Inner Loop Header: Depth=1
	movq	%rdx, %rcx
	imulq	%rdi, %rcx
	addq	%rsi, %rcx
	movq	%r8, (%r9,%rcx,8)
	addq	$1, %rsi
	xorl	%ecx, %ecx
	cmpq	%rdi, %rsi
	sete	%cl
	movl	$0, %eax
	cmoveq	%rax, %rsi
	addq	%rcx, %rdx
	cmpq	%rdi, %rdx
	jne	.LBB0_1
# BB#2:
	retq
.Lfunc_end0:
	.size	_Z40fill_pi_index_iterator_sentinel_range_NNlRNSt3__16vectorIdNS_9allocatorIdEEEE, .Lfunc_end0-_Z40fill_pi_index_iterator_sentinel_range_NNlRNSt3__16vectorIdNS_9allocatorIdEEEE

	.globl	_Z40fill_pi_index_iterator_sentinel_range_NMllRNSt3__16vectorIdNS_9allocatorIdEEEE
	.p2align	4, 0x90
	.type	_Z40fill_pi_index_iterator_sentinel_range_NMllRNSt3__16vectorIdNS_9allocatorIdEEEE,@function
_Z40fill_pi_index_iterator_sentinel_range_NMllRNSt3__16vectorIdNS_9allocatorIdEEEE: # @_Z40fill_pi_index_iterator_sentinel_range_NMllRNSt3__16vectorIdNS_9allocatorIdEEEE
# BB#0:
	movq	(%rdx), %r9
	xorl	%eax, %eax
	movabsq	$4614253070451212288, %r8 # imm = 0x40091EB860000000
	xorl	%edx, %edx
	.p2align	4, 0x90
.LBB1_1:                                # =>This Inner Loop Header: Depth=1
	movq	%rax, %rcx
	imulq	%rdi, %rcx
	addq	%rdx, %rcx
	movq	%r8, (%r9,%rcx,8)
	addq	$1, %rdx
	xorl	%r10d, %r10d
	cmpq	%rdi, %rdx
	sete	%r10b
	movl	$0, %ecx
	cmoveq	%rcx, %rdx
	addq	%r10, %rax
	cmpq	%rsi, %rax
	jne	.LBB1_1
# BB#2:
	retq
.Lfunc_end1:
	.size	_Z40fill_pi_index_iterator_sentinel_range_NMllRNSt3__16vectorIdNS_9allocatorIdEEEE, .Lfunc_end1-_Z40fill_pi_index_iterator_sentinel_range_NMllRNSt3__16vectorIdNS_9allocatorIdEEEE


	.ident	"clang version 5.0.0 (git@github.com:GorNishanov/clang.git 7fe33d27853beaa85b039482586ef86039a74b56) (git@github.com:GorNishanov/llvm.git bb958011044a060bda6af65d0e50dfbb52a8a604)"
	.section	".note.GNU-stack","",@progbits
