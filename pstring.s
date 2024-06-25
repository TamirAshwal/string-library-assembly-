.extern printf
.extern scanf
.section .rodata
length_message:  
    .string "length: %d, "
invalid_input_message:
    .string "invalid input!\nlength: %d, string: %s\nlength: %d, string: %s\n"
print_new_string:
    .string "length: %d, string: %s\nlength: %d, string: %s\n"

.section .text
.type  pstrlen, @function
.globl pstrlen
pstrlen:
pushq %rbp
movq %rsp, %rbp
movzbl (%rdi), %eax # move the length to %eax
movq %rbp, %rsp
popq %rbp
ret
.type  swapCase, @function
.globl swapCase
swapCase:
pushq %rbp
movq %rsp, %rbp
movq %rdi, %r14 # save the address of the string
xorq %rax, %rax
call pstrlen # call pstrlen to get the length of the string
movq %rax, %rsi # move the length to rsi to print it
movq %rax, %r12 # move the length to r12 save the length 
xorq %rax, %rax
movq $length_message, %rdi
call printf # print the legnth 
movq %r14, %rsi # move the address of the string to rdi
movq %r12, %rcx # move the length to rcx to use it in the loop
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
jmp .end
.type  pstrijcpy, @function
.globl pstrijcpy
pstrijcpy:
pushq %rbp
movq %rsp, %rbp
xorq %rax, %rax
pushq %rsi # push the adress of the second string
pushq %rdi # push the adress of the first string
movzbl (%rdi), %r12d # save the length of the first pstring in r12
movzbl (%rsi), %r13d # save the length of the second pstring in r13
leaq 1(%rdi), %rdi # go to the first string
leaq 1(%rsi), %rsi # go to the second string
cmpq %r12, %rcx # if the index is bigger than the length go to invalid input
ja .invalid_input
cmpq %r13, %rcx # if the index is bigger than the length go to invalid input
ja .invalid_input
leaq (%rdi, %rdx), %rdi # add the index to the adress to go to the letter 
leaq (%rsi, %rdx), %rsi
cmpq %rdx, %rcx # if the second index is bigger than the first index invalid input
jb .invalid_input
.loop_copy:
cmpq %rdx, %rcx # compare the first index with the second index if the first is bigger that we finished copying
jb .new_string
movb (%rsi), %al # get the character from the second pstring
movb %al, (%rdi) # put the character in the first pstring
incq %rdx # increas the index 
incq %rdi # go to the next letter
incq %rsi # go to the next letter
jmp .loop_copy
.new_string:
movq $print_new_string, %rdi # print the new string
movl %r12d, %esi # move the length of the first pstring
movl %r13d, %ecx # move the length of the second pstring
popq %rdx 
popq %r8
leaq 1(%rdx), %rdx #go to the string of the first pstring
leaq 1(%r8), %r8 #go to the string of the second pstring
call printf
jmp .end


.invalid_input:
movq $invalid_input_message, %rdi # print the invalid input message
movl %r12d, %esi # move the length of the first pstring
movl %r13d, %ecx # move the length of the second pstring
popq %rdx
popq %r8
leaq 1(%rdx), %rdx #get the string of the first pstring
leaq 1(%r8), %r8 #get the string of the second pstring
xorq %rax, %rax
call printf
jmp .end

.end:
movq %rdi, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
