# PRESENT Cipher --- FPGA Implementation

FPGA implementation of the **PRESENT lightweight block cipher** in
Verilog HDL, including:

-   4-bit iterative PRESENT architecture for area-efficient encryption
-   Modified key-dependent S-box architecture for enhanced security
    experimentation
-   Quartus Prime synthesis on **Intel MAX 10 / DE10-Lite**
-   ModelSim RTL simulation and verification
-   ISO/IEC PRESENT test-vector verification
-   Parallel 64-bit plaintext/key loading

## Project Overview

PRESENT is a lightweight Substitution-Permutation Network (SPN) cipher
with:

-   **Block size:** 64 bits
-   **Key size:** 80 bits
-   **Rounds:** 31 + final AddRoundKey
-   **S-box:** 16 × 4-bit substitution
-   **P-box:** `P(i) = 16 × i mod 63`, with `P(63) = 63`

This project implements two architectures:

### 1. 4-bit Iterative Architecture

Area-oriented implementation using a 3-state FSM:

`IDLE → ENC → DONE`

-   Parallel 64-bit plaintext/key loading
-   One encryption round per clock cycle
-   4-bit datapath/MUX structure
-   33 total cycles to encryption completion

### 2. Key-Dependent S-box Architecture

A modified architecture based on the project reference paper.

-   Uses 16 key-dependent S-boxes
-   S-box selection changes according to key-derived selector bits
-   Same plaintext and key can produce a different ciphertext from the
    standard fixed-S-box architecture
-   Implemented and verified in RTL simulation

## Hardware and Software

  Item             Details
  ---------------- ---------------------------------------------
  HDL              Verilog HDL
  FPGA Board       DE10-Lite
  FPGA Device      Intel MAX 10 --- 10M50DAF484C7G
  Synthesis Tool   Quartus Prime Lite 18.0
  Simulation       ModelSim-Altera 10.5b
  Reference        ICECA 2019 --- Amrita School of Engineering
  Standard         ISO/IEC PRESENT specification

## Repository Structure

``` text
PRESENT-FPGA/
│
├── README.md
│
├── rtl/
│   ├── sbox.v
│   ├── pbox.v
│   ├── key_transform.v
│   ├── present_4bit.v
│   ├── kd_sbox.v
│   └── present_kd.v
│
├── tb/
│   └── present_tb.v
│
├── quartus/
│   ├── <project>.qpf
│   ├── <project>.qsf
│   └── <other Quartus project files>
│
├── simulation/
│   ├── waveforms/
│   └── transcripts/
│
├── results/
│   ├── synthesis/
│   └── simulation/
│
├── docs/
│   ├── PRESENT_FPGA_Presentation.pptx
│   └── figures/
│
└── LICENSE
```

> Keep generated Quartus/ModelSim files in their own folders or exclude
> unnecessary generated files with `.gitignore`.

## Verilog Modules

### `sbox.v`

Standard PRESENT 4-bit S-box implementation.

### `pbox.v`

64-bit PRESENT permutation layer.

### `key_transform.v`

80-bit key schedule containing rotation, S-box transformation and
round-counter XOR.

### `present_4bit.v`

Top-level 4-bit iterative PRESENT encryption architecture.

### `kd_sbox.v`

Contains the 16 key-dependent S-boxes and selector logic.

### `present_kd.v`

Top-level modified key-dependent PRESENT architecture.

### `present_tb.v`

Testbench used to simulate both architectures and display encryption
results.

## Verification

The RTL simulation uses three test cases:

  Test                    4-bit Iterative      Key-Dependent
  ----------------------- -------------------- --------------------
  ISO/IEC Spec Vector 1   `5579c1387b228445`   `48047391ef1488ba`
  ISO/IEC Spec Vector 4   `3333dcd3213210d2`   `3a56ebfd108fac36`
  Paper Input Vector      `21eb3cf6625a7db3`   `778c58e88a14a806`

All three test cases were reported as **PASS** in the project
presentation.

The paper-input comparison should be interpreted using the project's
stated note: the paper's output used a Xilinx ISE bit-ordering
convention, while the implementation was checked against the ISO/IEC
reference for authoritative PRESENT verification.

## Synthesis Result

The reported Quartus compilation result for the 4-bit iterative
implementation was:

-   **Logic Elements:** 320
-   **Total Registers:** 218
-   **Total Pins:** 212
-   **Compile errors:** 0
-   **FPGA:** Intel MAX 10 10M50DAF484C7G

The presentation reports the design as using less than 1% of the
available logic elements.

## Latency

The implemented architecture uses:

-   Parallel plaintext/key loading
-   One round per clock cycle
-   **33 total encryption cycles**

The project presentation compares this with a 51-cycle implementation
from the reference paper.

## Simulation Signals

Important waveform signals include:

``` text
clk
start
plaintext
round_cnt
done
cipher_4bit
cipher_kd
```

`start` begins encryption, `round_cnt` tracks the encryption rounds, and
`done` indicates that the ciphertext is ready.

## How to Run

### Quartus Prime

1.  Open Quartus Prime Lite 18.0.
2.  Open the Quartus project file (`.qpf`).
3.  Check the target FPGA device: `10M50DAF484C7G`
4.  Add the RTL files from `rtl/`.
5.  Add the required top-level module.
6.  Run **Analysis & Synthesis** or **Full Compilation**.
7.  Review resource utilization and compilation messages.

### ModelSim

1.  Create/open the ModelSim project.
2.  Compile the RTL files.
3.  Compile `tb/present_tb.v`.
4.  Set the testbench as the simulation top.
5.  Start RTL simulation.
6.  Observe:
    -   encryption start
    -   round counter
    -   S-box selector
    -   `done`
    -   final ciphertext

Example command flow:

``` tcl
vlog rtl/*.v tb/present_tb.v
vsim work.present_tb
run -all
```

Adjust the commands if your simulator/project uses a different library
or top-level module name.

## Reference

The implementation is based on the PRESENT FPGA implementation work
referenced in the project presentation:

**ICECA 2019 --- Amrita School of Engineering**

The presentation also references the **ISO/IEC PRESENT specification**
for verification.

## Project Highlights

-   Verilog implementation of PRESENT
-   Area-oriented 4-bit iterative datapath
-   Key-dependent S-box architecture
-   Parallel input loading
-   Quartus synthesis on Intel MAX 10
-   ModelSim RTL verification
-   ISO/IEC test-vector verification
-   Round-by-round simulation visibility

## Author

Developed as an FPGA/VLSI implementation project at:

**SASTRA Deemed to be University**

------------------------------------------------------------------------

### Suggested GitHub repository description

> Verilog FPGA implementation of the PRESENT lightweight cipher with a
> 4-bit iterative architecture and key-dependent S-box architecture,
> verified using Quartus Prime and ModelSim on Intel MAX 10.

### Suggested topics

``` text
fpga
verilog
present-cipher
lightweight-cryptography
cryptography
vlsi
quartus
modelsim
intel-max10
de10-lite
hardware-security
rtl
```
