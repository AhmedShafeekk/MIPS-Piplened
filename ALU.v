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

module ALU(Zero,Alu_result,A,B,Alu_control,reset);

		output Zero;
		output reg [31:0] Alu_result;
		input signed [31:0] A,B;
		input [3:0] Alu_control;
		input reset;
		assign Zero = Alu_result ==0 ? 1 : 0;
		parameters p();
		
		always @(*)
			begin
			#0.1;  //1ps delay to avoid simulation infinite loop error
			if (reset) Alu_result<= 32'h ZZZZZZZZ;
			else
			case (Alu_control)
				p.Alu_and:  Alu_result <= A & B;	//and
				p.Alu_or:   Alu_result <= A | B;	//or
				p.Alu_add:  Alu_result <= A + B;	//add
				p.Alu_sub:  Alu_result <= A - B;	//sub
				p.Alu_slt:  Alu_result <= A < B;	//slt
				p.Alu_nor:  Alu_result <= ~(A | B);	//nor
				p.Alu_xor:  Alu_result <= A^B;   //xor
				p.Alu_mul:	 Alu_result <= A * B; //mul
			endcase
			end
endmodule 
