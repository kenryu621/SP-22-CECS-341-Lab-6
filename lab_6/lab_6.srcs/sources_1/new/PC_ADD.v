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


module PC_ADD(
    input [31:0] Din,
    output reg [31:0] PC_Add_out
);

    always@(*) begin
        PC_Add_out = Din + 4'b0100;
    end
endmodule
