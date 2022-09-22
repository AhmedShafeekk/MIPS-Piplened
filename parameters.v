`timescale 1ns / 1ps

/*			 
				31: 26		25:21			20:16			15:11			10:6				5:0
R-format: op(6-bits), rs(5-bits), rt(5-bits, rd(5-bits), shamt(5-bits), funct(6-bits)
J-format: op(6-bits), address (26-bit)
I-format: op(6-bits), rs(5-bits), rt(5-bits), immediate(16-bit)
*/

module parameters;
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
		sub_funct = 34, xor_funct = 38, mul_funct = 63;
		
//Alu_controls
		parameter Alu_and = 4'b0000, Alu_or = 4'b0001, Alu_add = 4'b0010, 
		Alu_sub = 4'b0110, Alu_slt = 4'b0111, Alu_nor = 4'b1100,
		Alu_xor = 4'b 1101, Alu_mul = 4'b 1111;
//Alu_op
			parameter Aluop_add = 0, Aluop_sub = 1, Aluop_R = 2,Aluop_or = 3, Aluop_xor = 4, Aluop_slt = 5,
			Aluop_and = 5;
//******************************************************************************************************
			
endmodule
