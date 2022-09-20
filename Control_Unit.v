`timescale 1ns / 1ps

module Control_Unit( RegDst, J, Beq, Bneq, MemRead, MemtoReg, Alu_op,MemWrite,Alu_src,RegWrite, opcode);

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



	output reg  RegDst, J, Beq,Bneq, MemRead, MemtoReg,MemWrite,RegWrite;
	output reg [1:0] Alu_src;  //00: reg, 01: Sign extend, 10: Zero extend
	output reg [2:0]  Alu_op;
	input [5:0] opcode;
	
	always @(opcode)
	begin
		case (opcode)
//***********************************R-Type instructions********************
//all R-type except shift and jr instructions		
			R_opcode: 
				begin 
				RegDst<=1;
				J<=0;
				Beq<=0; 
				Bneq<=0;
				MemRead<=0;
				MemtoReg<=0;
				Alu_op<= Aluop_R;
				MemWrite<=0;
				Alu_src<=0;
				RegWrite<=1;
				end
//***********************************I-Type instructions********************
//beq				
			 beq_opcode: 
				begin 
				RegDst<=1'b x;
				J<=0;
				Beq<=1;
				Bneq<=0;	
				MemRead<=0;
				MemtoReg<=1'b x;
				Alu_op<= Aluop_Branch;
				MemWrite<=0;
				Alu_src<=0;
				RegWrite<=0;
				end
//bneq				
			bne_opcode: 
				begin 
				RegDst<=1'b x;
				J<=0;
				Beq<=0;
				Bneq<=1;	
				MemRead<=0;
				MemtoReg<=1'b x;
				Alu_op<= Aluop_Branch;
				MemWrite<=0;
				Alu_src<=0;
				RegWrite<=0;
				end
//lw
			lw_opcode: 
				begin 
				RegDst<=0;
				J<=0;
				Beq<=0;
				Bneq<=0;
				MemRead<=1;
				MemtoReg<=1;
				Alu_op<= Aluop_LW_SW;
				MemWrite<=0;
				Alu_src<=1;
				RegWrite<=1;
				end	
//sw
			sw_opcode: 
				begin 
				RegDst<=1'b x;
				J<=0;
				Beq<=0;
				Bneq<=0;
				MemRead<=0;
				MemtoReg<=1'b x;
				Alu_op<= Aluop_LW_SW;
				MemWrite<=1;
				Alu_src<=1;
				RegWrite<=0;
				end				
//addi
			addi_opcode: 
				begin 
				RegDst<=0;
				J<=0;
				Beq<=0;
				Bneq<=0;
				MemRead<=0;
				MemtoReg<=1;
				Alu_op<= Aluop_LW_SW;
				MemWrite<=0;
				Alu_src<=1;
				RegWrite<=1;
				end
//ori
			ori_opcode: 
				begin 
				RegDst<=0;
				J<=0;
				Beq<=0;
				Bneq<=0;
				MemRead<=0;
				MemtoReg<=1;
				Alu_op<= Aluop_or;
				MemWrite<=0;
				Alu_src<=2; //Zero extend
				RegWrite<=1;
				end
//xori
			xori_opcode: 
				begin 
				RegDst<=0;
				J<=0;
				Beq<=0;
				Bneq<=0;
				MemRead<=0;
				MemtoReg<=1;
				Alu_op<= Aluop_xor;
				MemWrite<=0;
				Alu_src<=2; //Zero extend
				RegWrite<=1;
				end				
//andi
			andi_opcode: 
				begin 
				RegDst<=0;
				J<=0;
				Beq<=0;
				Bneq<=0;
				MemRead<=0;
				MemtoReg<=1;
				Alu_op<= Aluop_and;
				MemWrite<=0;
				Alu_src<=2; //Zero extend
				RegWrite<=1;
				end	
//slti
			slti_opcode: 
				begin 
				RegDst<=0;
				J<=0;
				Beq<=0;
				Bneq<=0;
				MemRead<=0;
				MemtoReg<=1;
				Alu_op<= Aluop_slt;
				MemWrite<=0;
				Alu_src<=1;
				RegWrite<=1;
				end				
//***********************************J instructions******************************
//j			
			j_opcode: 
				begin 
				RegDst<=1'b x;
				J<=1;
				Beq<=0;
				Bneq<=0;
				MemRead<=0;
				MemtoReg<=1'b x;
				Alu_op<= 2'b xx;
				MemWrite<=0;
				Alu_src<=1'b x;
				RegWrite<=0;
				end								
		endcase
	end

endmodule
