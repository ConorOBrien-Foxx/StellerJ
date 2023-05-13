	.text
	.file	"temp.ll"
	.globl	putn                            # -- Begin function putn
	.p2align	4, 0x90
	.type	putn,@function
putn:                                   # @putn
	.cfi_startproc
# %bb.0:
	pushq	%rax
	.cfi_def_cfa_offset 16
	movq	%rdi, %rsi
	movl	$.putn_fmt, %edi
	xorl	%eax, %eax
	callq	printf@PLT
	popq	%rax
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end0:
	.size	putn, .Lfunc_end0-putn
	.cfi_endproc
                                        # -- End function
	.globl	putd                            # -- Begin function putd
	.p2align	4, 0x90
	.type	putd,@function
putd:                                   # @putd
	.cfi_startproc
# %bb.0:
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$.putd_fmt, %edi
	movb	$1, %al
	callq	printf@PLT
	popq	%rax
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end1:
	.size	putd, .Lfunc_end1-putd
	.cfi_endproc
                                        # -- End function
	.globl	JFTensor_dump                   # -- Begin function JFTensor_dump
	.p2align	4, 0x90
	.type	JFTensor_dump,@function
JFTensor_dump:                          # @JFTensor_dump
	.cfi_startproc
# %bb.0:
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	%rdi, 16(%rsp)
	cmpq	$0, 16(%rdi)
	je	.LBB2_11
# %bb.1:
	movq	$0, 8(%rsp)
	jmp	.LBB2_2
	.p2align	4, 0x90
.LBB2_10:                               #   in Loop: Header=BB2_2 Depth=1
	incq	8(%rsp)
.LBB2_2:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_4 Depth 2
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	cmpq	24(%rcx), %rax
	jae	.LBB2_11
# %bb.3:                                #   in Loop: Header=BB2_2 Depth=1
	movq	16(%rsp), %rax
	movq	(%rax), %rax
	movq	8(%rsp), %rcx
	movsd	(%rax,%rcx,8), %xmm0            # xmm0 = mem[0],zero
	movl	$.putd_fmt, %edi
	movb	$1, %al
	callq	printf@PLT
	movq	$1, 32(%rsp)
	movl	$1, 4(%rsp)
	movq	16(%rsp), %rax
	movq	16(%rax), %rax
	decq	%rax
	movq	%rax, 24(%rsp)
	jmp	.LBB2_4
	.p2align	4, 0x90
.LBB2_7:                                #   in Loop: Header=BB2_4 Depth=2
	decq	24(%rsp)
.LBB2_4:                                #   Parent Loop BB2_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpq	$0, 24(%rsp)
	je	.LBB2_8
# %bb.5:                                #   in Loop: Header=BB2_4 Depth=2
	movq	16(%rsp), %rax
	movq	8(%rax), %rax
	movq	24(%rsp), %rcx
	movq	32(%rsp), %rsi
	imulq	(%rax,%rcx,8), %rsi
	movq	%rsi, 32(%rsp)
	movq	8(%rsp), %rax
	xorl	%edx, %edx
	divq	%rsi
	decq	%rsi
	cmpq	%rsi, %rdx
	jne	.LBB2_7
# %bb.6:                                #   in Loop: Header=BB2_4 Depth=2
	movl	$0, 4(%rsp)
	movl	$10, %edi
	callq	putchar@PLT
	jmp	.LBB2_7
	.p2align	4, 0x90
.LBB2_8:                                #   in Loop: Header=BB2_2 Depth=1
	cmpl	$0, 4(%rsp)
	je	.LBB2_10
# %bb.9:                                #   in Loop: Header=BB2_2 Depth=1
	movl	$32, %edi
	callq	putchar@PLT
	jmp	.LBB2_10
.LBB2_11:
	addq	$40, %rsp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end2:
	.size	JFTensor_dump, .Lfunc_end2-JFTensor_dump
	.cfi_endproc
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	$420, 32(%rsp)                  # imm = 0x1A4
	movl	$48, %edi
	callq	malloc@PLT
	movq	%rax, (%rsp)
	movl	$4, %edi
	callq	malloc@PLT
	movq	%rax, 8(%rsp)
	movq	$6, (%rax)
	movq	$1, 16(%rsp)
	movq	$6, 24(%rsp)
	movq	(%rsp), %rax
	movabsq	$4614838538166547251, %rcx      # imm = 0x400B333333333333
	movq	%rcx, (%rax)
	movq	(%rsp), %rax
	movabsq	$4615288898129284301, %rcx      # imm = 0x400CCCCCCCCCCCCD
	movq	%rcx, 8(%rax)
	movq	(%rsp), %rax
	movabsq	$4615739258092021350, %rcx      # imm = 0x400E666666666666
	movq	%rcx, 16(%rax)
	movq	(%rsp), %rax
	movabsq	$4621537642612260864, %rcx      # imm = 0x4023000000000000
	movq	%rcx, 24(%rax)
	movq	(%rsp), %rax
	movabsq	$4621650232602945126, %rcx      # imm = 0x4023666666666666
	movq	%rcx, 32(%rax)
	movq	(%rsp), %rax
	movabsq	$4621762822593629389, %rcx      # imm = 0x4023CCCCCCCCCCCD
	movq	%rcx, 40(%rax)
	movq	%rsp, %rdi
	callq	JFTensor_dump
	xorl	%eax, %eax
	addq	$40, %rsp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end3:
	.size	main, .Lfunc_end3-main
	.cfi_endproc
                                        # -- End function
	.type	.putn_fmt,@object               # @.putn_fmt
	.section	.rodata,"a",@progbits
.putn_fmt:
	.asciz	"%lld"
	.size	.putn_fmt, 5

	.type	.putd_fmt,@object               # @.putd_fmt
.putd_fmt:
	.asciz	"%g"
	.size	.putd_fmt, 3

	.section	".note.GNU-stack","",@progbits
