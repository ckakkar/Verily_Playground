# Verilog Playground

This repository contains simple Verilog examples demonstrating basic concepts and simulation.

## Files Overview

- **hello.v** - A simple "Hello World" program in Verilog
- **wave.v** - A clock generator that creates waveform output
- **and_gate.v** - An AND gate implementation with waveform output
- **xor_gate.v** - An XOR gate implementation with waveform output
- **hello** - Compiled simulation output (vvp format) from hello.v
- **wave.vcd** - Waveform dump file (Value Change Dump) from wave.v simulation
- **and_gate.vcd** - Waveform dump file from and_gate.v simulation
- **xor_gate.vcd** - Waveform dump file from xor_gate.v simulation

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

## and_gate.v - AND Gate with Waveform Output

This module implements an AND gate using Verilog's built-in primitive and generates test patterns to demonstrate all input combinations.

### Line-by-Line Explanation

```verilog
module and_gate;
```
**Line 1:** Declares a module named `and_gate` with no ports.

```verilog
    // Input signals
    reg a = 0;
    reg b = 0;
```
**Line 2-4:** Comments and declarations. `reg a = 0;` and `reg b = 0;` declare two register variables `a` and `b` initialized to 0. These are the inputs to the AND gate. `reg` is used because these signals will be assigned values in procedural blocks.

```verilog
    
    // Output signal
    wire y;
```
**Line 5-7:** Comments and declaration. `wire y;` declares a wire variable `y` which will be the output of the AND gate. `wire` is used for signals that are driven by continuous assignments or primitives.

```verilog
    
    // Instantiate the AND gate
    and gate1(y, a, b);
```
**Line 8-10:** Comments and gate instantiation. `and gate1(y, a, b);` instantiates Verilog's built-in AND gate primitive. The syntax is `and <instance_name>(output, input1, input2)`. Here, `y` is the output, and `a` and `b` are the inputs. The output `y` will be 1 only when both `a` AND `b` are 1.

```verilog
    
    // Generate test patterns for input a
    initial begin
        #10 a = 0;  // a = 0 at time 10
        #10 a = 1;  // a = 1 at time 20
        #10 a = 0;  // a = 0 at time 30
        #10 a = 1;  // a = 1 at time 40
        #10;        // wait until time 50
    end
```
**Line 11-19:** First test pattern generator. This `initial` block controls input `a`. It waits 10 time units, then sets `a = 0` at time 10. Then waits another 10 units and sets `a = 1` at time 20. This pattern continues, creating the sequence: 0 (time 0-10), 0 (time 10-20), 1 (time 20-30), 0 (time 30-40), 1 (time 40-50).

```verilog
    
    // Generate test patterns for input b
    initial begin
        #10 b = 0;  // b = 0 at time 10
        #10 b = 0;  // b = 0 at time 20
        #10 b = 1;  // b = 1 at time 30
        #10 b = 1;  // b = 1 at time 40
        #10;        // wait until time 50
    end
```
**Line 20-28:** Second test pattern generator. This `initial` block controls input `b` independently. It creates the sequence: 0 (time 0-10), 0 (time 10-20), 0 (time 20-30), 1 (time 30-40), 1 (time 40-50).

Together, these two blocks create all four input combinations:
- Time 0-10: a=0, b=0
- Time 10-20: a=0, b=0
- Time 20-30: a=1, b=0
- Time 30-40: a=0, b=1
- Time 40-50: a=1, b=1

```verilog
    
    // Setup waveform dumping
    initial begin
        $dumpfile("and_gate.vcd");
        $dumpvars(0, and_gate);
        #60 $finish;  // Run for 60 time units to see all patterns
    end
```
**Line 29-35:** Waveform dumping setup. `$dumpfile("and_gate.vcd")` specifies the output filename. `$dumpvars(0, and_gate)` enables dumping all signals in the `and_gate` module (0 means all hierarchy levels). `#60 $finish` waits 60 time units then ends the simulation, ensuring all test patterns are captured.

```verilog
    
endmodule
```
**Line 36-37:** Closes the module declaration.

### AND Gate Truth Table

| a | b | y (output) |
|---|---|------------|
| 0 | 0 | 0          |
| 0 | 1 | 0          |
| 1 | 0 | 0          |
| 1 | 1 | 1          |

The output is 1 only when both inputs are 1.

### How to Run

```bash
iverilog -o and_gate and_gate.v
vvp and_gate
gtkwave and_gate.vcd
```

This will:
1. Compile the Verilog code
2. Run the simulation (creates and_gate.vcd)
3. Open GTKWave to visualize the AND gate behavior

---

## xor_gate.v - XOR Gate with Waveform Output

This module implements an XOR (exclusive OR) gate using Verilog's built-in primitive and generates test patterns to demonstrate all input combinations.

### Line-by-Line Explanation

```verilog
module xor_gate;
```
**Line 1:** Declares a module named `xor_gate` with no ports.

```verilog
    // Input signals
    reg a = 0;
    reg b = 0;
```
**Line 2-4:** Comments and declarations. `reg a = 0;` and `reg b = 0;` declare two register variables `a` and `b` initialized to 0. These are the inputs to the XOR gate.

```verilog
    
    // Output signal
    wire y;
```
**Line 5-7:** Comments and declaration. `wire y;` declares a wire variable `y` which will be the output of the XOR gate.

```verilog
    
    // Instantiate the XOR gate
    xor gate1(y, a, b);
```
**Line 8-10:** Comments and gate instantiation. `xor gate1(y, a, b);` instantiates Verilog's built-in XOR gate primitive. The syntax is `xor <instance_name>(output, input1, input2)`. Here, `y` is the output, and `a` and `b` are the inputs. The output `y` will be 1 when the inputs are different (one is 0, the other is 1).

```verilog
    
    // Generate test patterns for input a
    initial begin
        #10 a = 0;  // a = 0 at time 10
        #10 a = 1;  // a = 1 at time 20
        #10 a = 0;  // a = 0 at time 30
        #10 a = 1;  // a = 1 at time 40
        #10;        // wait until time 50
    end
```
**Line 11-19:** First test pattern generator. This `initial` block controls input `a`, creating the sequence: 0 (time 0-10), 0 (time 10-20), 1 (time 20-30), 0 (time 30-40), 1 (time 40-50).

```verilog
    
    // Generate test patterns for input b
    initial begin
        #10 b = 0;  // b = 0 at time 10
        #10 b = 0;  // b = 0 at time 20
        #10 b = 1;  // b = 1 at time 30
        #10 b = 1;  // b = 1 at time 40
        #10;        // wait until time 50
    end
```
**Line 20-28:** Second test pattern generator. This `initial` block controls input `b` independently, creating the sequence: 0 (time 0-10), 0 (time 10-20), 0 (time 20-30), 1 (time 30-40), 1 (time 40-50).

Together, these two blocks create all four input combinations:
- Time 0-10: a=0, b=0
- Time 10-20: a=0, b=0
- Time 20-30: a=1, b=0
- Time 30-40: a=0, b=1
- Time 40-50: a=1, b=1

```verilog
    
    // Setup waveform dumping
    initial begin
        $dumpfile("xor_gate.vcd");
        $dumpvars(0, xor_gate);
        #60 $finish;  // Run for 60 time units to see all patterns
    end
```
**Line 29-35:** Waveform dumping setup. `$dumpfile("xor_gate.vcd")` specifies the output filename. `$dumpvars(0, xor_gate)` enables dumping all signals in the `xor_gate` module. `#60 $finish` waits 60 time units then ends the simulation.

```verilog
    
endmodule
```
**Line 36-37:** Closes the module declaration.

### XOR Gate Truth Table

| a | b | y (output) |
|---|---|------------|
| 0 | 0 | 0          |
| 0 | 1 | 1          |
| 1 | 0 | 1          |
| 1 | 1 | 0          |

The output is 1 when the inputs are different, and 0 when they are the same.

### How to Run

```bash
iverilog -o xor_gate xor_gate.v
vvp xor_gate
gtkwave xor_gate.vcd
```

This will:
1. Compile the Verilog code
2. Run the simulation (creates xor_gate.vcd)
3. Open GTKWave to visualize the XOR gate behavior

---

## Generated Files

### hello
This is the compiled output from Icarus Verilog. When you run `iverilog -o hello hello.v`, it creates this file which contains the compiled simulation in vvp (Icarus Verilog vvp) format. You can run it directly with `vvp hello` or execute it if it has execute permissions.

### wave.vcd
This is a VCD (Value Change Dump) file that contains the waveform data from the wave.v simulation. It records all signal value changes over time.

### and_gate.vcd
This is a VCD file that contains the waveform data from the and_gate.v simulation, showing how the AND gate output changes with different input combinations.

### xor_gate.vcd
This is a VCD file that contains the waveform data from the xor_gate.v simulation, showing how the XOR gate output changes with different input combinations.

**Viewing VCD files:** You can view any VCD file with waveform viewers like:
- **GTKWave** (most common): `gtkwave <filename>.vcd`
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
6. **Registers** - Variables that hold values (`reg`)
7. **Wires** - Variables for connections (`wire`)
8. **Gate primitives** - Built-in logic gates like `and`, `xor`, `or`, `not`, etc.
9. **Waveform dumping** - Recording signal changes for visualization
10. **Test patterns** - Generating input sequences to verify logic behavior

