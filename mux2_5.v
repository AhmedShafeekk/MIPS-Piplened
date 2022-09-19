`timescale 1ns / 1ps

/*
	@brief: 2 to one mux that takes 5-bit inputs and 1 bit select
*/
module mux2_5(out,in1,in2,sel);
	output [4:0] out;
	input [4:0] in1,in2;
	input sel;
	
	assign out = sel==0? in1:in2;

endmodule
