`timescale 1ns / 1ps

module MIPS(clk,reset);
		 input clk,reset;
		 
		 wire [31:0] pc_in, pc_out, pc_next; // pc_in: new, pc_out: current, pc_next = pc+ 4
		 assign pc_next = pc_out + 4;
		 
		 wire [31:0] IR;
		 wire [5:0] opcode,funct;
		 wire [4:0] rs,rt,rd,shamt;
		 wire [25:0] J_imm;
		 wire [15:0] I_imm;
		 wire [31:0] I_imm_sign_extend, I_imm_zero_extend, J_imm_address;
		 
		 assign opcode = IR[31:26];
		 assign rs = IR[25:21];
		 assign rt = IR[20:16];
		 assign rd = IR[15:11];
		 assign shamt = IR[10:6];
		 assign funct = IR[5:0];
		 
		 assign J_imm = IR[25:0];
		 assign I_imm = IR[15:0];
		 assign I_imm_sign_extend = {16*{I_imm[15]}, I_imm};
		 assign I_imm_zero_extend = I_imm<<16;
		 assign J_imm_address = {{J_imm<<2} , {pc_next[31:28]}};
		 wire [4:0] rt_td_mux;
		 
		 wire [31:0] ReadData1, ReadData2;
		 wire RegDst, J, Beq,Bneq, MemRead, MemtoReg,MemWrite,RegWrite;
	    wire [1:0] Alu_src;  //00: reg, 01: Sign extend, 10: Zero extend
	    wire [2:0]  Alu_op;
		 
		 wire [31:0] Reg_ALU_mux1_out; //chose between sign and zero extend
		 wire [31:0] Reg_ALU_mux2_out; //chose between reg and Reg_ALU_mux1_out
		 
		 wire [31:0] ALU_A, ALU_B, ALU_result;
		 wire ALU_Zero;
		 wire [3:0] ALU_CU_out;
		 assign ALU_A = ReadData1;
		 assign ALU_B = Reg_ALU_mux2_out;
		 
		 wire [31:0] B_mux_out, J_mux_out; 
		 wire B_sel;
		 assign B_sel = (Beq & ALU_Zero) | (Bneq & (~(ALU_Zero)));
		 
		 wire [31:0] D_Mem_out,D_Mem_write_data, D_Mem_Address;
		 wire [31:0] D_Mem_ALU_mux_out;
		 
		 
		 PC pc(.PC_in(pc_in),.PC_out(pc_out),.reset(reset));
		 Instruction_Mem I_Mem (.IR(IR),.PC(pc_out),.clk(clk));
		 
		 mux2_5 I_Mem_Reg(.out(rt_td_mux),.in1(rt),.in2(rd),.sel(RegDst));
		 regFile reg_file (.ReadData1(ReadData1), .ReadData2(ReadData2), 
								 .RegWrite(RegWrite), .Rs(rs), .Rt(rt), .Rd(rd), 
								 .data(D_Mem_ALU_mux_out),.clk(clk));
		  
		  
		 Control_Unit CU ( .RegDst(RegDst), .J(J), .Beq(Beq), .Bneq(Bneq), 
								.MemRead(MemRead), .MemtoReg(MemtoReg),  .Alu_op(Alu_op),
								.MemWrite(MemWrite),.Alu_src(Alu_src),.RegWrite(RegWrite),
								.opcode(opcode));
		 
		 mux2 Reg_ALU1(.out(Reg_ALU_mux1_out),.in1(I_imm_sign_extend),
							.in2(I_imm_zero_extend),.sel(Alu_src[0]));
		 mux2 Reg_ALU2(.out(Reg_ALU_mux2_out),.in1(Reg_ALU_mux2_out),.in2(ReadData2),
							.sel(Alu_src[1]));
		 ALU_Control ALU_CU (.Alu_control(ALU_CU_out), .Alu_op(Alu_op), 
		 							.funct_field(funct));
		 
		 ALU ALU (.Zero(ALU_Zero),.Alu_result(ALU_result),.A(ALU_A),.B(ALU_B)
						,.Alu_control(ALU_CU_out));
			
		 mux2 Branch_PC (.out(B_mux_out),.in1( (I_imm_sign_extend<<2) + 4), 
							  .in2(pc_next), .sel(B_sel));
		 mux2 J_PC (.out(pc_out), .in1(B_mux_out), .in2(J_imm_address),.sel(J));
		 
		 Data_Mem D_Mem ( .ReadData(D_Mem_out), .Address(D_Mem_Address), 
								.WriteData(D_Mem_write_data), .MemRead(MemRead), 
								.MemWrite(MemWrite),.clk(clk));
								
		 mux2 ALU_D_Mem (.out(D_Mem_ALU_mux_out), .in1(ALU_result),.in2(D_Mem_out),
								.sel(MemtoReg));

endmodule
