; Shared data variables for Router Health Monitor
; NASM syntax version

section .data
    ; Variables for monitoring
    last_gateway_state  db 0          ; 0 = not responding, 1 = responding
    last_wifi_channel   db 0          ; Last known Wi-Fi channel
    last_signal_level   db 0          ; Last known signal strength (0-100)
    spike_counter       dw 0          ; Counter for spikes
    log_file_handle     dw 0          ; Handle for log file (if implemented)
    delay_seconds       dw 5          ; Delay between checks in seconds

    ; Messages
    msg_gateway_down    db 'Gateway down!', 13, 10, '$'
    msg_wifi_change     db 'Wi-Fi channel changed!', 13, 10, '$'
    msg_signal_drop     db 'Signal strength dropped!', 13, 10, '$'
    msg_spike           db 'Spike detected!', 13, 10, '$'

    ; Make variables accessible to other modules (equivalent to .PUBLIC in MASM)
    global last_gateway_state
    global last_wifi_channel
    global last_signal_level
    global spike_counter
    global log_file_handle
    global delay_seconds
    global msg_gateway_down
    global msg_wifi_change
    global msg_signal_drop
    global msg_spike