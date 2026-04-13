; Logging module for Router Health Monitor
; NASM syntax version for 64-bit Windows

; External shared data from data.asm
extern log_file_handle

global log_event
global print_string
global init_logging

; Windows API imports - using __imp__ prefix for dllimport
extern __imp__GetStdHandle
extern __imp__WriteFile
extern __imp__ExitProcess

section .data
    ; Log file name if we're logging to file
    log_file_name db 'router.log', 0
    
    ; Messages for logging (could also be in main.asm)
    gateway_down_msg db 'Gateway down!', 13, 10, 0
    wifi_change_msg db 'Wi-Fi channel changed!', 13, 10, 0
    signal_drop_msg db 'Signal strength dropped!', 13, 10, 0
    spike_msg db 'Spike detected!', 13, 10, 0
    
    ; Standard handles
    std_handle dq -11  ; Default to STD_OUTPUT_HANDLE (64-bit)

section .text
init_logging:
    ; Initialize logging by getting standard output handle
    ; Win64: first parameter in RCX
    mov rcx, -11         ; STD_OUTPUT_HANDLE
    call [__imp__GetStdHandle]
    mov [std_handle], rax
    ret

log_event:
    ; Log the current event to a file or screen
    ; In this simple implementation, we'll just print to screen
    ; In a more complex version, we might write to a file
    
    ; For now, we'll just indicate that logging happened
    ; In a real implementation, we would:
    ; 1. Determine what type of event occurred (would need to be passed in)
    ; 2. Format a timestamp (would need to get current time)
    ; 3. Write to log file or display on screen
    
    ; Simple implementation: just beep to indicate an event
    ; In reality, we'd want to log what specifically happened
    
    ; Save registers that we'll use
    sub rsp, 28h         ; Shadow space + alignment
    
    ; For now, just call print_string with a generic message
    ; A better implementation would pass which event occurred
    lea rcx, [rel gateway_down_msg]  ; Using gateway message as example
    call print_string
    
    add rsp, 28h         ; Restore stack
    ret

; Print string procedure (null-terminated string)
print_string:
    ; Print null-terminated string pointed to by RCX
    ; Win64: first parameter in RCX
    sub rsp, 28h         ; Shadow space + alignment
    
    ; Calculate string length
    mov rax, rcx         ; RAX = string pointer
    mov rdx, 0           ; RDX = length counter
    
strlen_loop:
    mov al, [rax + rdx]  ; AL = byte at string[length]
    test al, al          ; Check for null terminator
    jz strlen_done       ; If zero, we're done
    inc rdx              ; Increment length counter
    jmp strlen_loop      ; Continue loop
    
strlen_done:
    ; RDX now has length (excluding null terminator)
    ; Call WriteFile(hBuffer, lpBuffer, nNumberOfBytesToWrite, lpNumberOfBytesWritten, lpOverlapped)
    ; Win64 params: RCX=hFile, RDX=lpBuffer, R8=nNumberOfBytesToWrite, R9=lpNumberOfBytesWritten, [stack]+20h=lpOverlapped
    
    mov rcx, [std_handle]    ; hFile
    mov rdx, rcx             ; lpBuffer (original string pointer)
    mov r8, rdx              ; nNumberOfBytesToWrite (length)
    lea r9, [rsp + 20h]      ; lpNumberOfBytesWritten (allocate space on stack)
    mov qword [rsp + 28h], 0 ; lpOverlapped = NULL
    
    call [__imp__WriteFile]
    
    add rsp, 28h         ; Restore stack
    ret