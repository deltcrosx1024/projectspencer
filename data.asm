; Shared data variables for Router Health Monitor
; NASM syntax version for 64-bit Windows

section .data
    ; Variables for monitoring
    last_gateway_state  dd 0          ; 0 = not responding, 1 = responding
    last_wifi_channel   dd 0          ; Last known Wi-Fi channel
    last_signal_level   dd 0          ; Last known signal strength (0-100)
    spike_counter       dd 0          ; Counter for spikes
    log_file_handle     dd 0          ; Handle for log file (if implemented)
    delay_seconds       dd 5          ; Delay between checks in seconds

    ; Messages (null-terminated for Windows)
    msg_gateway_down    db 'Gateway down!', 13, 10, 0
    msg_wifi_change     db 'Wi-Fi channel changed!', 13, 10, 0
    msg_signal_drop     db 'Signal strength dropped!', 13, 10, 0
    msg_spike           db 'Spike detected!', 13, 10, 0

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