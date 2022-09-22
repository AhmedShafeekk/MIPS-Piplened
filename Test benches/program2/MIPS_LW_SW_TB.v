`timescale 1ns / 1ps


module MIPS_LW_SW_TB;

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
		
/*		 program2: LW D_MEM[5] , add 45 to it then store it in D_MEM[7] 
		 
		 ADDI R1, R0, 5	 		==> 0x20010005
		 LW   R2, 0(R1)			==> 0x8C220000
		 ADDI R3,R2,45				==> 0x2043002D
		 SW R3, 2 (R1)				==> 0xAC230002
		 */
		 uut.D_Mem.Data_MEM[5] = 15; //Initialize MEM[5] with 15
		 
		 $display("MEM[5] = %d",uut.D_Mem.Data_MEM[5] );
		 //ADDI
		 $display("R1 = %d",uut.reg_file.regFile[1] );
		 #10;  //LW
		 $display("R2 = %d",uut.reg_file.regFile[2] );
		 #10;  //ADDI
		 $display("R3 = %d",uut.reg_file.regFile[3] );
		 #10;  //SW
		 $display("MEM[7] = %d",uut.D_Mem.Data_MEM[7] );
		 
		
	end
      
endmodule

