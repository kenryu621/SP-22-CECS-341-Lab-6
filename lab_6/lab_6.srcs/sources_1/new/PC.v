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


module PC(
    input CLK, Reset,
    input [31:0] Din,
    output reg [31:0] PC_Out
);

    initial begin
        PC_Out <= 32'h00000000;
    end

    always@(posedge CLK, posedge Reset) begin
        if (Reset == 1) begin
            PC_Out <= 32'h00000000;
        end
        else begin
            PC_Out <= Din;
        end
    end
endmodule
