	.text
	.file	"md_iterator_3.cpp"
	.globl	_Z12stream_triadlRNSt3__16vectorIdNS_9allocatorIdEEEERKS3_dS6_
	.p2align	4, 0x90
	.type	_Z12stream_triadlRNSt3__16vectorIdNS_9allocatorIdEEEERKS3_dS6_,@function
_Z12stream_triadlRNSt3__16vectorIdNS_9allocatorIdEEEERKS3_dS6_: # @_Z12stream_triadlRNSt3__16vectorIdNS_9allocatorIdEEEERKS3_dS6_
# BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	(%rsi), %rax
	movq	(%rdx), %rsi
	movq	(%rcx), %rcx
	vbroadcastsd	%xmm0, %ymm1
	leaq	96(%rax), %r14
	leaq	(,%rdi,8), %rdx
	leaq	96(%rcx), %r15
	leaq	96(%rsi), %r12
	movq	%rax, -8(%rsp)          # 8-byte Spill
	leaq	24(%rax), %r10
	movq	%rcx, -24(%rsp)         # 8-byte Spill
	leaq	24(%rcx), %r11
	movq	%rsi, -16(%rsp)         # 8-byte Spill
	leaq	24(%rsi), %rcx
	xorl	%r13d, %r13d
	.p2align	4, 0x90
.LBB0_1:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_5 Depth 2
                                        #     Child Loop BB0_6 Depth 2
	movq	%rcx, %rsi
	movq	%r11, %rbx
	movq	%r10, %rbp
	movq	%rdi, %rax
	cmpq	$15, %rdi
	ja	.LBB0_2
	.p2align	4, 0x90
.LBB0_6:                                #   Parent Loop BB0_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovsd	-24(%rbx), %xmm2        # xmm2 = mem[0],zero
	vfmadd213sd	-24(%rsi), %xmm0, %xmm2
	vmovsd	%xmm2, -24(%rbp)
	vmovsd	-16(%rbx), %xmm2        # xmm2 = mem[0],zero
	vfmadd213sd	-16(%rsi), %xmm0, %xmm2
	vmovsd	%xmm2, -16(%rbp)
	vmovsd	-8(%rbx), %xmm2         # xmm2 = mem[0],zero
	vfmadd213sd	-8(%rsi), %xmm0, %xmm2
	vmovsd	%xmm2, -8(%rbp)
	vmovsd	(%rbx), %xmm2           # xmm2 = mem[0],zero
	vfmadd213sd	(%rsi), %xmm0, %xmm2
	vmovsd	%xmm2, (%rbp)
	addq	$32, %rbp
	addq	$32, %rbx
	addq	$32, %rsi
	addq	$-4, %rax
	jne	.LBB0_6
	jmp	.LBB0_7
	.p2align	4, 0x90
.LBB0_2:                                #   in Loop: Header=BB0_1 Depth=1
	movq	%r13, %rsi
	imulq	%rdi, %rsi
	leaq	(%rsi,%rdi), %rax
	movq	-8(%rsp), %rbx          # 8-byte Reload
	leaq	(%rbx,%rsi,8), %rbp
	leaq	(%rbx,%rax,8), %rbx
	movq	%rdx, %r8
	movq	-24(%rsp), %rdx         # 8-byte Reload
	leaq	(%rdx,%rax,8), %r9
	leaq	(%rdx,%rsi,8), %rdx
	movq	%rdx, -32(%rsp)         # 8-byte Spill
	movq	-16(%rsp), %rdx         # 8-byte Reload
	leaq	(%rdx,%rax,8), %rax
	leaq	(%rdx,%rsi,8), %rsi
	movq	%r8, %rdx
	cmpq	%rax, %rbp
	sbbb	%al, %al
	cmpq	%rbx, %rsi
	sbbb	%r8b, %r8b
	andb	%al, %r8b
	cmpq	%r9, %rbp
	sbbb	%r9b, %r9b
	cmpq	%rbx, -32(%rsp)         # 8-byte Folded Reload
	sbbb	%al, %al
	movb	%al, -32(%rsp)          # 1-byte Spill
	movq	%rcx, %rsi
	movq	%r11, %rbx
	movq	%r10, %rbp
	movq	%rdi, %rax
	testb	$1, %r8b
	jne	.LBB0_6
# BB#3:                                 #   in Loop: Header=BB0_1 Depth=1
	andb	-32(%rsp), %r9b         # 1-byte Folded Reload
	movq	%rcx, %rsi
	movq	%r11, %rbx
	movq	%r10, %rbp
	movq	%rdi, %rax
	andb	$1, %r9b
	jne	.LBB0_6
# BB#4:                                 #   in Loop: Header=BB0_1 Depth=1
	movq	%rdi, %rsi
	movq	%r12, %rax
	movq	%r15, %rbx
	movq	%r14, %rbp
	.p2align	4, 0x90
.LBB0_5:                                #   Parent Loop BB0_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovapd	-96(%rbx), %ymm2
	vmovapd	-64(%rbx), %ymm3
	vmovapd	-32(%rbx), %ymm4
	vmovapd	(%rbx), %ymm5
	vfmadd213pd	-96(%rax), %ymm1, %ymm2
	vfmadd213pd	-64(%rax), %ymm1, %ymm3
	vfmadd213pd	-32(%rax), %ymm1, %ymm4
	vfmadd213pd	(%rax), %ymm1, %ymm5
	vmovapd	%ymm2, -96(%rbp)
	vmovapd	%ymm3, -64(%rbp)
	vmovapd	%ymm4, -32(%rbp)
	vmovapd	%ymm5, (%rbp)
	subq	$-128, %rbp
	subq	$-128, %rbx
	subq	$-128, %rax
	addq	$-16, %rsi
	jne	.LBB0_5
.LBB0_7:                                #   in Loop: Header=BB0_1 Depth=1
	addq	$1, %r13
	addq	%rdx, %r14
	addq	%rdx, %r15
	addq	%rdx, %r12
	addq	%rdx, %r10
	addq	%rdx, %r11
	addq	%rdx, %rcx
	cmpq	%rdi, %r13
	jne	.LBB0_1
# BB#8:
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	vzeroupper
	retq
.Lfunc_end0:
	.size	_Z12stream_triadlRNSt3__16vectorIdNS_9allocatorIdEEEERKS3_dS6_, .Lfunc_end0-_Z12stream_triadlRNSt3__16vectorIdNS_9allocatorIdEEEERKS3_dS6_


	.ident	"clang version 5.0.0 (git@github.com:GorNishanov/clang.git 7fe33d27853beaa85b039482586ef86039a74b56) (git@github.com:GorNishanov/llvm.git bb958011044a060bda6af65d0e50dfbb52a8a604)"
	.section	".note.GNU-stack","",@progbits
