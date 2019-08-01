module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] result
);
    
    wire [31:0] signed_b;
    wire add16_1_cout;
    
    assign signed_b = {32{sub}} ^ b;
    
    add16 add16_inst_1 (
        .a(a[15:0]),
        .b(signed_b[15:0]),
        .cin(sub),
        .sum(result[15:0]),
        .cout(add16_1_cout)
    );

    add16 add16_inst_2 (
        .a(a[31:16]),
        .b(signed_b[31:16]),
        .cin(add16_1_cout),
        .sum(result[31:16]),
        .cout()
    );

endmodule