`timescale 1ns / 1ps

module Data_Mem( ReadData, Address, WriteData, MemWrite,reset,clk);
		output [31:0] ReadData;
		input  MemWrite,reset,clk;
		input [31:0] Address, WriteData;
		parameter length=100;
		reg [31:0] Data_MEM [0:length - 1];
		integer k;
		
		always @(posedge clk)
			begin
				if (reset) 
					begin
						for(k=0;k<length;k=k+1)
							Data_MEM[k]<=0;
					end
				if (MemWrite)
					Data_MEM[Address]<=WriteData;	
			end
			
			assign ReadData = Data_MEM[Address];
endmodule
