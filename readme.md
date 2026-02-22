# 1101 Sequence Detector & Timer

This module implements a programmable timer triggered by a serial bitstream.

## Features
- **Pattern Matcher**: Detects the sequence `1101` on the `data` line.
- **Programmable Delay**: Shifts in 4 bits (MSB first) to set the duration.
- **Precision Timing**: Counts for $(delay + 1) \times 1000$ clock cycles.
- **Handshake**: Asserts `done` until an `ack` signal is received.

## State Machine
1. **IDLE/Search**: Looking for `1101`.
2. **Shift**: Capturing 4 bits of delay data.
3. **Count**: Decrementing `count` every 1000 cycles.
4. **Done**: Waiting for `ack` to reset.
