module top_module (
    input [1:0] sel,
    input [7:0] a,
    input [7:0] b,
    input [7:0] c,
    input [7:0] d,
    output [7:0] out  ); //

    wire [7:0] mux0, mux1;
    mux2 mux0_inst ( sel[0],    a,    b, mux0 );
    mux2 mux1_isnt ( sel[0],    c,    d, mux1 );
    mux2 mux2_inst ( sel[1], mux0, mux1,  out );

endmodule
