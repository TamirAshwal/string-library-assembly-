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
    .string "string: %s\n"
case_34_user_format:
    .string " %c %c"
case_34_check:
    .string "this is the first char: %c, the second character is: %c \n"
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
        movq %rdx, %r13 # save the second pstring
        subq $8, %rsp #align the stack becuse we only push 1 value to the stack
        pushq %rsi # push the first pstring to the stack
        xorq %rax, %rax
        call pstrlen
        pushq %rsi # push the first pstring to the stack
        pushq %rax # push the length of the first pstring to the stack
        xorq %rax, %rax
        call swapCase #call swapCase
        movq %rax, %rsi # move the new string to rsi
        movq $swapcase_message, %rdi
        xorq %rax, %rax
        call printf #print the new string
        movq %r13, %rsi # move the second pstring to rsi
        subq $8, %rsp #align the stack becuse we only push 1 value to the stack
        pushq %rsi
        xorq %rax, %rax 
        xorq %rdi, %rdi 
        xorq %rdx, %rdx
        call pstrlen
        pushq %rsi # push the second pstring to the stack
        pushq %rax # push the length of the second pstring to the stack
        xorq %rax, %rax
        call swapCase #call swapCase
        movq %rax, %rsi # move the new string to rsi
        movq $swapcase_message, %rdi #print the new string
        xorq %rax, %rax 
        call printf #print the new string
        jmp .done #exit the function
    .case_34:
        subq    $16, %rsp
        movq %rsi, %r12
        movq %rdx, %r13
        leaq    -1(%rbp), %rsi
        leaq    -2(%rbp), %rdx
        movl    $case_34_user_format, %edi
        xorq    %rax, %rax
        call    scanf
        movzbl  -1(%rbp), %eax
        movsbl  %al, %eax
        movl    %eax, %esi # the first char
        movzbl  -2(%rbp), %eax
        movsbl  %al, %eax 
        movl    %eax, %edx # the second char
        movl %edx, %ecx;
        movl %esi, %edx;
        movq %r12, %rdi
        movq %r13, %rsi
        pushq $8
        call pstrijcpy
        jmp .done
    .done:
    movq %rbp, %rsp
    popq %rbp
    ret
