`timescale 1ns / 1ps

module MIPS_FACTORIAL_TB;

	// Inputs
	reg clk;
	reg reset;

	// Instantiate the Unit Under Test (UUT)
	MIPS uut (
		.clk(clk), 
		.reset(reset)
	);
	
	always #5 clk = ~clk;
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		#10;
		reset = 0;
		#1;
   /*
	program 3: calculate of MEM[8] -which is initialized to 6-
					and store the result in MEM[3]
	
			ADDI R10,R0,8 		==> 0x200A0008
			ADDI R2,R0,1		==> 0x20020001
			LW R3, 0(R10)		==> 0x8D430000
	LOOP:	MUL R4,R2,R3		==> 0x0043203F 
			ADD R2,R0,R4		==> 0x00041020
			SUBI R5,R3, 1		==> 0x24650001
			ADD  R3,R5, R0    ==> 0x00A01820
			BNE R3, R0, LOOP	==> 0x1460FFFD
			SW R2, -5 (R10)	==> 0xAD42FFFB
*/	
			
			uut.D_Mem.Data_MEM[8] = 4; 
			$display("MEM[8] = %d", uut.D_Mem.Data_MEM[8]);
			
			
				 $display("R10 = %d", uut.reg_file.regFile[10]);
			#10 $display("R2 = %d", uut.reg_file.regFile[2]);
			#10 $display("R3 = %d", uut.reg_file.regFile[3]);
			#10 $display("R4 = %d", uut.reg_file.regFile[4]);
			#10 $display("R2 = %d", uut.reg_file.regFile[2]);
			#10 $display("R5 = %d", uut.reg_file.regFile[5]);
			#10 $display("R3 = %d", uut.reg_file.regFile[3]);
			#10 $display("R3 = %d", uut.reg_file.regFile[3]);
			
			#100  $display("R3 = %d", uut.reg_file.regFile[3]);	
			$display("MEM[3] = %d", uut.D_Mem.Data_MEM[3]);

			
	end
      
endmodule

