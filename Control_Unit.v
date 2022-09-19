`timescale 1ns / 1ps

module Control_Unit( RegDst, J, Beq, Bneq, MemRead, MemtoReg, Alu_op,MemWrite,Alu_src,RegWrite, opcode);
	output reg  RegDst, J, Beq,Bneq, MemRead, MemtoReg,MemWrite,RegWrite;
	output reg [1:0] Alu_src;  //00: reg, 01: Sign extend, 10: Zero extend
	output reg [2:0]  Alu_op;
	input [5:0] opcode;
	
	parameters param(); //instance from parameters module
	
	always @(opcode)
	begin
		case (opcode)
//***********************************R-Type instructions********************
//all R-type except shift and jr instructions		
			param.R_opcode: 
				begin 
				RegDst<=1;
				J<=0;
				Beq<=0; 
				Bneq<=0;
				MemRead<=0;
				MemtoReg<=0;
				Alu_op<= param.Aluop_R;
				MemWrite<=0;
				Alu_src<=0;
				RegWrite<=1;
				end
//***********************************I-Type instructions********************
//beq				
			param.bne_opcode, param.beq_opcode: 
				begin 
				RegDst<=1'b x;
				J<=0;
				Beq<=1;
				Bneq<=0;	
				MemRead<=0;
				MemtoReg<=1'b x;
				Alu_op<= param.Aluop_Branch;
				MemWrite<=0;
				Alu_src<=0;
				RegWrite<=0;
				end
//bneq				
			param.bne_opcode, param.beq_opcode: 
				begin 
				RegDst<=1'b x;
				J<=0;
				Beq<=0;
				Bneq<=1;	
				MemRead<=0;
				MemtoReg<=1'b x;
				Alu_op<= param.Aluop_Branch;
				MemWrite<=0;
				Alu_src<=0;
				RegWrite<=0;
				end
//lw
			param.lw_opcode: 
				begin 
				RegDst<=0;
				J<=0;
				Beq<=0;
				Bneq<=0;
				MemRead<=1;
				MemtoReg<=1;
				Alu_op<= param.Aluop_LW_SW;
				MemWrite<=0;
				Alu_src<=1;
				RegWrite<=1;
				end	
//sw
			param.sw_opcode: 
				begin 
				RegDst<=1'b x;
				J<=0;
				Beq<=0;
				Bneq<=0;
				MemRead<=0;
				MemtoReg<=1'b x;
				Alu_op<= param.Aluop_LW_SW;
				MemWrite<=1;
				Alu_src<=1;
				RegWrite<=0;
				end				
//addi
			param.addi_opcode: 
				begin 
				RegDst<=0;
				J<=0;
				Beq<=0;
				Bneq<=0;
				MemRead<=0;
				MemtoReg<=1;
				Alu_op<= param.Aluop_LW_SW;
				MemWrite<=0;
				Alu_src<=1;
				RegWrite<=1;
				end
//ori
			param.ori_opcode: 
				begin 
				RegDst<=0;
				J<=0;
				Beq<=0;
				Bneq<=0;
				MemRead<=0;
				MemtoReg<=1;
				Alu_op<= param.Aluop_or;
				MemWrite<=0;
				Alu_src<=2; //Zero extend
				RegWrite<=1;
				end
//xori
			param.xori_opcode: 
				begin 
				RegDst<=0;
				J<=0;
				Beq<=0;
				Bneq<=0;
				MemRead<=0;
				MemtoReg<=1;
				Alu_op<= param.Aluop_xor;
				MemWrite<=0;
				Alu_src<=2; //Zero extend
				RegWrite<=1;
				end				
//andi
			param.andi_opcode: 
				begin 
				RegDst<=0;
				J<=0;
				Beq<=0;
				Bneq<=0;
				MemRead<=0;
				MemtoReg<=1;
				Alu_op<= param.Aluop_and;
				MemWrite<=0;
				Alu_src<=2; //Zero extend
				RegWrite<=1;
				end	
//slti
			param.slti_opcode: 
				begin 
				RegDst<=0;
				J<=0;
				Beq<=0;
				Bneq<=0;
				MemRead<=0;
				MemtoReg<=1;
				Alu_op<= param.Aluop_slt;
				MemWrite<=0;
				Alu_src<=1;
				RegWrite<=1;
				end				
//***********************************J instructions******************************
//j			
			param.j_opcode: 
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
