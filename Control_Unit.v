`timescale 1ns / 1ps

module Control_Unit( RegDst, J, Beq, Bneq, MemRead, MemtoReg, Alu_op,MemWrite,Alu_src,RegWrite, opcode,reset);
	output reg  RegDst, J, Beq,Bneq, MemRead, MemtoReg,MemWrite,RegWrite;
	output reg [1:0] Alu_src;  //00: reg, 01: Sign extend, 10: Zero extend
	output reg [2:0]  Alu_op;
	input [5:0] opcode;
	input reset;
	
	parameters p();
	
	always @(*)
	begin
	if (reset) 
	begin
		 RegDst<=0;
		 J<=0; Beq<=0; Bneq<=0; MemRead<=0; MemtoReg<=0; MemWrite<=0; RegWrite<=0; Alu_op<=0; Alu_src<=0;
	end
	else
		case (opcode)
//***********************************R-Type instructions********************
//all R-type except shift and jr instructions		
			p.R_opcode: 
				begin 
				RegDst<=1;
				J<=0;
				Beq<=0; 
				Bneq<=0;
				MemRead<=0;
				MemtoReg<=0;
				Alu_op<= p.Aluop_R;
				MemWrite<=0;
				Alu_src<=0;
				RegWrite<=1;
				end
//***********************************I-Type instructions********************
//beq				
			 p.beq_opcode: 
				begin 
				RegDst<=1'b x;
				J<=0;
				Beq<=1;
				Bneq<=0;	
				MemRead<=0;
				MemtoReg<=1'b x;
				Alu_op<= p.Aluop_add;
				MemWrite<=0;
				Alu_src<=0;
				RegWrite<=0;
				end
//bneq				
			p.bne_opcode: 
				begin 
				RegDst<=1'b x;
				J<=0;
				Beq<=0;
				Bneq<=1;	
				MemRead<=0;
				MemtoReg<=1'b x;
				Alu_op<= p.Aluop_add;
				MemWrite<=0;
				Alu_src<=0;
				RegWrite<=0;
				end
//lw
			p.lw_opcode: 
				begin 
				RegDst<=0;
				J<=0;
				Beq<=0;
				Bneq<=0;
				MemRead<=1;
				MemtoReg<=1;
				Alu_op<= p.Aluop_add;
				MemWrite<=0;
				Alu_src<=1;
				RegWrite<=1;
				end	
//sw
			p.sw_opcode: 
				begin 
				RegDst<=1'b x;
				J<=0;
				Beq<=0;
				Bneq<=0;
				MemRead<=0;
				MemtoReg<=1'b x;
				Alu_op<= p.Aluop_add;
				MemWrite<=1;
				Alu_src<=1;
				RegWrite<=0;
				end				
//addi
			p.addi_opcode: 
				begin 
				RegDst<=0;
				J<=0;
				Beq<=0;
				Bneq<=0;
				MemRead<=0;
				MemtoReg<=0;
				Alu_op<= p.Aluop_add;
				MemWrite<=0;
				Alu_src<=1;
				RegWrite<=1;
				end
//subi
			p.addi_opcode: 
				begin 
				RegDst<=0;
				J<=0;
				Beq<=0;
				Bneq<=0;
				MemRead<=0;
				MemtoReg<=0;
				Alu_op<= p.Aluop_sub;
				MemWrite<=0;
				Alu_src<=1;
				RegWrite<=1;
				end
//ori
			p.ori_opcode: 
				begin 
				RegDst<=0;
				J<=0;
				Beq<=0;
				Bneq<=0;
				MemRead<=0;
				MemtoReg<=0;
				Alu_op<= p.Aluop_or;
				MemWrite<=0;
				Alu_src<=2; //Zero extend
				RegWrite<=1;
				end
//xori
			p.xori_opcode: 
				begin 
				RegDst<=0;
				J<=0;
				Beq<=0;
				Bneq<=0;
				MemRead<=0;
				MemtoReg<=0;
				Alu_op<= p.Aluop_xor;
				MemWrite<=0;
				Alu_src<=2; //Zero extend
				RegWrite<=1;
				end				
//andi
			p.andi_opcode: 
				begin 
				RegDst<=0;
				J<=0;
				Beq<=0;
				Bneq<=0;
				MemRead<=0;
				MemtoReg<=0;
				Alu_op<= p.Aluop_and;
				MemWrite<=0;
				Alu_src<=2; //Zero extend
				RegWrite<=1;
				end	
//slti
			p.slti_opcode: 
				begin 
				RegDst<=0;
				J<=0;
				Beq<=0;
				Bneq<=0;
				MemRead<=0;
				MemtoReg<=0;
				Alu_op<= p.Aluop_slt;
				MemWrite<=0;
				Alu_src<=1;
				RegWrite<=1;
				end				
//***********************************J instructions******************************
//j			
			p.j_opcode: 
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
