.extern printf
.extern scanf
.section .rodata
check_in_func:  
    .string "length in the function is %d\n"
check_string_in_func:
    .string "string in the function is %s\n"
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
movq 0x10(%rbp), %rcx # the length of th string
addq $1, %rcx
movq 0x18(%rbp), %rsi # the begginning of the string
movq 0x18(%rbp), %rdi # the begginning of the string
.loop:
    cmpq $0, %rcx
    je .end
    movb (%rsi), %al
    cmpb $65, %al
    jb .next_letter
    cmpb $122, %al
    ja .next_letter
    cmpb $90, %al
    jbe .upper_to_lower
    cmpb $97, %al
    jae .lower_t0_upper
    jmp .next_letter
    .upper_to_lower:
        addb $32, %al
        movb %al, (%rsi)
        jmp .next_letter
    .lower_t0_upper:
        subb $32, %al
        movb %al, (%rsi)
        jmp .next_letter
    .next_letter:
        incq %rsi
        decq %rcx
        jmp .loop

#movzbl (%rdi), %ecx
#leaq 1(%rsi), %rsi # go the the beginning of the string
#leaq 1(%rsi), %rax
#movb (%rsi), %al
#subb $32, %al


    
.end:
movq %rdi, %rax
    movq %rbp, %rsp
    popq %rbp
    ret

