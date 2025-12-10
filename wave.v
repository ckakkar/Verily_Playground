module wave;
reg clk = 0;

always #5 clk = ~clk; // toggle every 5 time units

initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, wave);
    #50 $finish;
end

endmodule