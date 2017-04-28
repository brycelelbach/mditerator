	.text
	.file	"fib_generator.cpp"
	.globl	_Z3fibi
	.p2align	4, 0x90
	.type	_Z3fibi,@function
_Z3fibi:                                # @_Z3fibi
# BB#0:
	pushq	%rbp
	pushq	%rbx
	pushq	%rax
	movl	%esi, %ebp
	movq	%rdi, %rbx
	movl	$32, %edi
	callq	_Znwm
	movq	$_Z3fibi.resume, (%rax)
	movq	$_Z3fibi.destroy, 8(%rax)
	movl	%ebp, 24(%rax)
	movb	$0, 20(%rax)
	movq	%rax, (%rbx)
	movq	%rbx, %rax
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	retq
.Lfunc_end0:
	.size	_Z3fibi, .Lfunc_end0-_Z3fibi

	.globl	main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# BB#0:
	pushq	%rax
	xorl	%edi, %edi
	callq	_Z5printi
	movl	$1, %edi
	callq	_Z5printi
	movl	$2, %edi
	callq	_Z5printi
	movl	$3, %edi
	callq	_Z5printi
	movl	$4, %edi
	callq	_Z5printi
	xorl	%eax, %eax
	popq	%rcx
	retq
.Lfunc_end1:
	.size	main, .Lfunc_end1-main

	.p2align	4, 0x90
	.type	_Z3fibi.resume,@function
_Z3fibi.resume:                         # @_Z3fibi.resume
# BB#0:
	movb	20(%rdi), %al
	testb	%al, %al
	je	.LBB2_1
# BB#4:
	movl	28(%rdi), %eax
	incl	%eax
	cmpl	24(%rdi), %eax
	jl	.LBB2_3
	jmp	.LBB2_5
.LBB2_1:
	cmpl	$0, 24(%rdi)
	jle	.LBB2_5
# BB#2:
	xorl	%eax, %eax
.LBB2_3:
	movl	%eax, 28(%rdi)
	movl	%eax, 16(%rdi)
	movb	$1, 20(%rdi)
	retq
.LBB2_5:
	movq	$0, (%rdi)
	retq
.Lfunc_end2:
	.size	_Z3fibi.resume, .Lfunc_end2-_Z3fibi.resume

	.p2align	4, 0x90
	.type	_Z3fibi.destroy,@function
_Z3fibi.destroy:                        # @_Z3fibi.destroy
# BB#0:
	jmp	_ZdlPv                  # TAILCALL
.Lfunc_end3:
	.size	_Z3fibi.destroy, .Lfunc_end3-_Z3fibi.destroy

	.p2align	4, 0x90
	.type	_Z3fibi.cleanup,@function
_Z3fibi.cleanup:                        # @_Z3fibi.cleanup
# BB#0:
	retq
.Lfunc_end4:
	.size	_Z3fibi.cleanup, .Lfunc_end4-_Z3fibi.cleanup

	.type	.L_Z3fibi.resumers,@object # @_Z3fibi.resumers
	.section	.rodata,"a",@progbits
	.p2align	4
.L_Z3fibi.resumers:
	.quad	_Z3fibi.resume
	.quad	_Z3fibi.destroy
	.quad	_Z3fibi.cleanup
	.size	.L_Z3fibi.resumers, 24


	.ident	"clang version 5.0.0 (git@github.com:GorNishanov/clang.git 7fe33d27853beaa85b039482586ef86039a74b56) (git@github.com:GorNishanov/llvm.git bb958011044a060bda6af65d0e50dfbb52a8a604)"
	.section	".note.GNU-stack","",@progbits
