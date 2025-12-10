# Verilog Playground

This repository contains simple Verilog examples demonstrating basic concepts and simulation.

## Files Overview

- **hello.v** - A simple "Hello World" program in Verilog
- **wave.v** - A clock generator that creates waveform output
- **hello** - Compiled simulation output (vvp format) from hello.v
- **wave.vcd** - Waveform dump file (Value Change Dump) from wave.v simulation

---

## hello.v - Hello World Example

This is a minimal Verilog program that prints a message and exits.

### Line-by-Line Explanation

```verilog
module hello;
```
**Line 1:** Declares a module named `hello`. A module is the basic building block in Verilog, similar to a function or class in other languages. This module has no input/output ports (empty parentheses).

```verilog

```
**Line 2:** Empty line for readability.

```verilog
initial begin
```
**Line 3:** The `initial` block executes once at the start of simulation (time 0). The `begin` keyword starts a block of sequential statements. This is where we put code that should run when the simulation starts.

```verilog
    $display("Hello, Verilog on Mac!");
```
**Line 4:** `$display` is a Verilog system task (similar to printf in C) that prints text to the console. This line prints "Hello, Verilog on Mac!" followed by a newline. The `$` prefix indicates it's a built-in system task.

```verilog
    $finish;
```
**Line 5:** `$finish` is another system task that terminates the simulation. Without this, the simulation would run indefinitely (or until it times out).

```verilog
end
```
**Line 6:** Closes the `begin` block from line 3.

```verilog

```
**Line 7:** Empty line for readability.

```verilog
endmodule
```
**Line 8:** Closes the module declaration from line 1. Every module must have a matching `endmodule`.

### How to Run

```bash
iverilog -o hello hello.v
vvp hello
```

Expected output:
```
Hello, Verilog on Mac!
```

---

## wave.v - Clock Generator with Waveform Dump

This module generates a clock signal and saves it to a waveform file for visualization.

### Line-by-Line Explanation

```verilog
module wave;
```
**Line 1:** Declares a module named `wave` with no ports.

```verilog
reg clk = 0;
```
**Line 2:** Declares a register variable named `clk` and initializes it to `0`. In Verilog, `reg` is used for variables that hold values (unlike `wire` which is for connections). This will be our clock signal.

```verilog

```
**Line 3:** Empty line for readability.

```verilog
always #5 clk = ~clk; // toggle every 5 time units
```
**Line 4:** This is a continuous assignment that creates a clock. `always` means this statement runs continuously. `#5` is a delay of 5 time units. `~clk` is the bitwise NOT operator (inverts the value). So every 5 time units, `clk` toggles between 0 and 1, creating a square wave with a period of 10 time units (5 units high, 5 units low).

```verilog

```
**Line 5:** Empty line for readability.

```verilog
initial begin
```
**Line 6:** Starts an initial block that runs once at simulation start.

```verilog
    $dumpfile("wave.vcd");
```
**Line 7:** `$dumpfile` is a system task that specifies the filename for the waveform dump. "wave.vcd" is a VCD (Value Change Dump) file format that can be viewed in waveform viewers like GTKWave.

```verilog
    $dumpvars(0, wave);
```
**Line 8:** `$dumpvars` tells the simulator which signals to dump. The first argument `0` means dump all signals in the module and all submodules (0 = all levels). The second argument `wave` is the module instance name. This enables waveform recording.

```verilog
    #50 $finish;
```
**Line 9:** Waits 50 time units (`#50`), then calls `$finish` to end the simulation. Since the clock toggles every 5 units, this will capture 5 complete clock cycles (50 / 10 = 5).

```verilog
end
```
**Line 10:** Closes the `initial begin` block.

```verilog

```
**Line 11:** Empty line for readability.

```verilog
endmodule
```
**Line 12:** Closes the module declaration.

### How to Run

```bash
iverilog -o wave wave.v
vvp wave
gtkwave wave.vcd
```

This will:
1. Compile the Verilog code
2. Run the simulation (creates wave.vcd)
3. Open GTKWave to visualize the clock waveform

---

## Generated Files

### hello
This is the compiled output from Icarus Verilog. When you run `iverilog -o hello hello.v`, it creates this file which contains the compiled simulation in vvp (Icarus Verilog vvp) format. You can run it directly with `vvp hello` or execute it if it has execute permissions.

### wave.vcd
This is a VCD (Value Change Dump) file that contains the waveform data from the simulation. It records all signal value changes over time. You can view it with waveform viewers like:
- **GTKWave** (most common): `gtkwave wave.vcd`
- **Waveform viewers in EDA tools** (ModelSim, Vivado, etc.)

The VCD format is a standard format for storing simulation waveforms and is supported by most Verilog simulators.

---

## Tools Required

- **Icarus Verilog** (`iverilog`) - Verilog compiler and simulator
- **vvp** - Icarus Verilog runtime (usually included with iverilog)
- **GTKWave** (optional) - Waveform viewer for .vcd files

### Installation on macOS

```bash
brew install icarus-verilog
brew install gtkwave
```

---

## Key Verilog Concepts Demonstrated

1. **Modules** - Basic building blocks of Verilog designs
2. **Initial blocks** - Code that runs once at simulation start
3. **Always blocks** - Code that runs continuously or on events
4. **System tasks** - Built-in functions like `$display`, `$finish`, `$dumpfile`, `$dumpvars`
5. **Delays** - Using `#` to specify time delays
6. **Registers** - Variables that hold values
7. **Waveform dumping** - Recording signal changes for visualization

