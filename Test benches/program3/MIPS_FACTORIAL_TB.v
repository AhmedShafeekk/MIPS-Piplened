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
	program 3: calculate factorial of MEM[8] and store the result in MEM[3]

			ADDI R10,R0,8	 	==> 0x200A0008    -- R10 contains memory address of input
			ADDI R2,R0,1		==> 0x20020001		-- R2 = 1   contains reuslt of factorial 
			ADDI R1,R0,1		==> 0x20010001		-- R1 is intermediate variable initialized to 1
			LW R3, 0(R10)		==> 0x8D430000		-- R3 contains value of factorial
			
			//R2 = R2 * R3		==> 	R4 = R2 * R3, R2 = R1 * R4  
	LOOP:	MUL R4,R2,R3		==> 0x0043203F					 
			MUL R2,R4,R1		==> 0x0081103F			
			
			//R3 = R3 - 1 ==> R5 = R3 - 1, R3 = R0 + R5
			ADDI R5,R3,0xFFFF		==> 0x2065FFFF			
			ADD R3,R0,R5		==> 0x00051820				
			BNE R3, R0, LOOP	==> 0x1460FFFB  			
			SW R2, -5 (R10)			==> 0xAD42FFFB
*/	
			
			uut.D_Mem.Data_MEM[8] = 6; 
			$display("MEM[8] = %d", uut.D_Mem.Data_MEM[8]);
			#500  $display("R2 = %d", uut.reg_file.regFile[2]);	
			#20$display("MEM[3] = %d", uut.D_Mem.Data_MEM[3]);

			
	end
      
endmodule

