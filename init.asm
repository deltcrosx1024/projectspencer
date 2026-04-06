; Initialization module for Router Health Monitor

.MODEL SMALL
.STACK 100H

; Extern shared data
.EXTERN LastGatewayState:BYTE
.EXTERN LastWifiChannel:BYTE
.EXTERN LastSignalLevel:BYTE
.EXTERN SpikeCounter:WORD
.EXTERN LogFileHandle:WORD
.EXTERN DelaySecondsVal:WORD

.PUBLIC InitMonitor

.DATA
; Initialization messages if needed

.CODE
InitMonitor PROC
    ; Initialize: get initial gateway state, Wi-Fi channel, signal strength
    ; Open log file if needed
    
    ; For now, just initialize to default values
    ; In a real implementation, we would:
    ; 1. Get initial gateway state via network call
    ; 2. Get initial Wi-Fi channel 
    ; 3. Get initial signal strength
    ; 4. Open/create log file
    
    ; Stub implementation - set defaults
    MOV AL, 1
    MOV [LastGatewayState], AL
    
    MOV AL, 6   ; Default Wi-Fi channel
    MOV [LastWifiChannel], AL
    
    MOV AL, 80  ; Default signal strength
    MOV [LastSignalLevel], AL
    
    MOV AX, 0
    MOV [SpikeCounter], AX
    
    MOV AX, 0
    MOV [LogFileHandle], AX  ; 0 = no file open
    
    MOV AX, 5
    MOV [DelaySecondsVal], AX
    
    RET
InitMonitor ENDP
END