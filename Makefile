# Makefile for Router Health Monitor
# Requires MASM and Link

ASM = ml
ASMFLAGS = /c /coff
LINK = link
LINKFLAGS = /SUBSYSTEM:CONSOLE /OUT:router_monitor.exe

OBJS = main.obj data.obj init.obj delay.obj gateway.obj wifi.obj signal.obj log.obj

all: $(OBJS)
	$(LINK) $(LINKFLAGS) $(OBJS)

%.obj: %.asm
	$(ASM) $(ASMFLAGS) $<

clean:
	del *.obj router_monitor.exe