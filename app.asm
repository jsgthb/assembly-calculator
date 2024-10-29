section .bss
    ; variables

section .data
    ; constants
    teststring: db "This is a test",0xa
    teststringlen: equ $-teststring

section .text
global _start

_start:
    mov rax,1   ; sys_write
    mov rdi,1   ; stdout
    mov rsi,teststring  ; message to write
    mov rdx,teststringlen  ; message length to write
    syscall

    ; end program
    mov rax,60  ; sys_exit
    mov rdi,0   ; error code 0 (success)
    syscall