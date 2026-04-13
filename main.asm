; Main program for Router Health Monitor
; NASM syntax version for 64-bit Windows
; Entry point and main monitoring loop

extern init_monitor
extern delay_seconds
extern check_gateway
extern check_wifi_channel
extern check_signal_strength
extern log_event
extern print_string
extern ExitProcess

; External shared data from data.asm
extern last_gateway_state:data
extern last_wifi_channel:data
extern last_signal_level:data
extern spike_counter:data
extern log_file_handle:data
extern delay_seconds:data
extern msg_gateway_down:data
extern msg_wifi_change:data
extern msg_signal_drop:data
extern msg_spike:data

global main
main:
    sub rsp, 28h          ; Shadow space for Windows x64 calling convention
    call init_monitor
    add rsp, 28h

main_loop:
    ; Delay for configured seconds
    mov eax, [delay_seconds wrt ..]  ; If delay is in data.asm
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
    lea rcx, [msg_gateway_down wrt ..]  ; Using message from data.asm
    call print_string
    call log_event
    jmp main_loop

    ; Note: In a real application, we'd have a way to exit the loop
    ; For now, we'll just return (though this creates an infinite loop)
    ; A proper implementation would check for a termination condition

    ; Exit the program
    mov ecx, 0           ; Exit code
    call ExitProcess