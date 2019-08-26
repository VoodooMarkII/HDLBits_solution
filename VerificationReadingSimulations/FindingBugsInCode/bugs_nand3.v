module top_module (input a, input b, input c, output out);//
    
    wire out_int;
    
    assign out = ~out_int;

    andgate inst1 ( out_int, a, b, c, 1'b1, 1'b1 );

endmodule
