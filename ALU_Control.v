`timescale 1ns / 1ps

/*
@brief: Alu_Control takes, (6-bit) funct_field and (2-bit) Alu_op to produce (4-bits) ALu_control

@param  Alu_op: 2-bit signal from main control unit to determine the instruction type
					whether LW/SW (00), Branch (01), R(10). 
@param funct_filed: 	instruction [0:5] 
@param Alu_control: output signal to ALU.				

*/

module ALU_Control(Alu_control, Alu_op, funct_field);
		output reg [3:0] Alu_control;
		input [5:0] funct_field;
		input [2:0] Alu_op;
		
		parameters param();	//instance from parameters module
		
		always @(Alu_op,funct_field)
		begin
			case (Alu_op)
				param.Aluop_LW_SW:  Alu_control <= param.Alu_add;
				param.Aluop_Branch:  Alu_control <= param.Alu_add;
				param.Aluop_R:
					begin
						case (funct_field)
							param.add_funct:  Alu_control <= param.Alu_add;
							param.sub_funct:  Alu_control <= param.Alu_sub;
							param.and_funct:  Alu_control <= param.Alu_and;
							param.or_funct:   Alu_control <= param.Alu_or;
							param.xor_funct:   Alu_control <= param.Alu_xor;
							param.xor_funct:   Alu_control <= param.Alu_nor;
							param.slt_funct:   Alu_control <= param.Alu_slt;
						endcase
					end
				param.Aluop_or:	Alu_control <= param.Alu_or;
				param.Aluop_xor:	Alu_control <= param.Alu_xor;
				param.Aluop_slt:	Alu_control <= param.Alu_slt;
						
		endcase
		end
		
endmodule
