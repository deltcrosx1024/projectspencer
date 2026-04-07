; Initialization module for Router Health Monitor
; NASM syntax version

; External shared data from data.asm
extern last_gateway_state
extern last_wifi_channel
extern last_signal_level
extern spike_counter
extern log_file_handle
extern delay_seconds

global init_monitor

section .text
init_monitor:
    ; Initialize: get initial gateway state, Wi-Fi channel, signal strength
    ; Open log file if needed
    
    ; For now, just initialize to default values
    ; In a real implementation, we would:
    ; 1. Get initial gateway state via network call
    ; 2. Get initial Wi-Fi channel 
    ; 3. Get initial signal strength
    ; 4. Open/create log file
    
    ; Stub implementation - set defaults
    mov al, 1
    mov [last_gateway_state], al
    
    mov al, 6   ; Default Wi-Fi channel
    mov [last_wifi_channel], al
    
    mov al, 80  ; Default signal strength
    mov [last_signal_level], al
    
    mov ax, 0
    mov [spike_counter], ax
    
    mov ax, 0
    mov [log_file_handle], ax  ; 0 = no file open
    
    mov ax, 5
    mov [delay_seconds], ax
    
    ret