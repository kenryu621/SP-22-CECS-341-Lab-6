`timescale 1ns / 1ps


module regfile32(
    input CLK,
    input Reset,
    input D_En,
    input [4:0] D_Addr,
    input [4:0] S_Addr,
    input [4:0] T_Addr,
    input [31:0] D,
    output wire [31:0] S,
    output wire [31:0] T
);

    //Instantiate 32 32-bit registers
    reg [31:0] regArray [0:31];

    //Assign S and T, specific contents of regArray
    assign S = regArray[S_Addr[4:0]];
    assign T = regArray[T_Addr[4:0]];

    //Write to regArray
    //regArray[0] inaccesible to overwriting 
    always@(posedge CLK, posedge Reset) begin
        if(Reset)
            regArray[0] <= 32'b0; else
            if(D_En && D_Addr)
                regArray[D_Addr[4:0]] <= D;
    end
endmodule

