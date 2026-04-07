; Delay module for Router Health Monitor

.MODEL SMALL
.STACK 100H

.PUBLIC DelaySeconds

.DATA
; We could put timer frequency here if using PIT
TimerFreq EQU 18.2  ; BIOS timer ticks per second (approximately)

.CODE
DelaySeconds PROC
    ; Delay for AX seconds
    ; Simple implementation using BIOS timer interrupt (INT 1Ah)
    ; For a more accurate delay, we'd program the PIT, but this is simpler
    
    PUSH BX
    PUSH CX
    PUSH DX
    
    ; Convert seconds to timer ticks (approximately)
    ; AX seconds * 18.2 ticks/second
    MOV BX, AX          ; Save seconds in BX
    MOV AX, 182         ; 18.2 * 10
    MUL BX              ; DX:AX = AX * BX
    MOV CX, 10
    DIV CX              ; AX = (AX * 182) / 10 = AX * 18.2
                        ; Now AX contains approximate tick count
    
    ; Wait for AX timer ticks
    MOV CX, AX          ; CX = tick count to wait
    
WaitLoop:
    ; Get current timer count
    MOV AH, 00h
    INT 1Ah             ; Returns CX:DX = clock count since midnight
                        ; We only care about CX changing
    
    PUSH CX             ; Save current high count
    
    ; Wait until timer tick changes
WaitForTick:
    MOV AH, 00h
    INT 1Ah
    POP BX              ; BX = previous high count
    CMP CX, BX
    JE WaitForTick      ; If same, wait for next tick
    
    PUSH CX             ; Save current high count for next comparison
    LOOP WaitLoop       ; Decrement CX and loop if not zero
    
    POP DX
    POP CX
    POP BX
    
    RET
DelaySeconds ENDP
END