@echo off
echo Building Router Health Monitor with NASM...

rem Check if NASM is available
nasm -v >nul 2>&1
if errorlevel 1 (
    echo Error: NASM not found. Please install NASM and add it to your PATH.
    exit /b 1
)

rem Assemble all modules
echo Assembling modules...
nasm -f win64 main.asm -o main.obj
nasm -f win64 data.asm -o data.obj
nasm -f win64 init.asm -o init.obj
nasm -f win64 delay.asm -o delay.obj
nasm -f win64 gateway.asm -o gateway.obj
nasm -f win64 wifi.asm -o wifi.obj
nasm -f win64 signal.asm -o signal.obj
nasm -f win64 log.asm -o log.obj

rem Link all object files
rem Using ld from MinGW-w64 (adjust path if needed)
echo Linking...
ld -e main -o router_monitor.exe main.obj data.obj init.obj delay.obj gateway.obj wifi.obj signal.obj log.obj kernel32.lib

if exist router_monitor.exe (
    echo Build complete: router_monitor.exe
) else (
    echo Build failed.
    exit /b 1
)