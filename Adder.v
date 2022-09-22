`timescale 1ns / 1ps

module Adder(SUM,A,B);
		input [31:0] A,B;
		output [31:0] SUM;
		assign SUM = A + B;
endmodule
