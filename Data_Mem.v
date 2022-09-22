`timescale 1ns / 1ps

module Data_Mem( ReadData, Address, WriteData, MemRead, MemWrite,reset);
		output reg [31:0] ReadData;
		input MemRead, MemWrite,reset;
		input [31:0] Address, WriteData;
		parameter length=100;
		reg [31:0] Data_MEM [0:length - 1];
		integer k;
		
		always @(*)
			begin
				if (reset) 
					begin
						for(k=0;k<length;k=k+1)
							Data_MEM[k]<=0;
					end
				if (MemWrite)
					Data_MEM[Address]<=WriteData;	
				else
				 begin
					if (MemRead)
						ReadData <= Data_MEM[Address];
					else 
						ReadData<= 32'h ZZZZZZZZ;	
				 end
			end
			
endmodule
