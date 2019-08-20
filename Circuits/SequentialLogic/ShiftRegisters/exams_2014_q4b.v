module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); //
    
    MUXDFF muxdff_inst_0(
        .clk(KEY[0]),
        .L(KEY[2]),
        .E(KEY[1]),
        .w(LEDR[1]),
        .R(SW[0]),
        .Q(LEDR[0])
    );

    MUXDFF muxdff_inst_1(
        .clk(KEY[0]),
        .L(KEY[2]),
        .E(KEY[1]),
        .w(LEDR[2]),
        .R(SW[1]),
        .Q(LEDR[1])
    );
    MUXDFF muxdff_inst_2(
        .clk(KEY[0]),
        .L(KEY[2]),
        .E(KEY[1]),
        .w(LEDR[3]),
        .R(SW[2]),
        .Q(LEDR[2])
    );
    MUXDFF muxdff_inst_3(
        .clk(KEY[0]),
        .L(KEY[2]),
        .E(KEY[1]),
        .w(KEY[3]),
        .R(SW[3]),
        .Q(LEDR[3])
    );
    
endmodule

module MUXDFF (
    input clk,
	input L,
	input E,
    input w,
    input R,
    output reg Q
);
    always @(posedge clk) begin
        Q <= L? R : (E? w : Q);
    end

endmodule
