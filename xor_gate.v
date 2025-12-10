module xor_gate;
    // Input signals
    reg a = 0;
    reg b = 0;
    
    // Output signal
    wire y;
    
    // Instantiate the XOR gate
    xor gate1(y, a, b);
    
    // Generate test patterns for input a
    initial begin
        #10 a = 0;  // a = 0 at time 10
        #10 a = 1;  // a = 1 at time 20
        #10 a = 0;  // a = 0 at time 30
        #10 a = 1;  // a = 1 at time 40
        #10;        // wait until time 50
    end
    
    // Generate test patterns for input b
    initial begin
        #10 b = 0;  // b = 0 at time 10
        #10 b = 0;  // b = 0 at time 20
        #10 b = 1;  // b = 1 at time 30
        #10 b = 1;  // b = 1 at time 40
        #10;        // wait until time 50
    end
    
    // Setup waveform dumping
    initial begin
        $dumpfile("xor_gate.vcd");
        $dumpvars(0, xor_gate);
        #60 $finish;  // Run for 60 time units to see all patterns
    end
    
endmodule

