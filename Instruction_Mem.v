`timescale 1ns / 1ps

module Instruction_Mem(IR,PC,reset);
	output reg [31:0] IR; //next Instruction to be executed 
	input [31:0] PC; //address of next intstruction to be executed
	input reset;
	parameter length = 100;
		reg [31:0] Inst_MEM [0:length - 1];
		
		integer i;
	initial  $readmemh("program1.txt", Inst_MEM);
	always @(PC)
		begin
				if (reset) IR<= Inst_MEM[0];
				else IR <= Inst_MEM[PC>>2];
		end
endmodule
