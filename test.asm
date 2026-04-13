; Simple test program for Windows 64-bit
extern ExitProcess
extern __imp__MessageBoxA

section .data
    caption db 'Test', 0
    text    db 'Hello World!', 0

section .text
    global main
main:
    ; Win64 calling convention: RCX, RDX, R8, R9 for first 4 integer/ptr args
    sub rsp, 28h          ; Shadow space
    
    mov rcx, 0            ; hWnd = NULL
    lea rdx, [rel text]   ; LPCTSTR lpText
    lea r8, [rel caption] ; LPCTSTR lpCaption
    mov r9d, 0            ; UINT uType = MB_OK
    call [__imp__MessageBoxA]
    
    mov ecx, 0            ; UINT uExitCode = 0
    call ExitProcess
    add rsp, 28h          ; Clean up stack