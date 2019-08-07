module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);
    
    // KMap
    //  ab\cd 00  01  11  10
    //  00    0   0   x   1
    //  01    0   0   1   0
    //  11    x   0   1   0
    //  10    x   0   x   0
           
    assign out_sop = c&d | ~a&~b&c;
    assign out_pos = ~((~c | ~d) & (a | b | ~c));

endmodule
