	.text
	.file	"temp.ll"
	.globl	putn                            # -- Begin function putn
	.p2align	4, 0x90
	.type	putn,@function
putn:                                   # @putn
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, %rsi
	movabsq	$.putn_fmt, %rdi
	movb	$0, %al
	callq	printf@PLT
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	putn, .Lfunc_end0-putn
	.cfi_endproc
                                        # -- End function
	.globl	I64_add                         # -- Begin function I64_add
	.p2align	4, 0x90
	.type	I64_add,@function
I64_add:                                # @I64_add
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -8(%rbp)
	movq	-16(%rbp), %rax
	addq	-8(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end1:
	.size	I64_add, .Lfunc_end1-I64_add
	.cfi_endproc
                                        # -- End function
	.globl	I64_sub                         # -- Begin function I64_sub
	.p2align	4, 0x90
	.type	I64_sub,@function
I64_sub:                                # @I64_sub
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -8(%rbp)
	movq	-16(%rbp), %rax
	subq	-8(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end2:
	.size	I64_sub, .Lfunc_end2-I64_sub
	.cfi_endproc
                                        # -- End function
	.globl	I64_mul                         # -- Begin function I64_mul
	.p2align	4, 0x90
	.type	I64_mul,@function
I64_mul:                                # @I64_mul
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -8(%rbp)
	movq	-16(%rbp), %rax
	imulq	-8(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end3:
	.size	I64_mul, .Lfunc_end3-I64_mul
	.cfi_endproc
                                        # -- End function
	.globl	I64_div                         # -- Begin function I64_div
	.p2align	4, 0x90
	.type	I64_div,@function
I64_div:                                # @I64_div
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -8(%rbp)
	movq	-16(%rbp), %rax
	cqto
	idivq	-8(%rbp)
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end4:
	.size	I64_div, .Lfunc_end4-I64_div
	.cfi_endproc
                                        # -- End function
	.globl	JITensor_inner_product          # -- Begin function JITensor_inner_product
	.p2align	4, 0x90
	.type	JITensor_inner_product,@function
JITensor_inner_product:                 # @JITensor_inner_product
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$128, %rsp
	movq	%rdi, -64(%rbp)
	movq	%rsi, -56(%rbp)
	movq	%rdx, -120(%rbp)
	movq	%rcx, -112(%rbp)
	movq	%r8, -8(%rbp)
	movq	-64(%rbp), %rax
	cmpq	$2, 16(%rax)
	jne	.LBB5_2
# %bb.1:
	movq	-56(%rbp), %rax
	cmpq	$2, 16(%rax)
	je	.LBB5_3
.LBB5_2:
	jmp	.LBB5_20
.LBB5_3:
	movq	-64(%rbp), %rax
	movq	8(%rax), %rax
	movq	(%rax), %rax
	movq	%rax, -40(%rbp)
	movq	-64(%rbp), %rax
	movq	8(%rax), %rax
	movq	8(%rax), %rax
	movq	%rax, -72(%rbp)
	movq	-72(%rbp), %rax
	movq	-56(%rbp), %rcx
	movq	8(%rcx), %rcx
	cmpq	(%rcx), %rax
	je	.LBB5_5
# %bb.4:
	jmp	.LBB5_20
.LBB5_5:
	movq	-56(%rbp), %rax
	movq	8(%rax), %rax
	movq	8(%rax), %rax
	movq	%rax, -48(%rbp)
	movq	-8(%rbp), %rax
	cmpq	$0, (%rax)
	jne	.LBB5_7
# %bb.6:
	movq	-8(%rbp), %rax
	movq	$2, 16(%rax)
	movq	-8(%rbp), %rax
	movq	16(%rax), %rdi
	shlq	$3, %rdi
	callq	malloc@PLT
	movq	-8(%rbp), %rcx
	movq	%rax, 8(%rcx)
	movq	-40(%rbp), %rax
	movq	-8(%rbp), %rcx
	movq	8(%rcx), %rcx
	movq	%rax, (%rcx)
	movq	-48(%rbp), %rax
	movq	-8(%rbp), %rcx
	movq	8(%rcx), %rcx
	movq	%rax, 8(%rcx)
	movq	-40(%rbp), %rax
	imulq	-48(%rbp), %rax
	movq	-8(%rbp), %rcx
	movq	%rax, 24(%rcx)
	movq	-8(%rbp), %rax
	movq	24(%rax), %rdi
	shlq	$3, %rdi
	callq	malloc@PLT
	movq	-8(%rbp), %rcx
	movq	%rax, (%rcx)
.LBB5_7:
	movq	$1, -88(%rbp)
	movq	-88(%rbp), %rdi
	shlq	$3, %rdi
	callq	malloc@PLT
	movq	%rax, -96(%rbp)
	movq	-72(%rbp), %rax
	movq	%rax, -80(%rbp)
	movq	-80(%rbp), %rdi
	shlq	$3, %rdi
	callq	malloc@PLT
	movq	%rax, -104(%rbp)
	movq	$0, -32(%rbp)
.LBB5_8:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB5_10 Depth 2
                                        #       Child Loop BB5_12 Depth 3
	movq	-32(%rbp), %rax
	cmpq	-40(%rbp), %rax
	jae	.LBB5_19
# %bb.9:                                #   in Loop: Header=BB5_8 Depth=1
	movq	$0, -24(%rbp)
.LBB5_10:                               #   Parent Loop BB5_8 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB5_12 Depth 3
	movq	-24(%rbp), %rax
	cmpq	-48(%rbp), %rax
	jae	.LBB5_17
# %bb.11:                               #   in Loop: Header=BB5_10 Depth=2
	movq	$0, -16(%rbp)
.LBB5_12:                               #   Parent Loop BB5_8 Depth=1
                                        #     Parent Loop BB5_10 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movq	-16(%rbp), %rax
	cmpq	-72(%rbp), %rax
	jae	.LBB5_15
# %bb.13:                               #   in Loop: Header=BB5_12 Depth=3
	movq	-112(%rbp), %rax
	movq	-64(%rbp), %rcx
	movq	(%rcx), %rcx
	movq	-32(%rbp), %rdx
	imulq	-40(%rbp), %rdx
	addq	-16(%rbp), %rdx
	movq	(%rcx,%rdx,8), %rdi
	movq	-56(%rbp), %rcx
	movq	(%rcx), %rcx
	movq	-16(%rbp), %rdx
	imulq	-48(%rbp), %rdx
	addq	-24(%rbp), %rdx
	movq	(%rcx,%rdx,8), %rsi
	callq	*%rax
	movq	-104(%rbp), %rcx
	movq	-16(%rbp), %rdx
	movq	%rax, (%rcx,%rdx,8)
# %bb.14:                               #   in Loop: Header=BB5_12 Depth=3
	movq	-16(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -16(%rbp)
	jmp	.LBB5_12
.LBB5_15:                               #   in Loop: Header=BB5_10 Depth=2
	leaq	-104(%rbp), %rdi
	callq	*-120(%rbp)
	movq	-8(%rbp), %rcx
	movq	(%rcx), %rcx
	movq	-32(%rbp), %rdx
	imulq	-40(%rbp), %rdx
	addq	-24(%rbp), %rdx
	movq	%rax, (%rcx,%rdx,8)
# %bb.16:                               #   in Loop: Header=BB5_10 Depth=2
	movq	-24(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -24(%rbp)
	jmp	.LBB5_10
.LBB5_17:                               #   in Loop: Header=BB5_8 Depth=1
	jmp	.LBB5_18
.LBB5_18:                               #   in Loop: Header=BB5_8 Depth=1
	movq	-32(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -32(%rbp)
	jmp	.LBB5_8
.LBB5_19:                               # %.loopexit
	jmp	.LBB5_20
.LBB5_20:
	addq	$128, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end5:
	.size	JITensor_inner_product, .Lfunc_end5-JITensor_inner_product
	.cfi_endproc
                                        # -- End function
	.globl	JITensor_fold                   # -- Begin function JITensor_fold
	.p2align	4, 0x90
	.type	JITensor_fold,@function
JITensor_fold:                          # @JITensor_fold
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%rdx, -40(%rbp)
	movq	-16(%rbp), %rax
	cmpq	$0, 24(%rax)
	jne	.LBB6_2
# %bb.1:
	movq	-40(%rbp), %rax
	movq	%rax, -32(%rbp)
	jmp	.LBB6_7
.LBB6_2:
	movq	-16(%rbp), %rax
	movq	24(%rax), %rax
	subq	$1, %rax
	movq	%rax, -8(%rbp)
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movq	-8(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movq	%rax, -24(%rbp)
	movq	-8(%rbp), %rax
	addq	$-1, %rax
	movq	%rax, -8(%rbp)
.LBB6_3:                                # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	movq	-16(%rbp), %rcx
	cmpq	24(%rcx), %rax
	jae	.LBB6_6
# %bb.4:                                #   in Loop: Header=BB6_3 Depth=1
	movq	-48(%rbp), %rax
	movq	-24(%rbp), %rdi
	movq	-16(%rbp), %rcx
	movq	(%rcx), %rcx
	movq	-8(%rbp), %rdx
	movq	(%rcx,%rdx,8), %rsi
	callq	*%rax
	movq	%rax, -24(%rbp)
# %bb.5:                                #   in Loop: Header=BB6_3 Depth=1
	movq	-8(%rbp), %rax
	addq	$-1, %rax
	movq	%rax, -8(%rbp)
	jmp	.LBB6_3
.LBB6_6:
	movq	-24(%rbp), %rax
	movq	%rax, -32(%rbp)
.LBB6_7:
	movq	-32(%rbp), %rax
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end6:
	.size	JITensor_fold, .Lfunc_end6-JITensor_fold
	.cfi_endproc
                                        # -- End function
	.globl	JITensor_dump                   # -- Begin function JITensor_dump
	.p2align	4, 0x90
	.type	JITensor_dump,@function
JITensor_dump:                          # @JITensor_dump
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	movq	%rdi, -16(%rbp)
	movq	-16(%rbp), %rax
	cmpq	$0, 16(%rax)
	jne	.LBB7_2
# %bb.1:
	jmp	.LBB7_15
.LBB7_2:
	movq	$0, -8(%rbp)
.LBB7_3:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB7_5 Depth 2
	movq	-8(%rbp), %rax
	movq	-16(%rbp), %rcx
	cmpq	24(%rcx), %rax
	jae	.LBB7_14
# %bb.4:                                #   in Loop: Header=BB7_3 Depth=1
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movq	-8(%rbp), %rcx
	movq	(%rax,%rcx,8), %rsi
	movabsq	$.putn_fmt, %rdi
	movb	$0, %al
	callq	printf@PLT
	movq	$1, -40(%rbp)
	movl	$1, -20(%rbp)
	movq	-16(%rbp), %rax
	movq	16(%rax), %rax
	subq	$1, %rax
	movq	%rax, -32(%rbp)
.LBB7_5:                                #   Parent Loop BB7_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpq	$1, -32(%rbp)
	jb	.LBB7_10
# %bb.6:                                #   in Loop: Header=BB7_5 Depth=2
	movq	-16(%rbp), %rax
	movq	8(%rax), %rax
	movq	-32(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	imulq	-40(%rbp), %rax
	movq	%rax, -40(%rbp)
	movq	-8(%rbp), %rax
	xorl	%edx, %edx
	divq	-40(%rbp)
	movq	-40(%rbp), %rax
	subq	$1, %rax
	cmpq	%rax, %rdx
	jne	.LBB7_8
# %bb.7:                                #   in Loop: Header=BB7_5 Depth=2
	movl	$0, -20(%rbp)
	movl	$10, %edi
	callq	putchar@PLT
.LBB7_8:                                #   in Loop: Header=BB7_5 Depth=2
	jmp	.LBB7_9
.LBB7_9:                                #   in Loop: Header=BB7_5 Depth=2
	movq	-32(%rbp), %rax
	addq	$-1, %rax
	movq	%rax, -32(%rbp)
	jmp	.LBB7_5
.LBB7_10:                               #   in Loop: Header=BB7_3 Depth=1
	cmpl	$0, -20(%rbp)
	je	.LBB7_12
# %bb.11:                               #   in Loop: Header=BB7_3 Depth=1
	movl	$32, %edi
	callq	putchar@PLT
.LBB7_12:                               #   in Loop: Header=BB7_3 Depth=1
	jmp	.LBB7_13
.LBB7_13:                               #   in Loop: Header=BB7_3 Depth=1
	movq	-8(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -8(%rbp)
	jmp	.LBB7_3
.LBB7_14:                               # %.loopexit
	jmp	.LBB7_15
.LBB7_15:
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end7:
	.size	JITensor_dump, .Lfunc_end7-JITensor_dump
	.cfi_endproc
                                        # -- End function
	.globl	JITensor_same_dim               # -- Begin function JITensor_same_dim
	.p2align	4, 0x90
	.type	JITensor_same_dim,@function
JITensor_same_dim:                      # @JITensor_same_dim
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	movq	-32(%rbp), %rcx
	cmpq	16(%rcx), %rax
	je	.LBB8_2
# %bb.1:
	movl	$0, -4(%rbp)
	jmp	.LBB8_9
.LBB8_2:
	movq	$0, -16(%rbp)
.LBB8_3:                                # =>This Inner Loop Header: Depth=1
	movq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	cmpq	16(%rcx), %rax
	jae	.LBB8_8
# %bb.4:                                #   in Loop: Header=BB8_3 Depth=1
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
	movq	-16(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movq	-32(%rbp), %rcx
	movq	8(%rcx), %rcx
	movq	-16(%rbp), %rdx
	cmpq	(%rcx,%rdx,8), %rax
	je	.LBB8_6
# %bb.5:
	movl	$0, -4(%rbp)
	jmp	.LBB8_9
.LBB8_6:                                #   in Loop: Header=BB8_3 Depth=1
	jmp	.LBB8_7
.LBB8_7:                                #   in Loop: Header=BB8_3 Depth=1
	movq	-16(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -16(%rbp)
	jmp	.LBB8_3
.LBB8_8:
	movl	$1, -4(%rbp)
.LBB8_9:
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end8:
	.size	JITensor_same_dim, .Lfunc_end8-JITensor_same_dim
	.cfi_endproc
                                        # -- End function
	.globl	JITensor_copy_shape             # -- Begin function JITensor_copy_shape
	.p2align	4, 0x90
	.type	JITensor_copy_shape,@function
JITensor_copy_shape:                    # @JITensor_copy_shape
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -8(%rbp)
	movq	-16(%rbp), %rdi
	movq	-8(%rbp), %rsi
	callq	JITensor_same_dim
	cmpl	$0, %eax
	jne	.LBB9_6
# %bb.1:
	movq	-8(%rbp), %rax
	cmpq	$0, (%rax)
	je	.LBB9_3
# %bb.2:
	movq	-8(%rbp), %rax
	movq	(%rax), %rdi
	callq	free@PLT
.LBB9_3:
	movq	-16(%rbp), %rax
	movq	24(%rax), %rdi
	shlq	$3, %rdi
	callq	malloc@PLT
	movq	-8(%rbp), %rcx
	movq	%rax, (%rcx)
	movq	-8(%rbp), %rax
	cmpq	$0, 8(%rax)
	je	.LBB9_5
# %bb.4:
	movq	-8(%rbp), %rax
	movq	8(%rax), %rdi
	callq	free@PLT
.LBB9_5:
	movq	-16(%rbp), %rax
	movq	16(%rax), %rdi
	shlq	$3, %rdi
	callq	malloc@PLT
	movq	-8(%rbp), %rcx
	movq	%rax, 8(%rcx)
	movq	-8(%rbp), %rax
	movq	8(%rax), %rdi
	movq	-16(%rbp), %rax
	movq	8(%rax), %rsi
	movq	-16(%rbp), %rax
	movq	16(%rax), %rdx
	shlq	$3, %rdx
	callq	memcpy@PLT
	movq	-16(%rbp), %rax
	movq	24(%rax), %rax
	movq	-8(%rbp), %rcx
	movq	%rax, 24(%rcx)
	movq	-16(%rbp), %rax
	movq	16(%rax), %rax
	movq	-8(%rbp), %rcx
	movq	%rax, 16(%rcx)
.LBB9_6:
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end9:
	.size	JITensor_copy_shape, .Lfunc_end9-JITensor_copy_shape
	.cfi_endproc
                                        # -- End function
	.globl	JITensor_copy_value             # -- Begin function JITensor_copy_value
	.p2align	4, 0x90
	.type	JITensor_copy_value,@function
JITensor_copy_value:                    # @JITensor_copy_value
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rdi
	movq	-16(%rbp), %rsi
	callq	JITensor_copy_shape
	movq	-16(%rbp), %rax
	movq	(%rax), %rdi
	movq	-8(%rbp), %rax
	movq	(%rax), %rsi
	movq	-8(%rbp), %rax
	movq	24(%rax), %rdx
	shlq	$3, %rdx
	callq	memcpy@PLT
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end10:
	.size	JITensor_copy_value, .Lfunc_end10-JITensor_copy_value
	.cfi_endproc
                                        # -- End function
	.globl	JITensor_add_vec_vec            # -- Begin function JITensor_add_vec_vec
	.p2align	4, 0x90
	.type	JITensor_add_vec_vec,@function
JITensor_add_vec_vec:                   # @JITensor_add_vec_vec
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-16(%rbp), %rdi
	movq	-32(%rbp), %rsi
	callq	JITensor_same_dim
	cmpl	$0, %eax
	jne	.LBB11_2
# %bb.1:
	jmp	.LBB11_7
.LBB11_2:
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	callq	JITensor_copy_shape
	movq	$0, -8(%rbp)
.LBB11_3:                               # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	movq	-16(%rbp), %rcx
	cmpq	24(%rcx), %rax
	jae	.LBB11_6
# %bb.4:                                #   in Loop: Header=BB11_3 Depth=1
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movq	-8(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movq	-32(%rbp), %rcx
	movq	(%rcx), %rcx
	movq	-8(%rbp), %rdx
	addq	(%rcx,%rdx,8), %rax
	movq	-24(%rbp), %rcx
	movq	(%rcx), %rcx
	movq	-8(%rbp), %rdx
	movq	%rax, (%rcx,%rdx,8)
# %bb.5:                                #   in Loop: Header=BB11_3 Depth=1
	movq	-8(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -8(%rbp)
	jmp	.LBB11_3
.LBB11_6:                               # %.loopexit
	jmp	.LBB11_7
.LBB11_7:
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end11:
	.size	JITensor_add_vec_vec, .Lfunc_end11-JITensor_add_vec_vec
	.cfi_endproc
                                        # -- End function
	.globl	JITensor_sub_vec_vec            # -- Begin function JITensor_sub_vec_vec
	.p2align	4, 0x90
	.type	JITensor_sub_vec_vec,@function
JITensor_sub_vec_vec:                   # @JITensor_sub_vec_vec
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-16(%rbp), %rdi
	movq	-32(%rbp), %rsi
	callq	JITensor_same_dim
	cmpl	$0, %eax
	jne	.LBB12_2
# %bb.1:
	jmp	.LBB12_7
.LBB12_2:
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	callq	JITensor_copy_shape
	movq	$0, -8(%rbp)
.LBB12_3:                               # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	movq	-16(%rbp), %rcx
	cmpq	24(%rcx), %rax
	jae	.LBB12_6
# %bb.4:                                #   in Loop: Header=BB12_3 Depth=1
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movq	-8(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movq	-32(%rbp), %rcx
	movq	(%rcx), %rcx
	movq	-8(%rbp), %rdx
	subq	(%rcx,%rdx,8), %rax
	movq	-24(%rbp), %rcx
	movq	(%rcx), %rcx
	movq	-8(%rbp), %rdx
	movq	%rax, (%rcx,%rdx,8)
# %bb.5:                                #   in Loop: Header=BB12_3 Depth=1
	movq	-8(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -8(%rbp)
	jmp	.LBB12_3
.LBB12_6:                               # %.loopexit
	jmp	.LBB12_7
.LBB12_7:
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end12:
	.size	JITensor_sub_vec_vec, .Lfunc_end12-JITensor_sub_vec_vec
	.cfi_endproc
                                        # -- End function
	.globl	JITensor_mul_vec_vec            # -- Begin function JITensor_mul_vec_vec
	.p2align	4, 0x90
	.type	JITensor_mul_vec_vec,@function
JITensor_mul_vec_vec:                   # @JITensor_mul_vec_vec
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-16(%rbp), %rdi
	movq	-32(%rbp), %rsi
	callq	JITensor_same_dim
	cmpl	$0, %eax
	jne	.LBB13_2
# %bb.1:
	jmp	.LBB13_7
.LBB13_2:
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	callq	JITensor_copy_shape
	movq	$0, -8(%rbp)
.LBB13_3:                               # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	movq	-16(%rbp), %rcx
	cmpq	24(%rcx), %rax
	jae	.LBB13_6
# %bb.4:                                #   in Loop: Header=BB13_3 Depth=1
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movq	-8(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movq	-32(%rbp), %rcx
	movq	(%rcx), %rcx
	movq	-8(%rbp), %rdx
	imulq	(%rcx,%rdx,8), %rax
	movq	-24(%rbp), %rcx
	movq	(%rcx), %rcx
	movq	-8(%rbp), %rdx
	movq	%rax, (%rcx,%rdx,8)
# %bb.5:                                #   in Loop: Header=BB13_3 Depth=1
	movq	-8(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -8(%rbp)
	jmp	.LBB13_3
.LBB13_6:                               # %.loopexit
	jmp	.LBB13_7
.LBB13_7:
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end13:
	.size	JITensor_mul_vec_vec, .Lfunc_end13-JITensor_mul_vec_vec
	.cfi_endproc
                                        # -- End function
	.globl	JITensor_div_vec_vec            # -- Begin function JITensor_div_vec_vec
	.p2align	4, 0x90
	.type	JITensor_div_vec_vec,@function
JITensor_div_vec_vec:                   # @JITensor_div_vec_vec
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-16(%rbp), %rdi
	movq	-32(%rbp), %rsi
	callq	JITensor_same_dim
	cmpl	$0, %eax
	jne	.LBB14_2
# %bb.1:
	jmp	.LBB14_7
.LBB14_2:
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	callq	JITensor_copy_shape
	movq	$0, -8(%rbp)
.LBB14_3:                               # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	movq	-16(%rbp), %rcx
	cmpq	24(%rcx), %rax
	jae	.LBB14_6
# %bb.4:                                #   in Loop: Header=BB14_3 Depth=1
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movq	-8(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movq	-32(%rbp), %rcx
	movq	(%rcx), %rcx
	movq	-8(%rbp), %rsi
	cqto
	idivq	(%rcx,%rsi,8)
	movq	-24(%rbp), %rcx
	movq	(%rcx), %rcx
	movq	-8(%rbp), %rdx
	movq	%rax, (%rcx,%rdx,8)
# %bb.5:                                #   in Loop: Header=BB14_3 Depth=1
	movq	-8(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -8(%rbp)
	jmp	.LBB14_3
.LBB14_6:                               # %.loopexit
	jmp	.LBB14_7
.LBB14_7:
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end14:
	.size	JITensor_div_vec_vec, .Lfunc_end14-JITensor_div_vec_vec
	.cfi_endproc
                                        # -- End function
	.globl	idot                            # -- Begin function idot
	.p2align	4, 0x90
	.type	idot,@function
idot:                                   # @idot
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	$1, 16(%rax)
	movq	-8(%rbp), %rax
	movq	16(%rax), %rdi
	shlq	$3, %rdi
	callq	malloc@PLT
	movq	-8(%rbp), %rcx
	movq	%rax, 8(%rcx)
	movq	-24(%rbp), %rax
	movq	-8(%rbp), %rcx
	movq	8(%rcx), %rcx
	movq	%rax, (%rcx)
	movq	-24(%rbp), %rax
	movq	-8(%rbp), %rcx
	movq	%rax, 24(%rcx)
	movq	-8(%rbp), %rax
	movq	24(%rax), %rdi
	shlq	$3, %rdi
	callq	malloc@PLT
	movq	-8(%rbp), %rcx
	movq	%rax, (%rcx)
	movq	$0, -16(%rbp)
.LBB15_1:                               # =>This Inner Loop Header: Depth=1
	movq	-16(%rbp), %rax
	cmpq	-24(%rbp), %rax
	jge	.LBB15_4
# %bb.2:                                #   in Loop: Header=BB15_1 Depth=1
	movq	-16(%rbp), %rax
	movq	-8(%rbp), %rcx
	movq	(%rcx), %rcx
	movq	-16(%rbp), %rdx
	movq	%rax, (%rcx,%rdx,8)
# %bb.3:                                #   in Loop: Header=BB15_1 Depth=1
	movq	-16(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -16(%rbp)
	jmp	.LBB15_1
.LBB15_4:
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end15:
	.size	idot, .Lfunc_end15-idot
	.cfi_endproc
                                        # -- End function
	.globl	task2                           # -- Begin function task2
	.p2align	4, 0x90
	.type	task2,@function
task2:                                  # @task2
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	$2, 16(%rax)
	movq	-8(%rbp), %rax
	movq	16(%rax), %rdi
	shlq	$3, %rdi
	callq	malloc@PLT
	movq	-8(%rbp), %rcx
	movq	%rax, 8(%rcx)
	movq	-40(%rbp), %rax
	movq	-8(%rbp), %rcx
	movq	8(%rcx), %rcx
	movq	%rax, (%rcx)
	movq	-32(%rbp), %rax
	movq	-8(%rbp), %rcx
	movq	8(%rcx), %rcx
	movq	%rax, 8(%rcx)
	movq	-40(%rbp), %rax
	imulq	-32(%rbp), %rax
	movq	-8(%rbp), %rcx
	movq	%rax, 24(%rcx)
	movq	-8(%rbp), %rax
	movq	24(%rax), %rdi
	shlq	$3, %rdi
	callq	malloc@PLT
	movq	-8(%rbp), %rcx
	movq	%rax, (%rcx)
	movq	$0, -24(%rbp)
.LBB16_1:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB16_3 Depth 2
	movq	-24(%rbp), %rax
	cmpq	-40(%rbp), %rax
	jae	.LBB16_8
# %bb.2:                                #   in Loop: Header=BB16_1 Depth=1
	movq	$0, -16(%rbp)
.LBB16_3:                               #   Parent Loop BB16_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-16(%rbp), %rax
	cmpq	-32(%rbp), %rax
	jae	.LBB16_6
# %bb.4:                                #   in Loop: Header=BB16_3 Depth=2
	callq	rand@PLT
	movl	$10, %ecx
	cltd
	idivl	%ecx
	movslq	%edx, %rax
	movq	-8(%rbp), %rcx
	movq	(%rcx), %rcx
	movq	-24(%rbp), %rdx
	imulq	-32(%rbp), %rdx
	addq	-16(%rbp), %rdx
	movq	%rax, (%rcx,%rdx,8)
# %bb.5:                                #   in Loop: Header=BB16_3 Depth=2
	movq	-16(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -16(%rbp)
	jmp	.LBB16_3
.LBB16_6:                               #   in Loop: Header=BB16_1 Depth=1
	jmp	.LBB16_7
.LBB16_7:                               #   in Loop: Header=BB16_1 Depth=1
	movq	-24(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -24(%rbp)
	jmp	.LBB16_1
.LBB16_8:
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end16:
	.size	task2, .Lfunc_end16-task2
	.cfi_endproc
                                        # -- End function
	.globl	task3                           # -- Begin function task3
	.p2align	4, 0x90
	.type	task3,@function
task3:                                  # @task3
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	movq	%rdi, -48(%rbp)
	movq	%rsi, -40(%rbp)
	movq	%rdx, -32(%rbp)
	movq	%rcx, -24(%rbp)
	movq	%r8, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	$4, 16(%rax)
	movq	-8(%rbp), %rax
	movq	16(%rax), %rdi
	shlq	$3, %rdi
	callq	malloc@PLT
	movq	-8(%rbp), %rcx
	movq	%rax, 8(%rcx)
	movq	-48(%rbp), %rax
	movq	-8(%rbp), %rcx
	movq	8(%rcx), %rcx
	movq	%rax, (%rcx)
	movq	-40(%rbp), %rax
	movq	-8(%rbp), %rcx
	movq	8(%rcx), %rcx
	movq	%rax, 8(%rcx)
	movq	-32(%rbp), %rax
	movq	-8(%rbp), %rcx
	movq	8(%rcx), %rcx
	movq	%rax, 16(%rcx)
	movq	-24(%rbp), %rax
	movq	-8(%rbp), %rcx
	movq	8(%rcx), %rcx
	movq	%rax, 24(%rcx)
	movq	-48(%rbp), %rax
	imulq	-40(%rbp), %rax
	imulq	-32(%rbp), %rax
	imulq	-24(%rbp), %rax
	movq	-8(%rbp), %rcx
	movq	%rax, 24(%rcx)
	movq	-8(%rbp), %rax
	movq	24(%rax), %rdi
	shlq	$3, %rdi
	callq	malloc@PLT
	movq	-8(%rbp), %rcx
	movq	%rax, (%rcx)
	movq	$0, -16(%rbp)
.LBB17_1:                               # =>This Inner Loop Header: Depth=1
	movq	-16(%rbp), %rax
	movq	-8(%rbp), %rcx
	cmpq	24(%rcx), %rax
	jae	.LBB17_4
# %bb.2:                                #   in Loop: Header=BB17_1 Depth=1
	callq	rand@PLT
	movl	$100, %ecx
	cltd
	idivl	%ecx
	movslq	%edx, %rax
	movq	-8(%rbp), %rcx
	movq	(%rcx), %rcx
	movq	-16(%rbp), %rdx
	movq	%rax, (%rcx,%rdx,8)
# %bb.3:                                #   in Loop: Header=BB17_1 Depth=1
	movq	-16(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -16(%rbp)
	jmp	.LBB17_1
.LBB17_4:
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end17:
	.size	task3, .Lfunc_end17-task3
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function ns_time
	.type	ns_time,@function
ns_time:                                # @ns_time
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	leaq	-16(%rbp), %rsi
	xorl	%edi, %edi
	callq	clock_gettime@PLT
	imulq	$1000000000, -16(%rbp), %rax    # imm = 0x3B9ACA00
	addq	-8(%rbp), %rax
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end18:
	.size	ns_time, .Lfunc_end18-ns_time
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3                               # -- Begin function main
.LCPI19_0:
	.quad	0x41cdcd6500000000              # double 1.0E+9
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4
.LCPI19_1:
	.long	1127219200                      # 0x43300000
	.long	1160773632                      # 0x45300000
	.long	0                               # 0x0
	.long	0                               # 0x0
.LCPI19_2:
	.quad	0x4330000000000000              # double 4503599627370496
	.quad	0x4530000000000000              # double 1.9342813113834067E+25
	.text
	.globl	main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	subq	$992, %rsp                      # imm = 0x3E0
	.cfi_offset %rbx, -48
	.cfi_offset %r12, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	xorps	%xmm0, %xmm0
	movaps	%xmm0, -1008(%rbp)
	movaps	%xmm0, -1024(%rbp)
	movaps	%xmm0, -976(%rbp)
	movaps	%xmm0, -992(%rbp)
	leaq	-992(%rbp), %rbx
	movl	$70, %edi
	movl	$40, %esi
	movl	$30, %edx
	movl	$64, %ecx
	movq	%rbx, %r8
	callq	task3
	leaq	-1024(%rbp), %r14
	movq	%rbx, %rdi
	movq	%r14, %rsi
	callq	JITensor_copy_value
	xorps	%xmm0, %xmm0
	movaps	%xmm0, -944(%rbp)
	movaps	%xmm0, -960(%rbp)
	movaps	%xmm0, -912(%rbp)
	movaps	%xmm0, -928(%rbp)
	leaq	-928(%rbp), %rbx
	movl	$70, %edi
	movl	$40, %esi
	movl	$30, %edx
	movl	$64, %ecx
	movq	%rbx, %r8
	callq	task3
	leaq	-960(%rbp), %r15
	movq	%rbx, %rdi
	movq	%r15, %rsi
	callq	JITensor_copy_value
	callq	ns_time
	movq	%rax, -152(%rbp)
	xorps	%xmm0, %xmm0
	movaps	%xmm0, -880(%rbp)
	movaps	%xmm0, -896(%rbp)
	leaq	-896(%rbp), %r12
	movq	%r14, %rdi
	movq	%r12, %rsi
	callq	JITensor_copy_value
	xorps	%xmm0, %xmm0
	movaps	%xmm0, -848(%rbp)
	movaps	%xmm0, -864(%rbp)
	leaq	-864(%rbp), %rbx
	movq	%r15, %rdi
	movq	%rbx, %rsi
	callq	JITensor_copy_value
	xorps	%xmm0, %xmm0
	movaps	%xmm0, -816(%rbp)
	movaps	%xmm0, -832(%rbp)
	leaq	-832(%rbp), %rdx
	movq	%r12, %rdi
	movq	%rbx, %rsi
	callq	JITensor_mul_vec_vec
	callq	ns_time
	movq	%rax, -144(%rbp)
	movq	-144(%rbp), %rax
	movq	-152(%rbp), %rcx
	subq	%rcx, %rax
	movq	%rax, %xmm0
	punpckldq	.LCPI19_1(%rip), %xmm0  # xmm0 = xmm0[0],mem[0],xmm0[1],mem[1]
	subpd	.LCPI19_2(%rip), %xmm0
	movaps	%xmm0, %xmm1
	unpckhpd	%xmm1, %xmm1                    # xmm1 = xmm1[1,1]
	addsd	%xmm0, %xmm1
	divsd	.LCPI19_0(%rip), %xmm1
	movsd	%xmm1, -136(%rbp)
	movsd	-136(%rbp), %xmm0               # xmm0 = mem[0],zero
	movl	$.L.outfmt, %edi
	movb	$1, %al
	callq	printf@PLT
	xorps	%xmm0, %xmm0
	movaps	%xmm0, -784(%rbp)
	movaps	%xmm0, -800(%rbp)
	leaq	-800(%rbp), %rbx
	movl	$70, %edi
	movl	$40, %esi
	movl	$30, %edx
	movl	$64, %ecx
	movq	%rbx, %r8
	callq	task3
	movq	%rbx, %rdi
	movq	%r14, %rsi
	callq	JITensor_copy_value
	xorps	%xmm0, %xmm0
	movaps	%xmm0, -752(%rbp)
	movaps	%xmm0, -768(%rbp)
	leaq	-768(%rbp), %rbx
	movl	$70, %edi
	movl	$40, %esi
	movl	$30, %edx
	movl	$64, %ecx
	movq	%rbx, %r8
	callq	task3
	movq	%rbx, %rdi
	movq	%r15, %rsi
	callq	JITensor_copy_value
	callq	ns_time
	movq	%rax, -128(%rbp)
	xorps	%xmm0, %xmm0
	movaps	%xmm0, -720(%rbp)
	movaps	%xmm0, -736(%rbp)
	leaq	-736(%rbp), %r12
	movq	%r14, %rdi
	movq	%r12, %rsi
	callq	JITensor_copy_value
	xorps	%xmm0, %xmm0
	movaps	%xmm0, -688(%rbp)
	movaps	%xmm0, -704(%rbp)
	leaq	-704(%rbp), %rbx
	movq	%r15, %rdi
	movq	%rbx, %rsi
	callq	JITensor_copy_value
	xorps	%xmm0, %xmm0
	movaps	%xmm0, -656(%rbp)
	movaps	%xmm0, -672(%rbp)
	leaq	-672(%rbp), %rdx
	movq	%r12, %rdi
	movq	%rbx, %rsi
	callq	JITensor_mul_vec_vec
	callq	ns_time
	movq	%rax, -120(%rbp)
	movq	-120(%rbp), %rax
	movq	-128(%rbp), %rcx
	subq	%rcx, %rax
	movq	%rax, %xmm0
	punpckldq	.LCPI19_1(%rip), %xmm0  # xmm0 = xmm0[0],mem[0],xmm0[1],mem[1]
	subpd	.LCPI19_2(%rip), %xmm0
	movaps	%xmm0, %xmm1
	unpckhpd	%xmm1, %xmm1                    # xmm1 = xmm1[1,1]
	addsd	%xmm0, %xmm1
	divsd	.LCPI19_0(%rip), %xmm1
	movsd	%xmm1, -112(%rbp)
	movsd	-112(%rbp), %xmm0               # xmm0 = mem[0],zero
	movl	$.L.outfmt, %edi
	movb	$1, %al
	callq	printf@PLT
	xorps	%xmm0, %xmm0
	movaps	%xmm0, -624(%rbp)
	movaps	%xmm0, -640(%rbp)
	leaq	-640(%rbp), %rbx
	movl	$70, %edi
	movl	$40, %esi
	movl	$30, %edx
	movl	$64, %ecx
	movq	%rbx, %r8
	callq	task3
	movq	%rbx, %rdi
	movq	%r14, %rsi
	callq	JITensor_copy_value
	xorps	%xmm0, %xmm0
	movaps	%xmm0, -592(%rbp)
	movaps	%xmm0, -608(%rbp)
	leaq	-608(%rbp), %rbx
	movl	$70, %edi
	movl	$40, %esi
	movl	$30, %edx
	movl	$64, %ecx
	movq	%rbx, %r8
	callq	task3
	movq	%rbx, %rdi
	movq	%r15, %rsi
	callq	JITensor_copy_value
	callq	ns_time
	movq	%rax, -104(%rbp)
	xorps	%xmm0, %xmm0
	movaps	%xmm0, -560(%rbp)
	movaps	%xmm0, -576(%rbp)
	leaq	-576(%rbp), %r12
	movq	%r14, %rdi
	movq	%r12, %rsi
	callq	JITensor_copy_value
	xorps	%xmm0, %xmm0
	movaps	%xmm0, -528(%rbp)
	movaps	%xmm0, -544(%rbp)
	leaq	-544(%rbp), %rbx
	movq	%r15, %rdi
	movq	%rbx, %rsi
	callq	JITensor_copy_value
	xorps	%xmm0, %xmm0
	movaps	%xmm0, -496(%rbp)
	movaps	%xmm0, -512(%rbp)
	leaq	-512(%rbp), %rdx
	movq	%r12, %rdi
	movq	%rbx, %rsi
	callq	JITensor_mul_vec_vec
	callq	ns_time
	movq	%rax, -96(%rbp)
	movq	-96(%rbp), %rax
	movq	-104(%rbp), %rcx
	subq	%rcx, %rax
	movq	%rax, %xmm0
	punpckldq	.LCPI19_1(%rip), %xmm0  # xmm0 = xmm0[0],mem[0],xmm0[1],mem[1]
	subpd	.LCPI19_2(%rip), %xmm0
	movaps	%xmm0, %xmm1
	unpckhpd	%xmm1, %xmm1                    # xmm1 = xmm1[1,1]
	addsd	%xmm0, %xmm1
	divsd	.LCPI19_0(%rip), %xmm1
	movsd	%xmm1, -88(%rbp)
	movsd	-88(%rbp), %xmm0                # xmm0 = mem[0],zero
	movl	$.L.outfmt, %edi
	movb	$1, %al
	callq	printf@PLT
	xorps	%xmm0, %xmm0
	movaps	%xmm0, -464(%rbp)
	movaps	%xmm0, -480(%rbp)
	leaq	-480(%rbp), %rbx
	movl	$70, %edi
	movl	$40, %esi
	movl	$30, %edx
	movl	$64, %ecx
	movq	%rbx, %r8
	callq	task3
	movq	%rbx, %rdi
	movq	%r14, %rsi
	callq	JITensor_copy_value
	xorps	%xmm0, %xmm0
	movaps	%xmm0, -432(%rbp)
	movaps	%xmm0, -448(%rbp)
	leaq	-448(%rbp), %rbx
	movl	$70, %edi
	movl	$40, %esi
	movl	$30, %edx
	movl	$64, %ecx
	movq	%rbx, %r8
	callq	task3
	movq	%rbx, %rdi
	movq	%r15, %rsi
	callq	JITensor_copy_value
	callq	ns_time
	movq	%rax, -80(%rbp)
	xorps	%xmm0, %xmm0
	movaps	%xmm0, -400(%rbp)
	movaps	%xmm0, -416(%rbp)
	leaq	-416(%rbp), %r12
	movq	%r14, %rdi
	movq	%r12, %rsi
	callq	JITensor_copy_value
	xorps	%xmm0, %xmm0
	movaps	%xmm0, -368(%rbp)
	movaps	%xmm0, -384(%rbp)
	leaq	-384(%rbp), %rbx
	movq	%r15, %rdi
	movq	%rbx, %rsi
	callq	JITensor_copy_value
	xorps	%xmm0, %xmm0
	movaps	%xmm0, -336(%rbp)
	movaps	%xmm0, -352(%rbp)
	leaq	-352(%rbp), %rdx
	movq	%r12, %rdi
	movq	%rbx, %rsi
	callq	JITensor_mul_vec_vec
	callq	ns_time
	movq	%rax, -72(%rbp)
	movq	-72(%rbp), %rax
	movq	-80(%rbp), %rcx
	subq	%rcx, %rax
	movq	%rax, %xmm0
	punpckldq	.LCPI19_1(%rip), %xmm0  # xmm0 = xmm0[0],mem[0],xmm0[1],mem[1]
	subpd	.LCPI19_2(%rip), %xmm0
	movaps	%xmm0, %xmm1
	unpckhpd	%xmm1, %xmm1                    # xmm1 = xmm1[1,1]
	addsd	%xmm0, %xmm1
	divsd	.LCPI19_0(%rip), %xmm1
	movsd	%xmm1, -64(%rbp)
	movsd	-64(%rbp), %xmm0                # xmm0 = mem[0],zero
	movl	$.L.outfmt, %edi
	movb	$1, %al
	callq	printf@PLT
	xorps	%xmm0, %xmm0
	movaps	%xmm0, -304(%rbp)
	movaps	%xmm0, -320(%rbp)
	leaq	-320(%rbp), %rbx
	movl	$70, %edi
	movl	$40, %esi
	movl	$30, %edx
	movl	$64, %ecx
	movq	%rbx, %r8
	callq	task3
	movq	%rbx, %rdi
	movq	%r14, %rsi
	callq	JITensor_copy_value
	xorps	%xmm0, %xmm0
	movaps	%xmm0, -272(%rbp)
	movaps	%xmm0, -288(%rbp)
	leaq	-288(%rbp), %rbx
	movl	$70, %edi
	movl	$40, %esi
	movl	$30, %edx
	movl	$64, %ecx
	movq	%rbx, %r8
	callq	task3
	movq	%rbx, %rdi
	movq	%r15, %rsi
	callq	JITensor_copy_value
	callq	ns_time
	movq	%rax, -56(%rbp)
	xorps	%xmm0, %xmm0
	movaps	%xmm0, -240(%rbp)
	movaps	%xmm0, -256(%rbp)
	leaq	-256(%rbp), %r12
	movq	%r14, %rdi
	movq	%r12, %rsi
	callq	JITensor_copy_value
	xorps	%xmm0, %xmm0
	movaps	%xmm0, -208(%rbp)
	movaps	%xmm0, -224(%rbp)
	leaq	-224(%rbp), %rbx
	movq	%r15, %rdi
	movq	%rbx, %rsi
	callq	JITensor_copy_value
	xorps	%xmm0, %xmm0
	movaps	%xmm0, -176(%rbp)
	movaps	%xmm0, -192(%rbp)
	leaq	-192(%rbp), %rdx
	movq	%r12, %rdi
	movq	%rbx, %rsi
	callq	JITensor_mul_vec_vec
	callq	ns_time
	movq	%rax, -48(%rbp)
	movq	-48(%rbp), %rax
	movq	-56(%rbp), %rcx
	subq	%rcx, %rax
	movq	%rax, %xmm0
	punpckldq	.LCPI19_1(%rip), %xmm0  # xmm0 = xmm0[0],mem[0],xmm0[1],mem[1]
	subpd	.LCPI19_2(%rip), %xmm0
	movaps	%xmm0, %xmm1
	unpckhpd	%xmm1, %xmm1                    # xmm1 = xmm1[1,1]
	addsd	%xmm0, %xmm1
	movsd	.LCPI19_0(%rip), %xmm0          # xmm0 = mem[0],zero
	divsd	%xmm0, %xmm1
	movsd	%xmm1, -40(%rbp)
	movsd	-40(%rbp), %xmm0                # xmm0 = mem[0],zero
	movabsq	$.L.outfmt, %rdi
	movb	$1, %al
	callq	printf@PLT
	xorl	%eax, %eax
	addq	$992, %rsp                      # imm = 0x3E0
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end19:
	.size	main, .Lfunc_end19-main
	.cfi_endproc
                                        # -- End function
	.type	.putn_fmt,@object               # @.putn_fmt
	.section	.rodata,"a",@progbits
.putn_fmt:
	.asciz	"%lld"
	.size	.putn_fmt, 5

	.type	.L.outfmt,@object               # @.outfmt
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.outfmt:
	.asciz	"%g\n"
	.size	.L.outfmt, 4

	.section	".note.GNU-stack","",@progbits
