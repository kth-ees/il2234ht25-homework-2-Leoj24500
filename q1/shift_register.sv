module shift_register #(parameter N=4)
                      (input logic clk,
                       input logic rst_n,
                       input logic serial_parallel,
                       input logic load_enable,
                       input logic serial_in,
                       input logic [N-1:0] parallel_in,
                       output logic [N-1:0] parallel_out,
                       output logic serial_out);

logic [N-1 :0] flipflopConnectors;
logic [N-1 :0] flipflopOutConnectors;

always_comb begin : comblogic

    if (serial_parallel == 0) begin
        flipflopConnectors[0] = serial_in;
        for (int i = 1; i < N; i++) begin
            flipflopConnectors[i] = flipflopOutConnectors[i-1];
        end
        
    end else begin
        for (int i = 0; i < N; i++) begin
            flipflopConnectors[i] = parallel_in[i];
            
        end
    end
    serial_out = flipflopOutConnectors[N-1];
    parallel_out = flipflopOutConnectors;
end

always_ff @(posedge clk or negedge rst_n) begin : flipflops
    if (rst_n == 0)begin
        flipflopOutConnectors <= '0;
    end else if (load_enable ==1)begin
        flipflopOutConnectors <= flipflopConnectors;
    end
end

endmodule
