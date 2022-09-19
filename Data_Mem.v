`timescale 1ns / 1ps

module Data_Mem( ReadData, Address, WriteData, MemRead, MemWrite,clk);
		output reg [31:0] ReadData;
		input MemRead, MemWrite,clk;
		input [31:0] Address, WriteData;
		
		reg [31:0] Data_MEM [1023:0];
		
		always @(posedge clk)
			begin
				if (MemWrite)
					Data_MEM[Address]<=WriteData;	
			end
			
		always @(posedge clk)
			begin
				if (MemRead)
					ReadData <= Data_MEM[Address];
				else 
					ReadData<= {32 * {1 'b Z} };
			end
			
endmodule
