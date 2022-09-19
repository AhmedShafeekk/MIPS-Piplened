`timescale 1ns / 1ps

/*
@brief: Alu has two operands and a control input, the first operand is from the 
register file and the second one is either from the register file or an immediate
value, the type of alu operation is determined from the alu control signal.

@param Zero: zero flag
@param Alu_result: 32-bit alu output
@param A: 32-bit input
@param B: 32-bit input
@param Alu_control: 4-bit control lines taken from the Alu control unit to
determine the desired operation based on the instruction type.
*/

module ALU(Zero,Alu_result,A,B,Alu_control);
		output Zero;
		output reg [31:0] Alu_result;
		input [31:0] A,B;
		input [3:0] Alu_control;
		assign Zero = Alu_result ==0 ? 1 : 0;
		
		parameters param(); //instance from parameters module
		
		always @(Alu_control)
			begin
			case (Alu_control)
				param.Alu_and:  Alu_result <= A & B;	//and
				param.Alu_or:   Alu_result <= A | B;	//or
				param.Alu_add:  Alu_result <= A + B;	//add
				param.Alu_sub:  Alu_result <= A - B;	//sub
				param.Alu_slt:  Alu_result <= A < B;	//slt
				param.Alu_nor:  Alu_result <= ~(A | B);	//nor
				param.Alu_xor:  Alu_result <= A^B;   //xor
			endcase
			end
endmodule 
