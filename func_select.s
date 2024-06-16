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
    .string "case: invalid input \n"
default_print:
    .string "default"
pstrlen_message:
    .string "first pstring length: %d, second pstring length: %d\n"
swapcase_message:
    .string "length: %d, string: %s\n"
check_message:
    .string "length: %d\n"

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
        subq $8, %rsp #align the stack becuse we only push 1 value to the stack
        pushq %rsi # push the first pstring to the stack
        xorq %rax, %rax
        call pstrlen #call pstrlen
        movq %rax, %rsi
        subq $8, %rsp #align the stack becuse we only push 1 value to the stack
        pushq %rdx # push the second pstring to the stack
        xorq %rax, %rax
        call pstrlen #call pstrlen
        movq %rax, %rdx
        movq $pstrlen_message, %rdi #print the message
        call printf
        jmp .done #exit the function
    .case_32:
        jmp .invalid_input
    .case_33:
        subq $8, %rsp #align the stack becuse we only push 1 value to the stack
        pushq %rsi # push the first pstring to the stack
        movq %rdx, %r9 #save the second pstring in r9
        xorq %rax, %rax
        call pstrlen #call pstrlen
        movq %rax, %r8
        pushq %rsi
        pushq %rax #push the length of the string to the stack
        xorq %rax, %rax
        call swapCase
        movq $swapcase_message, %rdi
        movq %rax, %rdx
        movq %r8, %rsi
        call printf

        movq %r9, %rsi

        pushq %rsi
        xorq %rax, %rax
        call pstrlen
        movq %rax, %rsi # r8 has the length of the second string the string in rdx
        pushq %rsi
        pushq %rax
        xorq %rax, %rax
        call swapCase
        movq %rax, %rdx
        movq $swapcase_message, %rdi
        movq %r8, %rsi
        xorq %rax, %rax
        call printf
        jmp .done
    .case_34:
        movq $case_34_print, %rdi
        xorq %rax, %rax
        call printf
        jmp .done
    .done:
    movq %rbp, %rsp
    popq %rbp
    ret
