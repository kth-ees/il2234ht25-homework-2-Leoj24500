`timescale 1ns/1ps
module shift_register_tb;

  parameter N = 4; // bitwidth

  logic clk;
  logic rst_n;
  logic serial_parallel;
  logic load_enable;
  logic serial_in;
  logic [N-1:0] parallel_in;
  logic [N-1:0] parallel_out;
  logic serial_out;

  logic [N-1 : 0] inputSequence = 0;


  shift_register #(N) dut (
    .clk(clk),
    .rst_n(rst_n),
    .serial_parallel(serial_parallel),
    .load_enable(load_enable),
    .serial_in(serial_in),
    .parallel_in(parallel_in),
    .parallel_out(parallel_out),
    .serial_out(serial_out)
  );

task automatic rand_in_range(output int val, input int low, input int high);
    val = $urandom_range(low, high);
endtask

initial begin
     
    clk = 0;
    rst_n = 1;
    serial_parallel = 0;
    load_enable = 1;
    serial_in = 0;
    parallel_in = 0;

    serial_parallel = 0;    //load serialy

    
    for (inputSequence = 0; inputSequence < 15; inputSequence++) begin
        for (int j = 0; j < 4; j++) begin
            serial_in = inputSequence[j];
            for (int i = 0; i < 4; i++)begin
                clk = 1;
                #1;
                clk = 0;
                #1;
            end
        end
        #5;
    end

    #30;
    serial_parallel = 1;
    clk = 1;
    #1;
    clk = 0;
    #1;
    
    for (inputSequence = 0; inputSequence < 15; inputSequence++) begin
        parallel_in = inputSequence;
        clk = 1;
        #1;
        clk = 0;
        #1;
        clk = 1;
        #1;
        clk = 0;
        #1;
    end
    parallel_in = inputSequence;
    clk = 1;
    #1;
    clk = 0;
    #1;
    clk = 1;
    #1;
    clk = 0;
    #1;
    clk = 1;
    #1;
    clk = 0;
    #30;

    rst_n = 0;
    if (parallel_out !== 0) $error("rst_n error parallel_out");
    if (serial_out !== 0) $error("rst_n error parallel_out");

    clk = 1;
    #1;
    clk = 0;
    #1;
    clk = 1;
    #1;
    clk = 0;
    #1;
    clk = 1;
    #1;
    clk = 0;
    #10;

end
endmodule