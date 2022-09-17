`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/03/2022 12:46:58 AM
// Design Name: 
// Module Name: Datapath_TB
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


module Datapath_TB();

    //step 1: define data structure

    reg CLK, Reset;
    wire [31:0] Dout;
    integer i;

    //instantiate datapath uut
    Datapath uut( .CLK(CLK), .Reset(Reset), .Dout(Dout));

    //create a clock genereator (logic)
    always begin
        #10 CLK = ~CLK;
    end

    //define a task to read the value of the register file
    task Read_Data_Mem;
        begin
            $timeformat (-9, 1, "ns", 9);
            for(i=20;i<=32;i=i+4) begin
                @(posedge CLK)
                $display ("t=%t dm[%0d] %h", $time, i, {uut.dm.dmem[i], uut.dm.dmem[i+1], uut.dm.dmem[i+2], uut.dm.dmem[i+3]});
            end
        end
    endtask


    // start testing logic
    initial begin
        CLK = 0;
        Reset = 1;
        #20 Reset = 0;

        //time to use some strange functions (info about them in Lab4_Inro_and_Verilog (slide 26)
        $readmemh("imem.dat", uut.im.imem);
        $readmemh("DataMem.dat", uut.dm.dmem);

        #900 Reset = 0;
        Read_Data_Mem;
        $finish;
    end

endmodule
