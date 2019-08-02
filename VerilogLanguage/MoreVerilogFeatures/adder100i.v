module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );
    
    genvar i;
    
    wire [99:0] int_cin;
    
    assign int_cin = {cout[98:0],cin};
    
    generate for (i=0; i<100; i=i+1) begin: adder_isnt
        fadd fadd_inst(
            .a(a[i]),
            .b(b[i]),
            .cin(int_cin[i]),
            .cout(cout[i]),
            .sum(sum[i])
        );
        end
    endgenerate

endmodule

module fadd( 
    input a, b, cin,
    output cout, sum );
    
    assign sum = a ^ b ^ cin;
    assign cout = a&b | a&cin | b&cin;

endmodule
