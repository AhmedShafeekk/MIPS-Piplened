`timescale 1ns / 1ps

module MIPS_tb;
	reg clk, reset;
	
	MIPS mips(.clk(clk),.reset(reset));
	
	
	always #5 clk = ~clk;
	initial 
		begin  
			clk=0;
			reset = 1;
			#100;
			reset = 0;
		//Add R0,R1,R5 	R0=0	R5=5, R1=7		(0000)(00 00)(001 0)(0101) (0000)(0 000)00 10)0000

		//	mips.reg_file.regFile[0] = 10;
			mips.reg_file.regFile[1] = 7;
			mips.reg_file.regFile[5] = 5;
			mips.I_Mem.Inst_MEM[0] = 32'h 00250020;  
			mips.I_Mem.Inst_MEM[1] = 32'h 00250020;  
			$display("R0 contains: %d",mips.reg_file.regFile[0]);
			$display("\nPC is: %d",mips.pc_out);
			$display("\nPC new is: %d",mips.pc.PC_in);
			$display("\nIR is: %d",mips.I_Mem.IR); 
		end
endmodule
