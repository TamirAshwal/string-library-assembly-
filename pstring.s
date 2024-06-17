.extern printf
.extern scanf
.section .rodata
length_message:  
    .string "length: %d, "
.section .text
.type  pstrlen, @function
.globl pstrlen
pstrlen:
pushq %rbp
movq %rsp, %rbp
movq 0x10(%rbp), %rdi
movzbl (%rdi), %eax
movq %rbp, %rsp
popq %rbp
ret
.type  swapCase, @function
.globl swapCase
swapCase:
pushq %rbp
movq %rsp, %rbp
movq 0x10(%rbp), %rsi # get the length of the string
xorq %rax, %rax
movq $length_message, %rdi
call printf
movq 0x10(%rbp), %rcx # the length of the string is in rcx
movq 0x18(%rbp), %rsi # get the string
leaq 1(%rsi), %rsi # go the the beginning of the string
movq %rsi, %rdi
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
