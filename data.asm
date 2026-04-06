; Shared data variables for Router Health Monitor

.MODEL SMALL
.STACK 100H

.PUBLIC LastGatewayState
.PUBLIC LastWifiChannel
.PUBLIC LastSignalLevel
.PUBLIC SpikeCounter
.PUBLIC LogFileHandle
.PUBLIC DelaySecondsVal

.DATA
LastGatewayState DB 0          ; 0 = not responding, 1 = responding
LastWifiChannel  DB 0          ; Last known Wi-Fi channel
LastSignalLevel  DB 0          ; Last known signal strength (0-100)
SpikeCounter     DW 0          ; Counter for spikes
LogFileHandle    DW 0          ; Handle for log file (if implemented)
DelaySecondsVal  DW 5          ; Delay between checks in seconds