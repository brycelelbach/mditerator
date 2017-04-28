	.file	"md_iterator_3.cpp"
	.text
	.p2align 4,,15
	.globl	_Z40fill_pi_index_iterator_sentinel_range_NNlRSt6vectorIdSaIdEE
	.type	_Z40fill_pi_index_iterator_sentinel_range_NNlRSt6vectorIdSaIdEE, @function
_Z40fill_pi_index_iterator_sentinel_range_NNlRSt6vectorIdSaIdEE:
	vmovsd	.LC0(%rip), %xmm0
	movq	(%rsi), %rsi
	xorl	%ecx, %ecx
	xorl	%eax, %eax
	vmovsd	%xmm0, (%rsi)
	jmp	.L2
	.p2align 4,,10
	.p2align 3
.L4:
	cmpq	%rcx, %rdi
	je	.L6
.L8:
	movq	%rdi, %rdx
	imulq	%rcx, %rdx
	addq	%rax, %rdx
	vmovsd	%xmm0, (%rsi,%rdx,8)
.L2:
	addq	$1, %rax
	cmpq	%rax, %rdi
	jne	.L4
	addq	$1, %rcx
	xorl	%eax, %eax
	cmpq	%rcx, %rdi
	jne	.L8
.L6:
	ret
	.size	_Z40fill_pi_index_iterator_sentinel_range_NNlRSt6vectorIdSaIdEE, .-_Z40fill_pi_index_iterator_sentinel_range_NNlRSt6vectorIdSaIdEE
	.p2align 4,,15
	.globl	_Z40fill_pi_index_iterator_sentinel_range_NMllRSt6vectorIdSaIdEE
	.type	_Z40fill_pi_index_iterator_sentinel_range_NMllRSt6vectorIdSaIdEE, @function
_Z40fill_pi_index_iterator_sentinel_range_NMllRSt6vectorIdSaIdEE:
	vmovsd	.LC0(%rip), %xmm0
	movq	(%rdx), %r8
	xorl	%ecx, %ecx
	xorl	%eax, %eax
	vmovsd	%xmm0, (%r8)
	jmp	.L10
	.p2align 4,,10
	.p2align 3
.L12:
	cmpq	%rcx, %rsi
	je	.L14
.L15:
	movq	%rdi, %rdx
	imulq	%rcx, %rdx
	addq	%rax, %rdx
	vmovsd	%xmm0, (%r8,%rdx,8)
.L10:
	addq	$1, %rax
	cmpq	%rax, %rdi
	jne	.L12
	addq	$1, %rcx
	xorl	%eax, %eax
	cmpq	%rcx, %rsi
	jne	.L15
.L14:
	ret
	.size	_Z40fill_pi_index_iterator_sentinel_range_NMllRSt6vectorIdSaIdEE, .-_Z40fill_pi_index_iterator_sentinel_range_NMllRSt6vectorIdSaIdEE
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.type	_GLOBAL__sub_I__Z40fill_pi_index_iterator_sentinel_range_NNlRSt6vectorIdSaIdEE, @function
_GLOBAL__sub_I__Z40fill_pi_index_iterator_sentinel_range_NNlRSt6vectorIdSaIdEE:
	subq	$8, %rsp
	movl	$_ZStL8__ioinit, %edi
	call	_ZNSt8ios_base4InitC1Ev
	movl	$__dso_handle, %edx
	movl	$_ZStL8__ioinit, %esi
	movl	$_ZNSt8ios_base4InitD1Ev, %edi
	addq	$8, %rsp
	jmp	__cxa_atexit
	.size	_GLOBAL__sub_I__Z40fill_pi_index_iterator_sentinel_range_NNlRSt6vectorIdSaIdEE, .-_GLOBAL__sub_I__Z40fill_pi_index_iterator_sentinel_range_NNlRSt6vectorIdSaIdEE
	.section	.init_array,"aw"
	.align 8
	.quad	_GLOBAL__sub_I__Z40fill_pi_index_iterator_sentinel_range_NNlRSt6vectorIdSaIdEE
	.local	_ZStL8__ioinit
	.comm	_ZStL8__ioinit,1,1
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	1610612736
	.long	1074339512
	.hidden	__dso_handle
	.ident	"GCC: (GNU) 6.3.0 20161221 (Cray Inc.)"
	.section	.note.GNU-stack,"",@progbits
