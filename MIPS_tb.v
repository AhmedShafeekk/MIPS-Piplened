`timescale 1ns / 1ps

module MIPS_tb;
	reg clk, reset;
	wire [15:0] out;
	MIPS mips(.clk(clk),.reset(reset));
	integer k;
	
	always #5 clk = ~clk;
	initial 
		begin  
			clk=0;
			reset = 1;
			#100;
			reset = 0;
			#5 reset = 1; #5 reset = 0;
		//Add R0,R1,R5 	R0=0	R5=5, R1=7		(0000)(00 00)(001 0)(0101) (0000)(0 000)00 10)0000

			/*mips.reg_file.regFile[0] = 10;
			mips.reg_file.regFile[1] = 7;
			mips.reg_file.regFile[5] = 5;
			mips.I_Mem.Inst_MEM[0] = 32'h 00250020;  
			mips.I_Mem.Inst_MEM[1] = 32'h 00250020;  
			$display("R0 contains: %d",mips.reg_file.regFile[0]);
			$display("\nPC is: %d",mips.pc.PC_out);
			$display("\nPC new is: %d",mips.pc.PC_in);
			$display("\nIR is: %d",mips.I_Mem.IR); */
			
			
			for (k=0;k<32;k=k+1)
				mips.reg_file.regFile[k] = k;
			
			mips.I_Mem.Inst_MEM[0] = 32'h 2001000A; //ADDI R1,R0,10  001000 00000 00001 0000000000001010 
			mips.I_Mem.Inst_MEM[1] = 32'h 20020014; //ADDI R2,R0,20
			mips.I_Mem.Inst_MEM[2] = 32'h 20030019; //ADDI R3,R0,25
			mips.I_Mem.Inst_MEM[3] = 32'h 00422020; //ADD  R4,R2,R2
			mips.I_Mem.Inst_MEM[4] = 32'h 00832820; //ADD  R5,R4,R3
			
			for (k=0;k<32;k=k+1)
				$display("R%1d - %2d",k,mips.reg_file.regFile[k]);
			
			$display("PC: %d" ,mips.pc.PC_out);	
		#300 $finish;
 


	end		
endmodule
