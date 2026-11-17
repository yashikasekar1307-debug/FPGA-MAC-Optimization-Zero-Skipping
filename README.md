# FPGA MAC Unit Optimization Using Zero-Skipping and Operand Isolation

## 1. Project Overview

This project implements and compares a baseline Multiply-Accumulate (MAC) unit with an optimized MAC architecture using zero-skipping and operand isolation.

The optimized design prevents unnecessary multiplication and accumulation operations when the input data or weight is zero.

The designs are implemented and evaluated using Xilinx Vivado 2026.2.

## 2. Objectives

- Design a baseline MAC unit using Verilog HDL.
- Implement an optimized MAC unit using zero-skipping.
- Verify both designs through functional simulation.
- Compare FPGA synthesis resource utilization.
- Analyze routed timing performance.
- Compare Vivado-estimated power consumption.

## 3. Hardware Specifications

| Parameter | Specification |
|---|---|
| Input data width | 8-bit signed |
| Weight width | 8-bit signed |
| Product width | 16-bit signed |
| Accumulator width | 24-bit signed |
| Target clock frequency | 100 MHz |
| Clock period | 10 ns |
| FPGA device | xc7s50csga324-1 |
| Design language | Verilog HDL |
| Development tool | Xilinx Vivado 2026.2 |

## 4. Design Architecture

### Baseline MAC

The baseline MAC performs multiplication and accumulates the product whenever the enable signal is asserted.

### Optimized MAC

The optimized MAC uses zero-skipping and operand isolation.

The multiplication and accumulation are enabled only when:
- Enable signal is high.
- Input data is non-zero.
- Weight is non-zero.

This reduces unnecessary switching activity in the datapath.

## 5. Functional Verification

Both baseline and optimized MAC designs were tested using Verilog testbenches.

The optimized testbench verifies:
- Positive multiplication.
- Negative multiplication.
- Zero input handling.
- Zero weight handling.
- Accumulator update.
- Enable signal control.

**Simulation Result:** OPTIMIZED MAC TEST PASSED!

## 6. Synthesis Utilization Comparison

| Resource | Baseline | Optimized |
|---|---:|---:|
| Slice LUTs | 84 | 88 |
| Slice Registers | 24 | 24 |
| DSPs | 0 | 0 |
| BRAM | 0 | 0 |
| Bonded IOB | 43 | 43 |

The optimized design uses four additional LUTs due to zero-detection and control logic.

## 7. Timing Analysis

| Parameter | Baseline | Optimized |
|---|---:|---:|
| WNS | 6.917 ns | 6.927 ns |
| TNS | 0 ns | 0 ns |
| Data Path Delay | 3.082 ns | 3.072 ns |
| WHS | 0.317 ns | 0.317 ns |

Both designs meet the reported internal timing requirements for the 10 ns clock period.

Note: Input and output delay constraints are incomplete. Full external I/O timing closure has not been established.

## 8. Power Analysis

| Parameter | Baseline | Optimized |
|---|---:|---:|
| Total On-Chip Power | 95 mW | 83 mW |
| Dynamic Power | 24 mW | 13 mW |
| Device Static Power | 70 mW | 70 mW |

The Vivado vector-less power estimates indicate lower estimated dynamic and total power for the optimized design.

**Important:** These are low-confidence tool estimates, not physical board measurements. Further validation with realistic switching activity is outside the scope of this project.

## 9. Tools Used

- Verilog HDL
- Xilinx Vivado 2026.2
- XSim Simulator
- FPGA synthesis and implementation reports

## 10. Conclusion

The project successfully implements and verifies a baseline MAC and an optimized zero-skipping MAC architecture.

The optimized design introduces a small LUT overhead while maintaining similar timing performance. Vivado's preliminary power estimates show reduced dynamic and total on-chip power.

This project demonstrates a simple RTL-level optimization technique for reducing unnecessary switching in FPGA-based MAC datapaths.

## 11. Future Scope

- Implement a pipelined MAC architecture.
- Explore DSP-based multiplication.
- Add complete input/output timing constraints.
- Validate power using realistic switching activity.
- Extend the architecture for neural network accelerator applications.
