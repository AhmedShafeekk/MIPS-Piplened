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
//***********************************************Constants**********************************************
//opcodes
		//R-Type
		parameter R_opcode = 0;
		//I-Type
		parameter addi_opcode =8, andi_opcode =12, beq_opcode =4,
		bne_opcode =5, lb_opcode =32, lh_opcode =33, lui_opcode =15,
		lw_opcode =35, ori_opcode =13, sb_opcode =40,
		sh_opcode =41, slti_opcode =10,sw_opcode =43, xori_opcode =14;
		//J-type
		parameter j_opcode =2, jal_opcode =3;

//function field (R-type)
		parameter add_funct = 32, and_funct = 36, jr_funct = 8,
		nor_funct = 39, or_funct = 37, sll_funct = 0,
		slt_funct = 42, sra_funct = 3, srl_funct = 2,
		sub_funct = 34, xor_funct = 38;
		
//Alu_controls
		parameter Alu_and = 4'b0000, Alu_or = 4'b0001, Alu_add = 4'b0010, 
		Alu_sub = 4'b0110, Alu_slt = 4'b0111, Alu_nor = 4'b1100,
		Alu_xor = 4'b 1101;
//Alu_op
			parameter Aluop_LW_SW = 0, Aluop_Branch = 1, Aluop_R = 2,Aluop_or = 3, Aluop_xor = 4, Aluop_slt = 5,
			Aluop_and = 5;
//******************************************************************************************************
		output Zero;
		output reg [31:0] Alu_result;
		input [31:0] A,B;
		input [3:0] Alu_control;
		assign Zero = Alu_result ==0 ? 1 : 0;
		
		
		always @(*)
			begin
			case (Alu_control)
				Alu_and:  Alu_result <= A & B;	//and
				Alu_or:   Alu_result <= A | B;	//or
				Alu_add:  Alu_result <= A + B;	//add
				Alu_sub:  Alu_result <= A - B;	//sub
				Alu_slt:  Alu_result <= A < B;	//slt
				Alu_nor:  Alu_result <= ~(A | B);	//nor
				Alu_xor:  Alu_result <= A^B;   //xor
			endcase
			end
endmodule 
