; Logging module for Router Health Monitor

.MODEL SMALL
.STACK 100H

; Extern shared data
.EXTERN LogFileHandle:WORD

.PUBLIC LogEvent
.PUBLIC PrintString  ; Though this might be better in a separate UI module

.DATA
; Log file name if we're logging to file
LogFileName DB 'router.log', 0

; Messages for logging (could also be in main.asm)
GatewayDownMsg DB 'Gateway down!$'
WifiChangeMsg DB 'Wi-Fi channel changed!$'
SignalDropMsg DB 'Signal strength dropped!$'
SpikeMsg DB 'Spike detected!$'

.CODE
LogEvent PROC
    ; Log the current event to a file or screen
    ; In this simple implementation, we'll just print to screen
    ; In a more complex version, we might write to a file
    
    ; For now, we'll just indicate that logging happened
    ; In a real implementation, we would:
    ; 1. Determine what type of event occurred (would need to be passed in)
    ; 2. Format a timestamp (would need to get current time)
    ; 3. Write to log file or display on screen
    
    PUSH AX
    PUSH DX
    
    ; Simple implementation: just beep to indicate an event
    ; In reality, we'd want to log what specifically happened
    
    MOV AH, 02h
    MOV DL, 07h  ; Bell character
    INT 21h
    
    POP DX
    POP AX
    
    RET
LogEvent ENDP

; Print string procedure (could be moved to a UI module)
PrintString PROC
    ; Print string pointed to by DS:DX until '$'
    MOV AH, 09h
    INT 21h
    RET
PrintString ENDP
END