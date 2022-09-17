`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 02/15/2022 11:22:50 AM
// Design Name:
// Module Name: alu
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


module ALU(
    input [31:0] A,
    input [31:0] B,
    input [3:0] ALUCntl,
    output reg [31:0] ALUOut,
    output reg N,
    output reg Z,
    output reg C,
    output reg V
);

    localparam ZERO = 1'b0;
    reg [31:0] B2;
    reg signed[31:0] A_s;
    reg signed[31:0] B_s;
    // All inputs are in the sensitivity list
    always@(*) begin // or always@(A, B, ALUCntl) begin
        case(ALUCntl)

            // AND gate
            4'b0000: begin
                ALUOut = A & B;
                Z = ALUOut == ZERO;
                N = ALUOut[31];
                V = 1'dx;
                C = 1'dx;
            end

            // OR gate
            4'b0001: begin
                ALUOut = A | B;
                Z = ALUOut == ZERO;
                N = ALUOut[31];
                V = 1'dx;
                C = 1'dx;
            end

            // XOR gate
            4'b0011: begin
                ALUOut = A ^ B;
                Z = ALUOut == ZERO;
                N = ALUOut[31];
                V = 1'dx;
                C = 1'dx;
            end

            //  Addition Unsigned
            4'b0010: begin
                {C, ALUOut} = A + B;
                V = C;
                Z = ALUOut == ZERO;
                N = ALUOut[31];
            end

            // Subtraction Unsigned
            4'b0110: begin
                {C, ALUOut} = A + (-B);
                V = C;
                Z = ALUOut == ZERO;
                N = ALUOut[31];
            end

            // NOR gate
            4'b1100: begin
                ALUOut = ~(A | B);
                Z = ALUOut == ZERO;
                N = ALUOut[31];
                V = 1'dx;
                C = 1'dx;
            end

            // NOT gate
            4'b0111: begin
                ALUOut = ~A;
                Z = ALUOut == ZERO;
                N = ALUOut[31];
                V = 1'dx;
                C = 1'dx;
            end

            // Shift left logical
            4'b1101: begin
                {C, ALUOut} = A<<1;
                Z = ALUOut == ZERO;
                V = 1'dx;
                N = ALUOut[31];
            end

            // Addition Signed
            4'b1010: begin
                {C, ALUOut} = A + B;
                V = ((A[31] & B[31] & ~ALUOut[31]) | (~A[31] & ~B[31] & ALUOut[31])) ? 1'b1 : 1'b0;
                Z = ALUOut == ZERO;
                N = ALUOut[31];
            end

            // Subtraction Signed
            4'b1110: begin
                B2 = ~B + 1'b1;
                {C, ALUOut} = A + B2;
                V = ((A[31] & B[31] & ~ALUOut[31]) | (~A[31] & ~B[31] & ALUOut[31])) ? 1'b1 : 1'b0;
                Z = ALUOut == ZERO;
                N = ALUOut[31];
            end

            // Set Less Than Signed
            4'b0101: begin
                ALUOut = A[31] ^ B[31] ? A[31] : (A < B);
                Z = ALUOut == ZERO;
                N = ALUOut[31];
                V = 1'dx;
                C = 1'dx;
            end

            // Set Less Than Unsigned
            4'b1011: begin
                ALUOut = A < B ? 32'b1 : 32'b0;
                Z = ALUOut == ZERO;
                N = ALUOut[31];
                V = 1'dx;
                C = 1'dx;
            end

            // Default
            default: begin
                ALUOut = 32'dx;
                C = 1'dx;
                Z = 1'dx;
                V = 1'dx;
                N = 1'dx;
            end
        endcase
    end


endmodule
