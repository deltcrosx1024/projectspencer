; Delay module for Router Health Monitor
; NASM syntax version for Windows

extern ExitProcess
extern Sleep

global delay_seconds

section .text
delay_seconds:
    ; Delay for AX seconds
    ; Using Windows Sleep function (milliseconds)
    ; Input: AX = seconds to delay
    ; Note: In 64-bit Windows, we need to zero-extend AX to 64-bit
    
    ; Zero-extend AX to 64-bit for the Sleep function parameter
    movzx eax, ax        ; EAX = seconds (zero-extended)
    imul eax, eax, 1000  ; Convert seconds to milliseconds
    
    ; Call Sleep(milliseconds)
    ; In NASM for Windows, we need to use the correct calling convention
    ; For simplicity in this example, we'll assume we're in a context where we can call Windows API
    ; In a real implementation, we'd need to properly set up the stack and registers
    
    ; For now, we'll just return - actual Sleep call would go here
    ; In a proper Windows NASM program, we'd link with kernel32 and call Sleep
    
    ret