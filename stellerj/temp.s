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
	callq	printf
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
	callq	printf
	popq	%rax
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end1:
	.size	putd, .Lfunc_end1-putd
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3                               # -- Begin function main
.LCPI2_0:
	.quad	0x405e43d70a3d70a5              # double 121.06000000000002
	.text
	.globl	main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movabsq	$4622044297570340045, %rax      # imm = 0x4024CCCCCCCCCCCD
	movq	%rax, 16(%rsp)
	movabsq	$4623451672453893325, %rax      # imm = 0x4029CCCCCCCCCCCD
	movq	%rax, 8(%rsp)
	movabsq	$4638219257107017893, %rax      # imm = 0x405E43D70A3D70A5
	movq	%rax, (%rsp)
	movsd	.LCPI2_0(%rip), %xmm0           # xmm0 = mem[0],zero
	callq	putd
	xorl	%eax, %eax
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
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
