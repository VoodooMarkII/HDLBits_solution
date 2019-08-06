module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
); //
    
    assign s = a + b;
    
    // When the sign bit of a and b is different, there is no overflow,
    // otherwise when the sign of result is negative to its of a or b, overflow occurs.
    assign overflow = a[7]^b[7] ? 1'b0 : a[7]^s[7];

endmodule
