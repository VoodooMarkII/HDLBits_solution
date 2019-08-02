module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
    
    genvar i;
    
    wire [99:0] int_cin, int_cout;
    
    assign int_cin = {int_cout[98:0], cin};
    assign cout = int_cout[99];
    
    
    generate for(i=0; i<100; i=i+1) begin: bcd_adder_inst
        bcd_fadd bcd_fadd_inst(
            .a(a[4*i+3:4*i]),
            .b(b[4*i+3:4*i]),
            .cin(int_cin[i]),
            .cout(int_cout[i]),
            .sum(sum[4*i+3:4*i])
        );
    	end
    endgenerate
        

endmodule
