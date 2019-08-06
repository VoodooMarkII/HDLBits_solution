module top_module( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );
    
    wire [3:0] cin_int, cout_int;
    
    assign cin_int = {cout_int[2:0], cin};
    assign cout = cout_int[3];
    
    genvar i;
    
    generate for (i=0; i<4; i=i+1) begin: bcd_fadd_inst
        bcd_fadd bcd_fadd_inst(
            .a(a[i*4 +: 4]),
            .b(b[i*4 +: 4]),
            .cin(cin_int[i]),
            .cout(cout_int[i]),
            .sum(sum[i*4 +: 4])
        );
    end
    endgenerate

endmodule
