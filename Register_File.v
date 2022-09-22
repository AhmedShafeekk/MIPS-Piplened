`timescale 1ns / 1ps
/*
RegFile[0] 						|| ==> $Zero
RegFile[1] 						|| ==> $at
RegFile[2]  - RegFile[3] 	|| ==> $v0- $v1
RegFile[4]  - RegFile[7] 	|| ==> $a0- $a3
RegFile[8]  - RegFile[15] 	|| ==> $t0- $t7
RegFile[16] - RegFile[23] 	|| ==> $s0- $s7
RegFile[24] - RegFile[25] 	|| ==> $t8- $t9
RegFile[26] - RegFile[27] 	|| ==> $k0- $k1
RegFile[28] 					|| ==> $gp
RegFile[29] 					|| ==> $sp
RegFile[30] 					|| ==> $fp
RegFile[31] 					|| ==> $ra
*/
module regFile(ReadData1, ReadData2, RegWrite, Rs, Rt, Rd, data,reset);
	output [31:0] ReadData1, ReadData2;
	input [4:0] Rs, Rt, Rd;
	input RegWrite,reset;
	input [31:0] data;
	parameter length = 32;
	reg [31:0] regFile [0:length - 1];
	
	integer k;
	always @(*)
	begin
		if (reset) 
			begin
				for (k=0;k<length;k=k+1) regFile[k]<=0;
			end
		else if (RegWrite)
			begin
				regFile[Rd] <= data;
			end
	end
	assign ReadData1 = regFile[Rs];
	assign ReadData2 = regFile[Rt];
endmodule
