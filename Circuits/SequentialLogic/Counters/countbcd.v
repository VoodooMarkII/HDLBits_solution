module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);
    
    assign ena[1] = (q[3:0] == 4'h9);
    assign ena[2] = (q[7:0] == 8'h99);
    assign ena[3] = (q[11:0] == 12'h999);
    
    
    bcd_counter bc_inst_0(
        .clk(clk),
        .reset(reset),
        .enable(1'b1),
        .q(q[3:0])
    );
    
    bcd_counter bc_inst_1(
        .clk(clk),
        .reset(reset),
        .enable(ena[1]),
        .q(q[7:4])
    );
    
    bcd_counter bc_inst_2(
        .clk(clk),
        .reset(reset),
        .enable(ena[2]),
        .q(q[11:8])
    );
    
    bcd_counter bc_inst_3(
        .clk(clk),
        .reset(reset),
        .enable(ena[3]),
        .q(q[15:12])
    );
    
endmodule

module bcd_counter (
    input clk,
    input reset,        // Synchronous active-high reset
    input enable,
    output [3:0] q);
    
    always @(posedge clk) begin
        if (reset)
            q <= 4'h0;
        else if ((q == 4'h9) & enable)
            q <= 4'h0;
        else if (enable)
            q <= q + 1'b1;
    end

endmodule