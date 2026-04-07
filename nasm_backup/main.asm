; Main program for Router Health Monitor
; Entry point and main monitoring loop

.MODEL SMALL
.STACK 100H

; Externals from other modules
EXTERN InitMonitor:NEAR
EXTERN DelaySeconds:NEAR
EXTERN CheckGateway:NEAR
EXTERN CheckWifiChannel:NEAR
EXTERN CheckSignalStrength:NEAR
EXTERN LogEvent:NEAR
EXTERN PrintString:NEAR

; Externals for data (if we put data in separate module)
; EXTERN LastGatewayState:BYTE
; EXTERN LastWifiChannel:BYTE
; EXTERN LastSignalLevel:BYTE
; EXTERN SpikeCounter:WORD
; EXTERN LogFileHandle:WORD
; EXTERN DelaySecondsVal:WORD

.DATA
; Local data or we could put shared data in data.asm
GatewayDownMsg DB 'Gateway down!$'
WifiChangeMsg DB 'Wi-Fi channel changed!$'
SignalDropMsg DB 'Signal strength dropped!$'
SpikeMsg DB 'Spike detected!$'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    CALL InitMonitor

MainLoop:
    ; Delay for configured seconds
    ; MOV AX, [DelaySecondsVal]  ; If delay is in data.asm
    MOV AX, 5                  ; Hardcoded delay for now
    CALL DelaySeconds

    ; Check default gateway
    CALL CheckGateway
    CMP AL, 0
    JE GatewayDown

    ; Check Wi-Fi channel
    CALL CheckWifiChannel

    ; Check signal strength
    CALL CheckSignalStrength

    JMP MainLoop

GatewayDown:
    ; Warn about gateway down
    LEA DX, GatewayDownMsg
    CALL PrintString
    CALL LogEvent
    JMP MainLoop

MAIN ENDP
END MAIN