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
        subq $16, %rsp #allocate space for the two chars
        movq %rsi, %r12 #save the first pstring
        movq %rdx, %r13 #save the second pstring
        leaq -8(%rbp), %rsi #put the adress in the stack in rsi
        leaq -16(%rbp), %rdx #put the adress in the stack in rdx
        movl $case_34_user_format, %edi # move user input format to call scanf
        xorq %rax, %rax
        call scanf
        xorq %rsi, %rsi
        xorq %rdx, %rdx
        movzbl -8(%rbp), %esi #move the first index ro esi
        movzbl -16(%rbp), %edx #move the second index to edx
    
        movb %sil, %al #move the first index in size of char to al
        movb %dl, %Cl #move the second index in size of char to cl
        movzbl %al, %esi #move the first index in size of char to esi so esi conatin 1 char
        movzbl %cl, %edx #move the second index in size of char to edx so edx conatin 1 char
        movl %edx, %ecx #move the second index to ecx 
        movl %esi, %edx #move the first index to edx
        movq %r12, %rdi #move the first pstring to rdi
        movq %r13, %rsi #move the second pstring to rsi
        call pstrijcpy #call pstrijcpy
        jmp .done
    .done:
    movq %rbp, %rsp
    popq %rbp
    ret
