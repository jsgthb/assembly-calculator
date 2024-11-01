; rax = Values are returned from functions in this register.  
; rdi = Scratch register and function argument #1 in 64-bit Linux.
; rdx = Scratch register.
; rsi = Typically used to move through arguments
section .bss ; variables
    num resq 1 ; Reserve 8 bytes (quadword) for number

section .data ; constants
    usage: db "Usage: ./calc number1 number2", 10, 0
    usage_len equ $ - usage  
    arg1_msg db "First number: ", 0
    arg1_msg_len equ $ - arg1_msg

section .text
global _start

_start:
    ; Check if we have exactly 2 arguments
    pop rdi             ; Get argc (first value on stack)
    cmp rdi, 3          ; Compare with 2 (program name + 2 arguments)
    jne error           ; Jump if not equal

    ; Skip program name
    pop rsi             ; Remove program name from stack

    ; Print "First number: "
    mov rax, 1          ; sys_write
    mov rdi, 1          ; stdout
    mov rsi, arg1_msg   ; message
    mov rdx, arg1_msg_len   ; length
    syscall

    ; Print first argument
    pop rsi
    call print_string

    ; End program sucessfully
    mov rax, 60  ; sys_exit
    mov rdi, 0   ; error code 0 (success)
    syscall

; Function to print null-terminated string
print_string:
    push rsi            ; Save string pointer
    mov rdx, 0          ; Counter for string length
count_loop:
    cmp byte [rsi], 0   ; Check for null terminator
    je print_it         ; If found, print string
    inc rsi             ; Move to next character
    inc rdx             ; Increment counter
    jmp count_loop
print_it:
    pop rsi             ; Restore string pointer
    mov rax, 1          ; sys_write
    mov rdi, 1          ; stdout
    syscall
    ret

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