`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 03/08/2022 10:49:40 AM
// Design Name:
// Module Name: CNTL
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module Datapath(
    input CLK,
    input Reset,
    output [31:0] Dout
);

    //internal wire
    //wire <define by user> <btw there are 5 of them :ded:>
    //but heres just 2 of them
    //PC
    wire [31:0] PC_Add_out, PC_Out, Inst_out, S, T;
    wire [31:0] ALUOut;
    wire RegWrite, RegDst;
    wire [3:0] ALUCntl;
    wire C, V, N, Z;
    wire [1:0] Branch;
    wire MemRead, MemWrite, MemToReg, ALUSrc, Jump;
    wire [4:0] OP_MuxA;
    wire [31:0] Inst_SE, OP_MuxB, OP_MuxC, OP_MuxD, OP_MuxJ, ReadData, B_Add, Jump_Add;

    // Mux A
    assign OP_MuxA = (RegDst) ? Inst_out[15:11] : Inst_out[20:16];

    // Sign Extend
    assign Inst_SE = {{16 {Inst_out[15]}}, Inst_out[15:0]};

    // Mux B
    assign B_Add = PC_Add_out + (Inst_SE << 2);
    assign OP_MuxB = ((Branch[0] & Z) | (Branch[1] & ~Z)) ? B_Add : PC_Add_out;

    // Mux C
    assign OP_MuxC = (ALUSrc) ? Inst_SE : T;

    // Mux D
    assign OP_MuxD = (MemToReg) ? ReadData : Dout;

    // Mux J
    // Jump Address    
    assign Jump_Add = {(PC_Add_out[31:28]), (Inst_out[25:0]), 2'b0};
    assign OP_MuxJ = (Jump) ? Jump_Add : OP_MuxB;

    //instantiate PC
    PC pc(.CLK(CLK), .Reset(Reset), .Din(OP_MuxJ), .PC_Out(PC_Out));

    //instantiate all the other modules. Good luck!

    PC_ADD pcadd(.Din(PC_Out),.PC_Add_out(PC_Add_out));

    CNTL control(.Op(Inst_out[31:26]), .Func(Inst_out[5:0]), .RegWrite(RegWrite), .ALUCntl(ALUCntl), .RegDst(RegDst), .Branch(Branch), .MemRead(MemRead), .MemWrite(MemWrite), .MemToReg(MemToReg), .ALUSrc(ALUSrc), .Jump(Jump));

    //instatiate instruction memory
    Instruction_Memory im(.Addr(PC_Out), .Inst_out(Inst_out));

    ALU alu(.A(S), .B(OP_MuxC), .ALUCntl(ALUCntl), .ALUOut(Dout), .C(C), .N(N), .V(V), .Z(Z));

    //Instantiate regfile
    regfile32 rf(.CLK(CLK), .Reset(Reset), .D_En(RegWrite), .D_Addr(OP_MuxA), .S_Addr(Inst_out[25:21]), .T_Addr(Inst_out[20:16]), .D(OP_MuxD), .S(S), .T(T));

    DataMem dm(.CLK(CLK), .MemWrite(MemWrite), .MemRead(MemRead), .Addr(Dout), .WriteData(T), .ReadData(ReadData));

    //then at the end, only Dout from ALUOut will be the one that outputs
    assign Dout = ALUOut;

endmodule
