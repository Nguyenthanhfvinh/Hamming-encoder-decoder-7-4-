# Hamming (7,4) Encoder and Decoder

This project implements a Hamming (7,4) encoder and decoder using Verilog HDL.

## Overview

Hamming (7,4) code is an error-correcting code that converts 4-bit input data
into a 7-bit encoded word.

The encoded data contains:

- 4 data bits
- 3 parity bits

The decoder can detect and correct one-bit errors in the received data.

## Features

- Hamming (7,4) encoding
- Single-bit error detection
- Single-bit error correction
- Original 4-bit data recovery
- Verilog HDL implementation
- Simulation using Xilinx Vivado

## Hamming Code Structure

The seven encoded bits are arranged as:

| Position | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
|----------|---|---|---|---|---|---|---|
| Bit type | P1 | P2 | D1 | P4 | D2 | D3 | D4 |

Where:

- `P1`, `P2`, and `P4` are parity bits.
- `D1`, `D2`, `D3`, and `D4` are data bits.

## Project Structure

```text
Hamming_encoder_decoder.srcs/
├── sources_1/       # Verilog design source files
└── sim_1/           # Testbench and simulation files
