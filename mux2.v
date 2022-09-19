`timescale 1ns / 1ps

/*
	@brief: 2 to one mux that takes 32-bit inputs and 1 bit select
*/
module mux2(out,in1,in2,sel);
	output [31:0] out;
	input [31:0] in1,in2;
	input sel;
	
	assign out = sel==0? in1:in2;

endmodule
