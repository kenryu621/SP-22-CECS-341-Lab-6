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


module CNTL(
    input [5:0] Op, Func,
    output reg RegWrite,
    output reg [3:0] ALUCntl,
    output reg RegDst,
    output reg [1:0] Branch,
    output reg MemRead,
    output reg MemWrite,
    output reg MemToReg,
    output reg ALUSrc,
    output reg Jump
);

    always@(*) begin
        if(Op == 6'b0) begin
            RegWrite = 1'b1;
            RegDst = 1'b1;
            Branch = 2'b00;
            MemRead = 1'b0;
            MemWrite = 1'b0;
            MemToReg = 1'b0;
            ALUSrc = 1'b0;
            Jump = 1'b0;
            case(Func)
                6'h20: ALUCntl = 4'b1010; // Add Signed
                6'h21: ALUCntl = 4'b0010; // Add Unsigned
                6'h22: ALUCntl = 4'b1110; // Subtract Signed
                6'h23: ALUCntl = 4'b0110; // Subtract Unsigned
                6'h24: ALUCntl = 4'b0000; // AND gate
                6'h25: ALUCntl = 4'b0001; // OR gate
                6'h26: ALUCntl = 4'b0011; // XOR gate
                6'h27: ALUCntl = 4'b1100; // NOR gate
                6'h2A: ALUCntl = 4'b0101; // Set Less Than Signed
                6'h2B: ALUCntl = 4'b1011; // Set Less Than Unsigned
                default: ALUCntl = 4'bxxxx; // Default
            endcase
        end
        else begin
            case(Op)
                6'h08: begin // addi
                    RegWrite = 1'b1;
                    RegDst = 1'b0;
                    Branch = 2'b00;
                    MemRead = 1'b0;
                    MemToReg = 1'b0;
                    MemWrite = 1'b0;
                    ALUSrc = 1'b1;
                    ALUCntl = 4'b1010;
                    Jump = 1'b0;
                end

                6'h09: begin // addiu
                    RegWrite = 1'b1;
                    RegDst = 1'b0;
                    Branch = 2'b00;
                    MemRead = 1'b0;
                    MemToReg = 1'b0;
                    MemWrite = 1'b0;
                    ALUSrc = 1'b1;
                    ALUCntl = 4'b0010;
                    Jump = 1'b0;
                end

                6'h0C: begin // andi
                    RegWrite = 1'b1;
                    RegDst = 1'b0;
                    Branch = 2'b00;
                    MemRead = 1'b0;
                    MemToReg = 1'b0;
                    MemWrite = 1'b0;
                    ALUSrc = 1'b1;
                    ALUCntl = 4'b0000;
                    Jump = 1'b0;
                end

                6'h0D: begin //ori
                    RegWrite = 1'b1;
                    RegDst = 1'b0;
                    Branch = 2'b00;
                    MemRead = 1'b0;
                    MemToReg = 1'b0;
                    MemWrite = 1'b0;
                    ALUSrc = 1'b1;
                    ALUCntl = 4'b0001;
                    Jump = 1'b0;
                end

                6'h23: begin // lw
                    RegWrite = 1'b1;
                    RegDst = 1'b0;
                    Branch = 2'b00;
                    MemRead = 1'b1;
                    MemToReg = 1'b1;
                    MemWrite = 1'b0;
                    ALUSrc = 1'b1;
                    ALUCntl = 4'b1010;
                    Jump = 1'b0;
                end

                6'h2B:begin // sw
                    RegWrite = 1'b0;
                    RegDst = 1'b0;
                    Branch = 2'b00;
                    MemRead = 1'b0;
                    MemToReg = 1'b0;
                    MemWrite = 1'b1;
                    ALUSrc = 1'b1;
                    ALUCntl = 4'b1010;
                    Jump = 1'b0;
                end

                6'h04: begin //beq
                    RegWrite = 1'b0;
                    RegDst = 1'b0;
                    Branch = 2'b01;
                    MemRead = 1'b0;
                    MemToReg = 1'b0;
                    MemWrite = 1'b0;
                    ALUSrc = 1'b0;
                    ALUCntl = 4'b1110;
                    Jump = 1'b0;
                end

                6'h05: begin //bne
                    RegWrite = 1'b0;
                    RegDst = 1'bx;
                    Branch = 2'b10;
                    MemRead = 1'b0;
                    MemToReg = 1'bx;
                    MemWrite = 1'b0;
                    ALUSrc = 1'b0;
                    ALUCntl = 4'b1110;
                    Jump = 1'b0;
                end

                6'h0A: begin // slti
                    RegWrite = 1'b1;
                    RegDst = 1'b0;
                    Branch = 2'b00;
                    MemRead = 1'b0;
                    MemToReg = 1'b0;
                    MemWrite = 1'b0;
                    ALUSrc = 1'b1;
                    ALUCntl = 4'b0101;
                    Jump = 1'b0;
                end

                6'h0B: begin // sltiu
                    RegWrite = 1'b1;
                    RegDst = 1'b0;
                    Branch = 2'b00;
                    MemRead = 1'b0;
                    MemToReg = 1'b0;
                    MemWrite = 1'b0;
                    ALUSrc = 1'b1;
                    ALUCntl = 4'b1011;
                    Jump = 1'b0;
                end
                
                6'h02: begin // unconditional jump
                    RegWrite = 1'b0;
                    RegDst = 1'b0;
                    Branch = 2'b00;
                    MemRead = 1'b0;
                    MemToReg = 1'b0;
                    MemWrite = 1'b0;
                    ALUSrc = 1'b0;
                    ALUCntl = 4'bxxxx;
                    Jump = 1'b1;
                end

                default: begin
                    RegWrite = 1'bx;
                    RegDst = 1'bx;
                    Branch = 2'bxx;
                    MemRead = 1'bx;
                    MemToReg = 1'bx;
                    MemWrite = 1'bx;
                    ALUSrc = 1'bx;
                    ALUCntl = 4'bxxxx;
                    Jump = 1'bx;
                end
            endcase
        end
    end
endmodule
