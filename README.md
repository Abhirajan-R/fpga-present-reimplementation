# FPGA Implementation of PRESENT Cipher with Improved Security

> Reimplementation of the IEEE ICECA 2019 paper **"FPGA Implementation of PRESENT Algorithm with Improved Security"** using Verilog HDL for FPGA-based lightweight cryptography.

## Project Overview

This project recreates and extends the hardware architecture presented in the IEEE ICECA 2019 paper for implementing the **PRESENT lightweight block cipher on FPGA**.

The design is implemented in **Verilog HDL**, verified through **ModelSim RTL simulation**, synthesized using **Quartus Prime Lite**, and targeted for the **Intel MAX 10 FPGA / DE10-Lite development board**.

Two architectures are implemented:

1. **4-bit Iterative PRESENT Architecture** — area-oriented implementation.
2. **Key-Dependent S-box Architecture** — modified architecture for improved security experimentation.

The project focuses on lightweight cryptographic hardware design, RTL implementation, verification, FPGA synthesis, and hardware-security concepts.

---

## Base Paper

**Title:** FPGA Implementation of PRESENT Algorithm with Improved Security

**Authors:** Vallish Kumar Reddy, Rao Surya, Akhil Reddy, P. Sathish Kumar

**Conference:** IEEE ICECA 2019

**Reference:** ICECA 2019 — Amrita School of Engineering

---

## Objectives

- Recreate the proposed FPGA architecture.
- Implement the PRESENT cipher in Verilog HDL.
- Implement an area-efficient 4-bit iterative architecture.
- Implement the modified key-dependent S-box architecture.
- Verify functionality through RTL simulation.
- Validate the implementation using PRESENT test vectors.
- Analyze FPGA resource utilization.
- Compare implementation characteristics with the reference paper.
- Study lightweight cryptographic hardware implementation.

---

## PRESENT Cipher

PRESENT is a lightweight **Substitution-Permutation Network (SPN)** block cipher.

| Parameter | Specification |
|---|---|
| Block Size | 64 bits |
| Key Size | 80 bits |
| Rounds | 31 + Final AddRoundKey |
| S-box | 16 × 4-bit |
| P-box | 64-bit permutation |
| Key Schedule | 80-bit |
| HDL | Verilog |

### Encryption Structure

```text
64-bit Plaintext
       │
       ▼
  AddRoundKey
       │
       ▼
   S-box Layer
       │
       ▼
   P-box Layer
       │
       ▼
    31 Rounds
       │
       ▼
 Final AddRoundKey
       │
       ▼
64-bit Ciphertext
```

### Key Schedule

```text
80-bit Key
    │
    ▼
61-bit Rotation
    │
    ▼
S-box Transformation
    │
    ▼
Round Counter XOR
    │
    ▼
Round Key
```

---

## Implemented Architectures

### 1. 4-bit Iterative Architecture

The first architecture is designed with an area-oriented approach.

**Features:**

- 4-bit iterative datapath
- Parallel 64-bit plaintext loading
- Parallel key loading
- One encryption round per clock cycle
- 3-state FSM:

```text
IDLE → ENC → DONE
```

- Standard PRESENT S-box
- 31 encryption rounds
- Final AddRoundKey
- Reported total latency: **33 cycles**

---

### 2. Key-Dependent S-box Architecture

The second architecture modifies the standard PRESENT design by introducing **key-dependent S-box selection**.

```text
16 Key-Dependent S-boxes
          │
          ▼
   Key-derived Selector
          │
          ▼
      Selected S-box
```

**Features:**

- 16 different S-boxes
- 4-bit S-box selector
- Key-dependent selection
- Modified PRESENT architecture
- Same plaintext/key can produce a different ciphertext from the standard fixed-S-box architecture

---

## Technologies Used

- **Verilog HDL**
- **Quartus Prime Lite 18.0**
- **ModelSim-Altera 10.5b**
- **Intel MAX 10 FPGA**
- **DE10-Lite Development Board**
- Digital Design
- FPGA Design
- Lightweight Cryptography
- RTL Simulation
- Hardware Security

### Target FPGA

```text
Intel MAX 10
10M50DAF484C7G
DE10-Lite
```

---

## Repository Structure

```text
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
├── testbench/
│   └── present_tb.v
│
├── simulation/
│   ├── waveforms/
│   └── transcripts/
│
├── synthesis/
│   ├── quartus/
│   └── reports/
│
├── results/
│   ├── simulation/
│   └── synthesis/
│
├── images/
│   ├── architecture/
│   ├── waveform/
│   └── fpga/
│
├── presentation/
│   └── PRESENT_FPGA_Presentation.pptx
│
└── LICENSE
```

---

## RTL Modules

| File | Description |
|---|---|
| `sbox.v` | Standard PRESENT 4-bit S-box |
| `pbox.v` | 64-bit PRESENT permutation |
| `key_transform.v` | 80-bit key schedule |
| `present_4bit.v` | 4-bit iterative top-level architecture |
| `kd_sbox.v` | Key-dependent S-box implementation |
| `present_kd.v` | Key-dependent top-level architecture |
| `present_tb.v` | Simulation testbench |

### S-box

```text
C 5 6 B 9 0 A D 3 E F 8 4 7 1 2
```

### P-box

```text
P(i) = 16 × i mod 63
P(63) = 63
```

---

## Verification

The implementation was verified using **ModelSim RTL simulation**.

Three test vectors were used:

| Test Vector | 4-bit Iterative | Key-Dependent |
|---|---|---|
| ISO/IEC Spec Vector 1 | `5579c1387b228445` | `48047391ef1488ba` |
| ISO/IEC Spec Vector 4 | `3333dcd3213210d2` | `3a56ebfd108fac36` |
| Paper Input Vector | `21eb3cf6625a7db3` | `778c58e88a14a806` |

### Verification Status

```text
Test Vector 1     ✓ PASS
Test Vector 4     ✓ PASS
Paper Vector      ✓ PASS
```

The implementation was checked against the ISO/IEC PRESENT specification for the standard verification vectors.

---

## ModelSim Waveform

Important simulation signals:

```text
clk
start
plaintext
round_cnt
done
cipher_4bit
cipher_kd
```

### Encryption Sequence

```text
START
  │
  ▼
Plaintext / Key Load
  │
  ▼
Round 1
  │
  ▼
Round 2
  │
  ▼
  ...
  │
  ▼
Round 31
  │
  ▼
Final AddRoundKey
  │
  ▼
DONE
  │
  ▼
Ciphertext
```

---

## FPGA Synthesis Results

The 4-bit iterative architecture was successfully compiled using **Quartus Prime Lite 18.0**.

| Parameter | Result |
|---|---:|
| Logic Elements | 320 |
| Total Registers | 218 |
| Total Pins | 212 |
| Compilation Errors | 0 |
| Target FPGA | Intel MAX 10 |
| Device | 10M50DAF484C7G |

The reported implementation uses less than **1% of the available logic elements** on the target MAX 10 device.

---

## Latency

The implemented 4-bit architecture uses parallel input loading and one encryption round per clock cycle.

**Reported latency: 33 clock cycles**

The project presentation compares this with a 51-cycle implementation from the reference paper.

---

## Architecture Comparison

| Feature | 4-bit Iterative | Key-Dependent |
|---|---|---|
| Datapath | 4-bit | 4-bit iterative |
| S-box | Fixed | Key-dependent |
| Number of S-boxes | 1 | 16 |
| S-box Selection | Fixed | Key-derived |
| Plaintext Loading | Parallel | Parallel |
| Encryption | Iterative | Iterative |
| Security Modification | Standard | Key-dependent S-box |

---

## FPGA Implementation Flow

```text
        PRESENT Specification
                 │
                 ▼
          Architecture Design
                 │
                 ▼
             Verilog RTL
                 │
                 ▼
          ModelSim Simulation
                 │
                 ▼
         Functional Verification
                 │
                 ▼
          Quartus Synthesis
                 │
                 ▼
       FPGA Resource Analysis
                 │
                 ▼
          DE10-Lite / MAX 10
```

---

## How to Run

### Quartus Prime

1. Open **Quartus Prime Lite 18.0**.
2. Open the `.qpf` project file.
3. Select the target device:

```text
10M50DAF484C7G
```

4. Add the Verilog files from `rtl/`.
5. Select the required top-level module.
6. Run **Start Compilation**.
7. Check the compilation report, resource utilization, and timing analysis.

### ModelSim

Compile the RTL and testbench:

```tcl
vlog rtl/*.v testbench/present_tb.v
```

Start simulation:

```tcl
vsim work.present_tb
```

Run:

```tcl
run -all
```

Observe:

```text
round_cnt
start
done
cipher_4bit
cipher_kd
```

---

## Results

The project demonstrates:

- PRESENT cipher RTL implementation
- 4-bit iterative architecture
- Key-dependent S-box architecture
- Parallel plaintext/key loading
- RTL simulation
- PRESENT test-vector verification
- FPGA synthesis
- Intel MAX 10 implementation
- Resource utilization analysis

---

## Team

This project was completed collaboratively by two members with approximately equal **50–50 contributions**.

### KAVIYA M

Contributed to:

- Literature review
- RTL development
- Simulation and verification
- FPGA synthesis
- Result analysis
- Documentation
- Presentation

### ABHIRAJAN R

Contributed to:

- Literature review
- RTL development
- Simulation and verification
- FPGA synthesis
- Result analysis
- Documentation
- Presentation

Both members jointly contributed to the overall implementation and analysis.

---

## Project Status

🚧 **Project Completed — Documentation / Repository Organization in Progress**

The RTL implementation, simulation, synthesis, and analysis have been carried out. The GitHub repository is being organized with source code, testbench, simulation results, synthesis reports, images, and presentation material.

---

## Applications

Potential application areas include:

- IoT devices
- Embedded systems
- FPGA-based security
- Lightweight cryptography
- Hardware security
- Resource-constrained devices

---

## License

MIT License

---

## Repository Description

> Verilog FPGA implementation of the PRESENT lightweight block cipher with a 4-bit iterative architecture and key-dependent S-box architecture, verified using Quartus Prime and ModelSim on Intel MAX 10.

## Topics

```text
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
digital-design
```
