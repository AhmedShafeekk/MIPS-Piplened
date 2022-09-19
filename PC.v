`timescale 1ns / 1ps

module PC(PC_out,PC_in,reset);
	output reg [31:0] PC_out;
	input [31:0] PC_in;
	input reset;
	always @(reset)
	 begin
		if (reset)
			PC_out = 0;
		else PC_out = PC_in;
	 end
endmodule
