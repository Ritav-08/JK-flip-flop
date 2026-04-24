# 📘 JK Flip-Flop (Synchronous with Reset) – Verilog

## 🔹 Overview

This project implements a **JK Flip-Flop** in Verilog using a **D Flip-Flop equivalent transformation**, along with a **self-checking testbench**.

The design supports all JK operations:

* Hold
* Set
* Reset
* Toggle

It also includes a **synchronous reset** for proper initialization.

---

## 🔹 Features

* Positive edge-triggered JK Flip-Flop
* Implemented using **D input transformation**
* Synchronous reset (`rst_i`)
* Complement output (`Qbar_o`)
* Self-checking testbench
* Automatic verification on every clock edge

---

## 🔹 Module Description

### 📌 Inputs

* `J_i` → Set input
* `K_i` → Reset input
* `clk_i` → Clock
* `rst_i` → Reset (active HIGH)

### 📌 Outputs

* `Q_o` → Output
* `Qbar_o` → Complement output

---

## 🔹 Working Principle

### 🔸 JK to D Conversion

The JK Flip-Flop is implemented using:

```
D = J·Q̅ + Q·K̅
```

This converts JK behavior into a D Flip-Flop input.

---

## 🔹 JK Flip-Flop Truth Table

| J | K | Next State Q(n+1) |
| - | - | ----------------- |
| 0 | 0 | Q (Hold)          |
| 0 | 1 | 0 (Reset)         |
| 1 | 0 | 1 (Set)           |
| 1 | 1 | Q̅ (Toggle)       |

---

## 🔹 Sequential Logic

```id="jk_seq"
always @(posedge clk_i) begin
   if (rst_i)
      Q_o <= 1'b0;
   else
      Q_o <= D;
end
```

---

## 🔹 Reset Behavior

* Reset is **synchronous**
* Active HIGH:

  ```
  rst_i = 1 → Q_o = 0
  ```

---

## 🔹 Testbench Details

The testbench (`tb_JKff`) includes:

### 🔸 Features

* Continuous clock generation
* Input stimulus covering all JK cases
* Self-checking mechanism
* Result tracking (pass/fail/count)

---

## 🔹 Verification Strategy

### 🔸 Expected Output Logic

```id="jk_check"
case ({J_ti, K_ti})
   2'b00: exp_Q = exp_Q;   // Hold
   2'b01: exp_Q = 0;       // Reset
   2'b10: exp_Q = 1;       // Set
   2'b11: exp_Q = ~exp_Q;  // Toggle
endcase
```

### 🔸 Auto-Checking

* Runs after every **posedge clock**
* Small delay (`#1`) ensures stable outputs before comparison

---

## 🔹 Important Observations ⚠️

### 🔸 Why Reset is Needed Initially?

* Without reset, initial value of `Q_o` is **unknown (X)**
* This propagates through logic and causes incorrect results

### 🔸 Why Reset Held Until Time 7?

* First clock edge occurs at time 5
* Reset ensures:

  * Proper initialization of `Q_o`, `D`, and expected values
* Delay ensures stable simulation startup

---

## 🔹 What If Reset is Removed?

✔️ The design **still works**, but:

* Initial state becomes **undefined (X)**
* Flip-flop stabilizes only after:

  * A valid condition like `J=0, K=1` (reset) or `J=1, K=0` (set) occurs

⚠️ Testbench expected values (`exp_Q`) may mismatch until stabilization.

---

## 🔹 Simulation

### ▶️ Tools

* ModelSim / QuestaSim
* Xilinx Vivado
* Icarus Verilog + GTKWave

### ▶️ Run (Icarus Verilog Example)

```bash id="jk_run"
iverilog -o JKff.vvp JKff.v tb_JKff.v
vvp JKff.vvp
gtkwave JKff.vcd
```

---

## 🔹 Output

* Error messages for mismatches
* Final summary:

  ```
  Checks: X | Pass: Y | Fail: Z
  ```
* Waveform file:

  ```
  JKff.vcd
  ```

---

## 🔹 Sample Output Format

```id="jk_sample"
Time: 20 | Clock: 1, Reset: 0 | J: 1, K: 1 | Q: 0, Qn: 1
```

---

## 🔹 Applications

* Counters (toggle mode)
* Frequency division
* Control logic circuits
* Sequential state machines

---

## 🔹 Design Insights

* JK Flip-Flop can be efficiently implemented using D logic
* Reset is crucial for predictable simulation behavior
* Self-checking testbench improves verification quality
* Synchronizing checks with clock edges avoids timing issues

---

## 🔹 File Structure

```id="jk_struct"
├── JKff.v          # JK Flip-Flop Design
├── tb_JKff.v       # Testbench
├── JKff.vcd        # Waveform output (generated)
└── README.txt      # Documentation
```
