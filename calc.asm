; rax = Values are returned from functions in this register.  
; rdi = Scratch register and function argument #1 in 64-bit Linux.
; rdx = Scratch register.
section .bss ; variables
    num resq 1 ; Reserve 8 bytes (quadword) for number

section .data ; constants
    usage: db "Usage: ./calc number1 number2", 10, 0
    usage_len equ $ - usage  

section .text
global _start

_start:
    ; Check if we have exactly 2 arguments
    pop rdi             ; Get argc (first value on stack)
    cmp rdi, 3          ; Compare with 2 (program name + 2 arguments)
    jne error           ; Jump if not equal
    ; End program sucessfully
    mov rax, 60  ; sys_exit
    mov rdi, 0   ; error code 0 (success)
    syscall

error:
    ; Print error message and exit
    mov rax, 1          ; sys_write
    mov rdi, 1          ; stdout
    mov rsi, usage      ; message
    mov rdx, usage_len  ; length
    syscall
    ; End program unsucessfully
    mov rax, 60         ; sys_exit
    mov rdi, 1          ; error code 1 (failure)
    syscall