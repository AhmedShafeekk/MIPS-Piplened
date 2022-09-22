`timescale 1ns / 1ps

module MIPS_tb;
	reg clk, reset;
				
	MIPS mips(.clk(clk),.reset(reset));
	
	always #5 clk = ~clk;
	initial 
		begin  
			clk=0;
			reset = 1;
			#10;
			reset = 0;
			#1;
			//program1
		//ADDI R1,R0,10  001000 00000 00001 0000 0000 0000 1010   ==>  0x 2001 000A
		//	NOP           000000 00000 00000 0000 0000 0000 0000   ==>  0x 0000 0000
		//ADDI R2,R0,20  001000 00000 00010 0000 0000 0001 0100   ==>  0x 2002 0014 
		// NOP			  000000 00000 00000 0000 0000 0000 0000   ==>  0x 0000 0000
		//ADDI R3,R0,25  001000 00000 00011 0000 0000 0001 1001   ==>  0x 2003 0019
		// NOP			  000000 00000 00000 0000 0000 0000 0000   ==>  0x 0000 0000
		//ADD  R4,R2,R1  000000 00010 00001 0010 0000 0010 0000   ==>  0x 0041 2020
		// NOP			  000000 00000 00000 0000 0000 0000 0000   ==>  0x 0000 0000
		//slt  R5,R4,R3  000000 00100 00011 0010 1000 0010 1010   ==>  0x 0083 282A
		
		
		
		$display("PC: %d" ,mips.pc.PC_out);
		$display("IR: %x", mips.I_Mem.IR);
		$display ("R1: %d",mips.reg_file.regFile[1]);
		
		#10; //NOP to avoid race condition because there is no piplining, forwarding and stalling units
		
		#10;
		$display("PC: %x" ,mips.pc.PC_out);
		$display("IR: %x", mips.I_Mem.IR);
		$display ("R2: %d",mips.reg_file.regFile[2]);
		
		#10;  //NOP
		
		#10;
		$display("PC: %d" ,mips.pc.PC_out);
		$display("IR: %x", mips.I_Mem.IR);
		$display ("R3: %d",mips.reg_file.regFile[3]);
		
		#10; //NOP
		
		#10;
		$display("PC: %d" ,mips.pc.PC_out);
		$display("IR: %x", mips.I_Mem.IR);
		$display ("R4: %d",mips.reg_file.regFile[4]);
		
		#10;  //NOP
		
		#10;
		$display("PC: %d" ,mips.pc.PC_out);
		$display("IR: %x", mips.I_Mem.IR);
		$display ("R5: %d",mips.reg_file.regFile[5]);
			
end
endmodule
