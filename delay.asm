; Delay module for Router Health Monitor
; NASM syntax version for Windows 64-bit

extern ExitProcess
extern Sleep

global do_delay

section .text
do_delay:
    ; Delay for AX seconds
    ; Using Windows Sleep function (milliseconds)
    ; Input: AX = seconds to delay
    
    ; Zero-extend AX to 64-bit for the Sleep function parameter
    movzx rax, ax        ; RAX = seconds (zero-extended)
    imul rax, rax, 1000  ; Convert seconds to milliseconds
    
    ; Call Sleep(milliseconds)
    ; For Win64, first 4 integer parameters are in RCX, RDX, R8, R9
    mov rcx, rax         ; First parameter: milliseconds
    call Sleep
    
    ret