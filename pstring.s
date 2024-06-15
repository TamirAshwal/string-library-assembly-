.extern printf
.extern scanf
.section .rodata
check_in_func:  
    .string "length in the function is %d\n"
.section .text
.type  pstrlen, @function
.globl pstrlen
pstrlen:
pushq %rbp
movq %rsp, %rbp
movq 0x10(%rbp), %rdi
movb (%rdi), %al
movq %rbp, %rsp
popq %rbp
ret
.type  swapCase, @function
.globl swapCase
swapCase:
pushq %rbp
movq %rsp, %rbp
movq 0x10(%rbp), %rdi
movzbl (%rdi), %ecx

leaq 1(%rsi), %rax # go the the beginning of the string 
.loop:
    cmpb $0, %ecx
    je .end
    cmpb $65, %al
    jnae .next_letter
    cmpb $123, %al
    jae .next_letter
    .check_1:
    cmpb $90, %al
    jle .upper_to_lower
    jmp .next_letter
    .upper_to_lower:
    addb $32, %al
    jmp .next_letter
    .lower_to_upper:
    subb $32, %al
    jmp .next_letter
    .next_letter:
    decb %cl
    addq $1, %rax
    jmp .loop
.end:
movq %rbp, %rsp
    popq %rbp
    ret

