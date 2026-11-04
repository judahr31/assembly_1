.text

    .globl relation_code
    .type relation_code, @function
relation_code:
    # TODO: Problem 1
    movq $0, %rax
    cmpq %rsi, %rdi
    jge skip1
    addq $1, %rax
    skip1:
        cmpq %rsi, %rdi
        jae skip2
        addq $2, %rax
    skip2:
        ret


    .globl clamp_long
    .type clamp_long, @function
clamp_long:
    # TODO: Problem 2
    movq %rdi, %rax
    cmpq %rsi, %rdi
    jge skip3
    movq %rsi, %rax
    ret
    skip3:
        cmpq %rdx, %rdi
        jle skip4
        movq %rdx, %rax
        ret
    skip4:
        ret

    .globl weighted_sum8
    .type weighted_sum8, @function
weighted_sum8:
    # TODO: Problem 3
    movq %rdi, %rax
    imulq $2, %rsi
    addq %rsi, %rax
    imulq $3, %rdx
    addq %rdx, %rax
    imulq $4, %rcx
    addq %rcx, %rax
    imulq $5, %r8
    addq %r8, %rax
    imulq $6, %r9
    addq %r9, %rax
    movq 8(%rsp), %rdi # g
    movq 16(%rsp), %rsi # h
    imulq $8, %rsi
    addq %rsi, %rax
    imulq $7, %rdi
    addq %rdi, %rax
    ret

    .globl alternating_sum
    .type alternating_sum, @function
alternating_sum:
    # TODO: Problem 4
    movq $1, %rsi # i
    movq $0, %rdx # flag
    movq $0, %rax # total starts at 0
    loop:    
        cmpq %rdi, %rsi
        jg return
        cmpq $0, %rdx # previous was a positive
        je add_loop # if not then subtract
        
        subq %rsi, %rax
        addq $1, %rsi
        movq $0, %rdx
        jmp loop

        add_loop:
            addq %rsi, %rax
            addq $1, %rsi
            movq $1, %rdx
            jmp loop
    return:
        ret

    .globl recursive_power
    .type recursive_power, @function
recursive_power:
    # TODO: Problem 5
    cmpq $0, %rsi
    je base_case
    
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp
    movq %rdi, -8(%rbp)
    subq $1, %rsi

    call recursive_power
    
    imulq -8(%rbp), %rax

    leave
    ret

    base_case:
        movq $1, %rax
        ret

    .globl combine_helpers
    .type combine_helpers, @function
combine_helpers:
    # TODO: Problem 6
    pushq %rbp
    movq  %rsp, %rbp
    subq  $16, %rsp 
    movq %rsi, -8(%rbp) # save y
    call helper_square

    movq  %rax, -16(%rbp) # save helper square answer
    movq -8(%rbp), %rdi

    call helper_affine

    addq -16(%rbp), %rax

    leave
    ret

    .section .note.GNU-stack,"",@progbits
