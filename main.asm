; Main program for Router Health Monitor
; NASM syntax version
; Entry point and main monitoring loop

extern init_monitor
extern delay_seconds
extern check_gateway
extern check_wifi_channel
extern check_signal_strength
extern log_event
extern print_string

; External shared data from data.asm
extern last_gateway_state
extern last_wifi_channel
extern last_signal_level
extern spike_counter
extern log_file_handle
extern delay_seconds

; Messages (could also be in data.asm, but keeping here for now)
section .data
    gateway_down_msg    db 'Gateway down!', 13, 10, '$'
    wifi_change_msg     db 'Wi-Fi channel changed!', 13, 10, '$'
    signal_drop_msg     db 'Signal strength dropped!', 13, 10, '$'
    spike_msg           db 'Spike detected!', 13, 10, '$'

global main
main:
    mov ax, @data
    mov ds, ax

    call init_monitor

main_loop:
    ; Delay for configured seconds
    mov ax, [delay_seconds]  ; If delay is in data.asm
    call delay_seconds

    ; Check default gateway
    call check_gateway
    cmp al, 0
    je gateway_down

    ; Check Wi-Fi channel
    call check_wifi_channel

    ; Check signal strength
    call check_signal_strength

    jmp main_loop

gateway_down:
    ; Warn about gateway down
    mov dx, gateway_down_msg
    call print_string
    call log_event
    jmp main_loop

; Note: In a real NASM Windows program, we'd need a proper entry point
; and would need to call ExitProcess to terminate properly