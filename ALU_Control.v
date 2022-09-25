`timescale 1ns / 1ps

/*
@brief: Alu_Control takes, (6-bit) funct_field and (2-bit) Alu_op to produce (4-bits) ALu_control

@param  Alu_op: 2-bit signal from main control unit to determine the instruction type
					whether LW/SW (00), Branch (01), R(10). 
@param funct_filed: 	instruction [0:5] 
@param Alu_control: output signal to ALU.				

*/

module ALU_Control(Alu_control, Alu_op, funct_field,reset);
		output reg [3:0] Alu_control;
		input [5:0] funct_field;
		input [2:0] Alu_op;
		input reset;
		
		parameters p();
		
		always @(*)
		begin
		if (reset) Alu_control<=0; 
		else
			case (Alu_op)
				p.Aluop_add:   Alu_control <= p.Alu_add;
				p.Aluop_sub:	Alu_control <= p.Alu_sub;	
				p.Aluop_R:
					begin
						case (funct_field)
							p.add_funct:   Alu_control <= p.Alu_add;
							p.sub_funct:   Alu_control <= p.Alu_sub;
							p.and_funct:   Alu_control <= p.Alu_and;
							p.or_funct:    Alu_control <= p.Alu_or;
							p.xor_funct:   Alu_control <= p.Alu_xor;
							p.nor_funct:   Alu_control <= p.Alu_nor;
							p.slt_funct:   Alu_control <= p.Alu_slt;
							p.mul_funct:	Alu_control <= p.Alu_mul;
						endcase
					end						
		endcase
		end
		
endmodule
