	.file	"md_iterator_3.cpp"
	.text
	.p2align 4,,15
	.globl	_Z15fill_pi_loop_NNlPd
	.type	_Z15fill_pi_loop_NNlPd, @function
_Z15fill_pi_loop_NNlPd:
	testq	%rdi, %rdi
	je	.L27
	pushq	%rbp
	leaq	0(,%rdi,8), %r9
	movq	%rsi, %rdx
	xorl	%ecx, %ecx
	vmovsd	.LC0(%rip), %xmm1
	xorl	%r8d, %r8d
	vmovapd	.LC1(%rip), %ymm2
	movq	%rsp, %rbp
	vmovapd	%xmm1, %xmm0
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%r10
	leaq	-1(%rdi), %r10
	pushq	%rbx
	jmp	.L12
	.p2align 4,,10
	.p2align 3
.L14:
	movq	%rdi, %rax
.L3:
	vmovsd	%xmm0, (%rdx)
	cmpq	$1, %rax
	je	.L16
	vmovsd	%xmm0, 8(%rdx)
	cmpq	$2, %rax
	je	.L17
	vmovsd	%xmm0, 16(%rdx)
	cmpq	$3, %rax
	je	.L18
	vmovsd	%xmm0, 24(%rdx)
	cmpq	$4, %rax
	je	.L19
	vmovsd	%xmm0, 32(%rdx)
	cmpq	$5, %rax
	je	.L20
	vmovsd	%xmm0, 40(%rdx)
	movl	$6, %r11d
.L5:
	cmpq	%rdi, %rax
	je	.L6
.L4:
	movq	%rdi, %r12
	movq	%r10, %r14
	subq	%rax, %r12
	subq	%rax, %r14
	leaq	-4(%r12), %rbx
	shrq	$2, %rbx
	addq	$1, %rbx
	leaq	0(,%rbx,4), %r13
	cmpq	$2, %r14
	jbe	.L7
	addq	%rcx, %rax
	leaq	(%rsi,%rax,8), %r14
	xorl	%eax, %eax
.L9:
	addq	$1, %rax
	vmovapd	%ymm2, (%r14)
	addq	$32, %r14
	cmpq	%rbx, %rax
	jb	.L9
	addq	%r13, %r11
	cmpq	%r13, %r12
	je	.L6
.L7:
	leaq	(%rcx,%r11), %rax
	vmovsd	%xmm1, (%rsi,%rax,8)
	leaq	1(%r11), %rax
	cmpq	%rax, %rdi
	je	.L6
	addq	%rcx, %rax
	vmovsd	%xmm1, (%rsi,%rax,8)
	leaq	2(%r11), %rax
	cmpq	%rax, %rdi
	je	.L6
	addq	%rcx, %rax
	vmovsd	%xmm1, (%rsi,%rax,8)
.L6:
	addq	$1, %r8
	addq	%r9, %rdx
	addq	%rdi, %rcx
	cmpq	%r8, %rdi
	je	.L29
.L12:
	movq	%rdx, %rax
	shrq	$3, %rax
	negq	%rax
	andl	$3, %eax
	cmpq	%rdi, %rax
	cmova	%rdi, %rax
	cmpq	$6, %rdi
	jbe	.L14
	testq	%rax, %rax
	jne	.L3
	xorl	%r11d, %r11d
	jmp	.L4
	.p2align 4,,10
	.p2align 3
.L20:
	movl	$5, %r11d
	jmp	.L5
	.p2align 4,,10
	.p2align 3
.L19:
	movl	$4, %r11d
	jmp	.L5
	.p2align 4,,10
	.p2align 3
.L18:
	movl	$3, %r11d
	jmp	.L5
	.p2align 4,,10
	.p2align 3
.L17:
	movl	$2, %r11d
	jmp	.L5
	.p2align 4,,10
	.p2align 3
.L16:
	movl	$1, %r11d
	jmp	.L5
	.p2align 4,,10
	.p2align 3
.L29:
	vzeroupper
	popq	%rbx
	popq	%r10
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%rbp
.L27:
	ret
	.size	_Z15fill_pi_loop_NNlPd, .-_Z15fill_pi_loop_NNlPd
	.p2align 4,,15
	.globl	_Z15fill_pi_loop_NMllPd
	.type	_Z15fill_pi_loop_NMllPd, @function
_Z15fill_pi_loop_NMllPd:
	testq	%rsi, %rsi
	je	.L60
	testq	%rdi, %rdi
	je	.L60
	pushq	%rbp
	movq	%rdx, %rcx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	vmovsd	.LC0(%rip), %xmm1
	leaq	-1(%rdi), %r11
	vmovapd	.LC1(%rip), %ymm2
	movq	%rsp, %rbp
	vmovapd	%xmm1, %xmm0
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%r10
	leaq	0(,%rdi,8), %r10
	pushq	%rbx
	jmp	.L36
	.p2align 4,,10
	.p2align 3
.L43:
	movq	%rdi, %rax
.L33:
	vmovsd	%xmm0, (%rcx)
	cmpq	$1, %rax
	je	.L45
	vmovsd	%xmm0, 8(%rcx)
	cmpq	$2, %rax
	je	.L46
	vmovsd	%xmm0, 16(%rcx)
	cmpq	$3, %rax
	je	.L47
	vmovsd	%xmm0, 24(%rcx)
	cmpq	$4, %rax
	je	.L48
	vmovsd	%xmm0, 32(%rcx)
	cmpq	$5, %rax
	je	.L49
	vmovsd	%xmm0, 40(%rcx)
	movl	$6, %ebx
.L35:
	cmpq	%rdi, %rax
	je	.L37
.L34:
	movq	%rdi, %r13
	movq	%r11, %r15
	subq	%rax, %r13
	subq	%rax, %r15
	leaq	-4(%r13), %r12
	shrq	$2, %r12
	addq	$1, %r12
	leaq	0(,%r12,4), %r14
	cmpq	$2, %r15
	jbe	.L38
	addq	%r8, %rax
	leaq	(%rdx,%rax,8), %r15
	xorl	%eax, %eax
.L40:
	addq	$1, %rax
	vmovapd	%ymm2, (%r15)
	addq	$32, %r15
	cmpq	%rax, %r12
	ja	.L40
	addq	%r14, %rbx
	cmpq	%r14, %r13
	je	.L37
.L38:
	leaq	(%r8,%rbx), %rax
	vmovsd	%xmm1, (%rdx,%rax,8)
	leaq	1(%rbx), %rax
	cmpq	%rax, %rdi
	je	.L37
	addq	%r8, %rax
	vmovsd	%xmm1, (%rdx,%rax,8)
	leaq	2(%rbx), %rax
	cmpq	%rax, %rdi
	je	.L37
	addq	%r8, %rax
	vmovsd	%xmm1, (%rdx,%rax,8)
.L37:
	addq	$1, %r9
	addq	%r10, %rcx
	addq	%rdi, %r8
	cmpq	%r9, %rsi
	je	.L61
.L36:
	movq	%rcx, %rax
	shrq	$3, %rax
	negq	%rax
	andl	$3, %eax
	cmpq	%rdi, %rax
	cmova	%rdi, %rax
	cmpq	$6, %rdi
	jbe	.L43
	testq	%rax, %rax
	jne	.L33
	xorl	%ebx, %ebx
	jmp	.L34
	.p2align 4,,10
	.p2align 3
.L49:
	movl	$5, %ebx
	jmp	.L35
	.p2align 4,,10
	.p2align 3
.L48:
	movl	$4, %ebx
	jmp	.L35
	.p2align 4,,10
	.p2align 3
.L47:
	movl	$3, %ebx
	jmp	.L35
	.p2align 4,,10
	.p2align 3
.L46:
	movl	$2, %ebx
	jmp	.L35
	.p2align 4,,10
	.p2align 3
.L45:
	movl	$1, %ebx
	jmp	.L35
	.p2align 4,,10
	.p2align 3
.L61:
	vzeroupper
	popq	%rbx
	popq	%r10
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
.L60:
	ret
	.size	_Z15fill_pi_loop_NMllPd, .-_Z15fill_pi_loop_NMllPd
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.type	_GLOBAL__sub_I__Z15fill_pi_loop_NNlPd, @function
_GLOBAL__sub_I__Z15fill_pi_loop_NNlPd:
	subq	$8, %rsp
	movl	$_ZStL8__ioinit, %edi
	call	_ZNSt8ios_base4InitC1Ev
	movl	$__dso_handle, %edx
	movl	$_ZStL8__ioinit, %esi
	movl	$_ZNSt8ios_base4InitD1Ev, %edi
	addq	$8, %rsp
	jmp	__cxa_atexit
	.size	_GLOBAL__sub_I__Z15fill_pi_loop_NNlPd, .-_GLOBAL__sub_I__Z15fill_pi_loop_NNlPd
	.section	.init_array,"aw"
	.align 8
	.quad	_GLOBAL__sub_I__Z15fill_pi_loop_NNlPd
	.local	_ZStL8__ioinit
	.comm	_ZStL8__ioinit,1,1
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	1610612736
	.long	1074339512
	.section	.rodata.cst32,"aM",@progbits,32
	.align 32
.LC1:
	.long	1610612736
	.long	1074339512
	.long	1610612736
	.long	1074339512
	.long	1610612736
	.long	1074339512
	.long	1610612736
	.long	1074339512
	.hidden	__dso_handle
	.ident	"GCC: (GNU) 6.3.0 20161221 (Cray Inc.)"
	.section	.note.GNU-stack,"",@progbits
