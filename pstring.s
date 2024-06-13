.extern printf
.extern scanf
.section .rodata
.section .text
.globl pstrlen
pstrlen:
pushq %rbp
movq %rsp, %rbp
movq 0x10(%rbp), %rdi
movb (%rdi), %al
movq %rbp, %rsp
popq %rbp
ret
