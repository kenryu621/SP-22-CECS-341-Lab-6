`timescale 1ns / 1ps


module DataMem(
    input CLK,
    input MemWrite,
    input MemRead,
    input [31:0] Addr,
    input [31:0] WriteData,
    output [31:0] ReadData
    );
    
    reg [7:0] dmem [0:4095];
    
    // write 
    always@(posedge CLK) begin
        if(MemWrite) begin
            dmem[Addr[11:0] + 2'd3] <= WriteData[7:0];
            dmem[Addr[11:0] + 2'd2] <= WriteData[15:8];
            dmem[Addr[11:0] + 2'd1] <= WriteData[23:16];
            dmem[Addr[11:0] + 2'd0] <= WriteData[31:24];
        end      
    end
    
    //read
    assign ReadData = (MemRead) ? { dmem[Addr[11:0] + 2'd0],
                                    dmem[Addr[11:0] + 2'd1],
                                    dmem[Addr[11:0] + 2'd2],
                                    dmem[Addr[11:0] + 2'd3] } 
                                    : 32'hz;
                                  
           
endmodule
