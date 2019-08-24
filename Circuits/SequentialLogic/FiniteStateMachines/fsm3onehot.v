module top_module(
    input in,
    input [3:0] state,
    output [3:0] next_state,
    output out); //

    parameter A=0, B=1, C=2, D=3;

    // State transition logic: Derive an equation for each state flip-flop.
    assign next_state[A] = (state[A] & ~in) | (state[C] & ~in);
    assign next_state[B] = (state[A] & in) | (state[B] & in) | (state[D] & in);
    assign next_state[C] = (state[B] & ~in) | (state[D] & ~in);
    assign next_state[D] = state[C] & in;
    
    // My prefered style, but it seems that it's not supported by systhesis tool for HDLBits.
    // This is more clear for describing a lagre FSM.
    //always @(*) begin
    //    next_state = 4'b0000;
    //    case(1'b1)		// synthesis parallel_case
    //        state[A]: begin
    //            if (in)
    //                next_state[B] = 1'b1;
    //            else
    //                next_state[A] = 1'b1;
    //        end
    //        state[B]: begin
    //            if (in)
    //                next_state[B] = 1'b1;
    //            else
    //                next_state[C] = 1'b1;
    //        end
    //        state[C]: begin
    //            if (in)
    //                next_state[D] = 1'b1;
    //            else
    //                next_state[A] = 1'b1;
    //        end
    //        state[D]: begin
    //            if (in)
    //                next_state[B] = 1'b1;
    //            else
    //                next_state[C] = 1'b1;
    //        end
    //        default: next_state[A] = 1'b1;
    //    endcase
    //end

    // Output logic: 
    assign out = state[D] == 1'b1;

endmodule
