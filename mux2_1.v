`timescale 1ns / 1ps

/*
	@brief: 2 to one mux that takes 1-bit inputs and 1 bit select
*/
module mux2_1(out,in1,in2,sel);
	output out;
	input in1,in2;
	input sel;
	
	assign out = sel==0? in1:in2;

endmodule
