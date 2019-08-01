module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire add16_1_cout;
    
    add16 add16_inst_1 (
        .a(a[15:0]),
        .b(b[15:0]),
        .cin(1'b0),
        .sum(sum[15:0]),
        .cout(add16_1_cout)
    );
    
    add16 add16_inst_2 (
        .a(a[31:16]),
        .b(b[31:16]),
        .cin(add16_1_cout),
        .sum(sum[31:16]),
        //.cout()
    );

endmodule