module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire sel;
    wire [15:0] sum_lsb;
    wire [15:0] mux_in0, mux_in1, sum_msb;
    
    add16 add16_inst_1 (
        .a(a[15:0]),
        .b(b[15:0]),
        .cin(1'b0),
        .sum(sum_lsb),
        .cout(sel)
    );
    
    add16 add16_inst_2 (
        .a(a[31:16]),
        .b(b[31:16]),
        .cin(1'b0),
        .sum(mux_in0),
        .cout()
    );
    add16 add16_inst_3 (
        .a(a[31:16]),
        .b(b[31:16]),
        .cin(1'b1),
        .sum(mux_in1),
        .cout()
    );
    
    assign sum_msb = sel? mux_in1 : mux_in0;
    assign sum = {sum_msb, sum_lsb};
    
endmodule