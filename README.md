# 🧠 4-Bit ALU: The Core of Computation

[![Language: Verilog](https://img.shields.io/badge/HDL-Verilog-blue.svg)](https://github.com/Realm-Reaper/4BIT_ALU)
[![Simulation: Passed](https://img.shields.io/badge/Simulation-0%20Errors-brightgreen.svg)](https://github.com/Realm-Reaper/4BIT_ALU)
[![Design: Modular](https://img.shields.io/badge/Architecture-Modular-orange.svg)](https://github.com/Realm-Reaper/4BIT_ALU)

Welcome to the **4-Bit Arithmetic Logic Unit (ALU)** project! This repository contains a fully synthesizable, modular ALU written in Verilog. It is capable of performing core arithmetic and bitwise operations, routed through a centralized instruction multiplexer.

> *"In hardware design, we don't guess. We verify."*

This project doesn't just feature the RTL design; it includes an **exhaustive, automated testbench** that simulates over 1,200 distinct logic states to guarantee 100% functional accuracy.

---

## ✨ Key Features
* **Modular Architecture:** The top module instantiates dedicated sub-modules for each operation (`Addition_4bit`, `Subtraction_4bit`, etc.), preventing cross-contamination of logic and making the RTL clean and scalable.
* **Flag Support:** Dynamically routes the correct `Carry_out` or `Borrow` flags based on the selected arithmetic operation.
* **Exhaustive Auto-Verification:** The testbench doesn't just test edge cases; it tests **every case**. All 256 possible input combinations of `A` and `B` are simulated for every single opcode.
* **Zero-Latch Design:** Default cases and initializations are explicitly defined to prevent unintended latches during synthesis.

---

## 🕹️ Instruction Set Architecture (Opcodes)

The ALU uses a 3-bit `Opcode` to select the desired operation. 

| Opcode | Operation | Mathematical / Logical Representation | Output Flags |
| :---: | :--- | :--- | :--- |
| `000` | **Addition** | `Result = A + B` | Updates `Carry_out` |
| `001` | **Subtraction** | `Result = A - B` | Updates `Borrow` (on Carry pin) |
| `010` | **Bitwise AND** | `Result = A & B` | `0` |
| `011` | **Bitwise OR** | `Result = A \| B` | `0` |
| `100` | **Bitwise XOR** | `Result = A ^ B` | `0` |
| `Others`| **Default** | `Result = 4'b0000` | `0` |

---

## 🏗️ Hardware Architecture 

```mermaid
graph LR
    A[A: 4-bit] --> ADD[+]
    A --> SUB[-]
    A --> AND[&]
    A --> OR[|]
    A --> XOR[^]

    B[B: 4-bit] --> ADD
    B --> SUB
    B --> AND
    B --> OR
    B --> XOR

    ADD -->|result_add & carry| MUX{MUX}
    SUB -->|result_sub & borrow| MUX
    AND -->|result_and| MUX
    OR  -->|result_or| MUX
    XOR -->|result_xor| MUX

    OP[Opcode: 3-bit] --> MUX

    MUX --> RES[Result]
    MUX --> CARRY[Carry_out]
# Compile the top module, sub-modules, and testbench
iverilog -o alu_sim TopModule.v tb_TopModule.v
```
🚀 Getting Started
Prerequisites
To simulate this design, you need an HDL simulator such as:

Icarus Verilog (Open Source)

Xilinx Vivado

ModelSim

Installation & Simulation
Clone this repository to your local machine: git clone [https://github.com/Realm-Reaper/4BIT_ALU.git](https://github.com/Realm-Reaper/4BIT_ALU.git)
   cd 4BIT_ALU
If you are using Icarus Verilog, compile the design files alongside the testbench: iverilog -o alu_sim TopModule.v tb_TopModule.v

Execute the simulation: vvp alu_sim
🧪 The Testbench: 1,280 Simulations
The included tb_TopModule.v is built for absolute reliability. Instead of manually inspecting waveforms, the testbench uses automated Verilog math checking.

How it works:

It loops through opcodes 000 to 100.

For each opcode, nested for loops iterate A from 0 to 15, and B from 0 to 15.

The RTL output is compared against standard Verilog operators (+, -, ^, &, |).

If a mismatch is detected, it logs an error with the exact inputs and expected vs. actual outputs.

Expected Console Output:
===============================================
--- Starting Exhaustive ALU Testbench ---
===============================================
Testing Addition (All 256 states)...
Testing Subtraction (All 256 states)...
Testing Bitwise XOR (All 256 states)...
Testing Bitwise AND (All 256 states)...
Testing Bitwise OR (All 256 states)...
===============================================
SUCCESS: TopModule passed all combinations with 0 errors!
===============================================



# Execute the simulation
vvp alu_sim
