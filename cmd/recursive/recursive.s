.section .data

.section .text
.globl _start

_start:
    pushl $4
    call factorial

    // move the stack back up 4 bytes
    addl $4, %esp
    // move return value from eax to ebx
    movl %eax, %ebx
    movl $1, %eax
    int $0x80

factorial:
    // save base pointer
    pushl %ebp
    // make base pointer the same as the stack pointer
    movl %esp, %ebp

    // get argument
    movl 8(%ebp), %eax

    cmpl $1, %eax
    je end_factorial

    // decrement and recursively call factorial
    decl %eax
    pushl %eax
    call factorial

    // Move the original arg into ebx for multiplication
    movl 8(%ebp), %ebx
    imull %ebx, %eax

end_factorial:
    // restore the stack and base pointers to what they were before func call
    movl %ebp, %esp
    popl %ebp
    ret
