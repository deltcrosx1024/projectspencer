# Router Health Monitor / Watchdog
A text-mode tool for monitoring router health in 8086 assembly.

## Overview
This modular assembly program monitors router health by periodically checking:
- Default gateway responsiveness
- Wi-Fi channel changes
- Signal strength drops

When issues are detected, it logs events and provides warnings.

## File Structure
- `main.asm` - Main program loop and entry point
- `data.asm` - Shared data variables
- `init.asm` - Initialization procedures
- `delay.asm` - Timing/delay functions
- `gateway.asm` - Gateway responsiveness checking
- `wifi.asm` - Wi-Fi channel change detection
- `signal.asm` - Signal strength monitoring
- `log.asm` - Event logging and output functions
- `build.bat` - Build script
- `README.md` - This file

## Building
Requires MASM (ml.exe) and linker.

Run:
```
build.bat
```

This will produce `router_monitor.exe`.

## Implementation Notes
The network-specific functions currently contain stub implementations that simulate behavior. For a real implementation, you would need to replace these with actual networking code using:
- Packet drivers (like Crynwr packet driver) for DOS
- Windows networking APIs (though complex in pure assembly)
- Or interface with higher-level tools that can provide this information

The modular design separates concerns making it easier to replace individual components as needed.