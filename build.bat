@echo off
echo Building Router Health Monitor...

rem Assemble all modules
ml /c /coff main.asm
ml /c /coff data.asm
ml /c /coff init.asm
ml /c /coff delay.asm
ml /c /coff gateway.asm
ml /c /coff wifi.asm
ml /c /coff signal.asm
ml /c /coff log.asm

rem Link all object files
link main.obj data.obj init.obj delay.obj gateway.obj wifi.obj signal.obj log.obj /SUBSYSTEM:CONSOLE /OUT:router_monitor.exe

echo Build complete.