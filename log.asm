; Logging module for Router Health Monitor
; NASM syntax version

; External shared data from data.asm
extern log_file_handle

global log_event
global print_string

section .data
    ; Log file name if we're logging to file
    log_file_name db 'router.log', 0
    
    ; Messages for logging (could also be in main.asm)
    gateway_down_msg db 'Gateway down!$'
    wifi_change_msg db 'Wi-Fi channel changed!$'
    signal_drop_msg db 'Signal strength dropped!$'
    spike_msg db 'Spike detected!$'

section .text
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
    
    push ax
    push dx
    
    mov ah, 02h
    mov dl, 07h  ; Bell character
    int 21h
    
    pop dx
    pop ax
    
    ret

; Print string procedure (could be moved to a UI module)
print_string:
    ; Print string pointed to by DS:DX until '$'
    mov ah, 09h
    int 21h
    ret