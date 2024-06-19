.extern printf
.extern scanf
.extern pstrlen
.section .rodata
case_31_print:
    .string "in case 31 - pstrlen \n"
case_33_print:
    .string "in case 33 - swapcase "
case_34_print:
    .string "in case 34 - pstrijcpy "
case_invalid_input_print:
    .string "invalid option!\n"
default_print:
    .string "default"
pstrlen_message:
    .string "first pstring length: %d, second pstring length: %d\n"
length_message:  
    .string "length: %d, "
swapcase_message:
    .string "string: %s\n"
case_34_user_format:
    .string " %d %d"
case_34_check:
    .string "this is the first index: %d, this is the second %d\n"
.L4:
    .quad .case_31 # case 31 - pstrlen
    .quad .case_32 # invalid input 
    .quad .case_33 #case 33 - swapcase
    .quad .case_34 #case 34 - pstrijcpy
    .quad .invalid_input #case invalid input
    .quad .done 
.section .text
.globl run_func
run_func:
    pushq %rbp
    movq %rsp, %rbp
    leaq -31(%rdi), %rax
    cmpq $3, %rax
    ja .invalid_input
    jmp *.L4(,%rax,8)
    .invalid_input:
        movq $case_invalid_input_print, %rdi
        xorq %rax, %rax
        call printf
        jmp .done
    .case_31:
        movq %rsi, %rdi #move the first pstring to rdi
        xorq %rax, %rax
        call pstrlen #call pstrlen
        movq %rax, %rsi
        movq %rdx, %rdi #move the second pstring to rdi
        xorq %rax, %rax
        call pstrlen #call pstrlen
        movq %rax, %rdx
        xorq %rax, %rax
        movq $pstrlen_message, %rdi #print the message
        call printf
        jmp .done #exit the function
    .case_32:
        jmp .invalid_input
    .case_33:
        movq %rdx, %r13 # save the second pstring
        movq %rsi, %rdi # move the first pstring to rdi
        xorq %rax, %rax
        call swapCase
        movq %rax, %rsi
        movq $swapcase_message, %rdi
        xorq %rax, %rax
        call printf
        movq %r13, %rdi # move the second pstring to rdi
        xorq %rax, %rax
        call swapCase
        movq %rax, %rsi
        movq $swapcase_message, %rdi
        xorq %rax, %rax
        call printf
        jmp .done #exit the function
    .case_34:
        subq $16, %rsp
        movq %rsi, %r12
        movq %rdx, %r13
        leaq -8(%rbp), %rsi
        leaq -16(%rbp), %rdx
        movl $case_34_user_format, %edi
        xorq %rax, %rax
        call scanf
        movzbl -8(%rbp), %esi
        movzbl -16(%rbp), %edx
        movl %edx, %ecx
        movl %esi, %edx
        movq %r12, %rdi
        movq %r13, %rsi
        call pstrijcpy
        jmp .done
    .done:
    movq %rbp, %rsp
    popq %rbp
    ret
