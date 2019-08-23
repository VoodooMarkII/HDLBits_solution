#!/usr/bin/ruby

# Author : VoodooMarkII
# Date: 2019/08/24
# Description: A script for generating Conway's Game of Life RTL code for HDLBits quiz
# How to use: run ./gen_rtl.rb [length_of_side], A RTL will be generated in the current path.

row = ARGV.shift.to_i # The length of side for the cube, only 2^n is acceptable
raise ArgumentError, 'Input value is not the power of 2' unless (row & (row - 1)) == 0
row_mask = row - 1 # The mask used in AND operation to wrap around the index
msb = row * row - 1 # The MSB's index for input and output data width

submodule_def_str = <<-HEREDOC
module next_life_gen(
    input wire center,
    input wire left,
    input wire left_up,
    input wire left_down,
    input wire center_up,
    input wire center_down,
    input wire right,
    input wire right_up,
    input wire right_down,
    output reg next_state );
    
    wire [2:0] count;
    wire [7:0] neighbour;
    
    assign neighbour = {left, left_up, left_down, center_up, center_down, right, right_up, right_down};
    
    integer i;
    
    always @(*) begin
        count = 3'd0;
        for (i=0; i<8; i=i+1) begin
            count = count + neighbour[i];
        end
    end
    
    always @(*) begin
        if (count < 3'd1)
            next_state = 1'b0;
        else if (count == 3'd2)
            next_state = center;
        else if (count == 3'd3)
            next_state = 1'b1;
        else
            next_state = 1'b0;
    end
endmodule
HEREDOC

submodule_inst_str = <<-HEREDOC
next_life_gen next_life_inst_%d(
    .center(q[%d]),
    .left(q[%d]),
    .left_up(q[%d]),
    .left_down(q[%d]),
    .center_up(q[%d]),
    .center_down(q[%d]),
    .right(q[%d]),
    .right_up(q[%d]),
    .right_down(q[%d]),
    .next_state(next_state[%d])
);
HEREDOC

gen_v = File.open('./conwaylife.v', 'w')

# Generate module and internal signal declaration
gen_v.puts <<-HEREDOC
module top_module(
    input clk,
    input load,
    input [#{msb}:0] data,
    output [#{msb}:0] q );
HEREDOC
gen_v.puts "\n"
gen_v.puts "    wire [#{msb}:0] next_state;"

# Generate Q
gen_v.puts <<-HEREDOC
    always @(posedge clk) begin
        if (load)
            q <= data;
        else
            q <= next_state;
    end
HEREDOC

# Generate massive submodule instantiation
(0..(row - 1)).each do |i|
  (0..(row - 1)).each do |j|
    inst_idx = i * row + j
    left_idx = i * row + ((j + 1) & row_mask)
    left_up_idx = ((i + 1) & row_mask) * row + ((j + 1) & row_mask)
    left_down_idx = ((i - 1) & row_mask) * row + ((j + 1) & row_mask)
    center_up_idx = ((i + 1) & row_mask) * row + (j & row_mask)
    center_down_idx = ((i - 1) & row_mask) * row + (j & row_mask)
    right_idx = i * row + ((j - 1) & row_mask)
    right_up_idx = ((i + 1) & row_mask) * row + ((j - 1) & row_mask)
    right_down_idx = ((i - 1) & row_mask) * row + ((j - 1) & row_mask)
    gen_v.puts submodule_inst_str % [inst_idx, inst_idx, left_idx, left_up_idx, left_down_idx, \
                              center_up_idx, center_down_idx, right_idx, right_up_idx, right_down_idx, inst_idx]
    gen_v.puts "\n"
  end
end
gen_v.puts "endmodule"

# Generate submodule declaration
gen_v.puts submodule_def_str



