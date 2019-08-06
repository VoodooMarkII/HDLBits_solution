module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);
    
    genvar i;
    
    wire[3:0] cin;
    wire[4:0] cout;
    
    assign cin = {cout[2:0],1'b0};
    assign sum[4] = cout[3];
    
    generate for(i=0; i<4; i=i+1) begin: adder_inst
        fadd fadd_inst(
            .a(x[i]),
            .b(y[i]),
            .cin(cin[i]),
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
