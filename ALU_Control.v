`timescale 1ns / 1ps

/*
@brief: Alu_Control takes, (6-bit) funct_field and (2-bit) Alu_op to produce (4-bits) ALu_control

@param  Alu_op: 2-bit signal from main control unit to determine the instruction type
					whether LW/SW (00), Branch (01), R(10). 
@param funct_filed: 	instruction [0:5] 
@param Alu_control: output signal to ALU.				

*/

module ALU_Control(Alu_control, Alu_op, funct_field);

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

		output reg [3:0] Alu_control;
		input [5:0] funct_field;
		input [2:0] Alu_op;
		
		
		always @(Alu_op,funct_field)
		begin
			case (Alu_op)
				Aluop_LW_SW:  Alu_control <= Alu_add;
				Aluop_Branch:  Alu_control <= Alu_add;
				Aluop_R:
					begin
						case (funct_field)
							add_funct:   Alu_control <= Alu_add;
							sub_funct:   Alu_control <= Alu_sub;
							and_funct:   Alu_control <= Alu_and;
							or_funct:    Alu_control <= Alu_or;
							xor_funct:   Alu_control <= Alu_xor;
							nor_funct:   Alu_control <= Alu_nor;
							slt_funct:   Alu_control <= Alu_slt;
						endcase
					end
				Aluop_or:	Alu_control <= Alu_or;
				Aluop_xor:	Alu_control <= Alu_xor;
				Aluop_slt:	Alu_control <= Alu_slt;
						
		endcase
		end
		
endmodule
