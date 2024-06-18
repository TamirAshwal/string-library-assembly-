.extern printf
.extern scanf
.section .rodata
length_message:  
    .string "length: %d, "
case_34_check:
    .string "in the func this is the first char: %c, the second character is: %c \n"
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
    cmpq $0, %rcx # compare rcx which has the length of the string with 0 
    je .end # is rcx is 0 we finished going through the string
    movb (%rsi), %al # get the character
    cmpb $65, %al # compare the character with 65
    jb .next_letter # if the character is less than 65 we go to the next letter
    cmpb $122, %al # compare the character with 122
    ja .next_letter # if the character is greater than 122 we go to the next letter
    cmpb $90, %al # compare the character with 90
    jbe .upper_to_lower # if the character is less than or equal to 90 it's is capital letter so go to upper to lower
    cmpb $97, %al # compare the character with 97
    jae .lower_t0_upper # if the character is greater than or equal to 97 it's is small letter so go to lower to upper
    jmp .next_letter # if the character is not a letter go to the next letter
    .upper_to_lower:
        addb $32, %al # add 32 to convert the upper case to lower case
        movb %al, (%rsi) # put the charcter in the string
        jmp .next_letter # go to the next letter
    .lower_t0_upper:
        subb $32, %al  # subtract 32 to convert the lower case to upper case
        movb %al, (%rsi) # put the charcter in the string
        jmp .next_letter # go to the next letter
    .next_letter:
        incq %rsi # go to the next letter
        decq %rcx # decrease the length of the string
        jmp .loop # go to the next letter

#movzbl (%rdi), %ecx
#leaq 1(%rsi), %rsi # go the the beginning of the string
#leaq 1(%rsi), %rax
#movb (%rsi), %al
#subb $32, %al

.type  pstrijcpy, @function
.globl pstrijcpy
pstrijcpy:
movl $case_34_check, %edi
movl %edx, %esi
movl %ecx, %edx
xorq %rax, %rax
call printf
jmp .end

.end:
movq %rdi, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
