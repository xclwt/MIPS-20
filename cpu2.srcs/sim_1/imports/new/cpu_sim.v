`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/16 17:35:26
// Design Name: 
// Module Name: cpu_sim
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


module cpu_sim(

    );
    reg clk;
    reg rst=1'b1;
    //wire[31:0] addr;
    //wire[31:0] data;
    //reg[31:0] instrument;
    reg oc;
    wire[31:0] result;
    //时钟信号仿真
    initial 
        begin
            clk=1'b0;
            forever
                #2 clk=~clk;
        end
    //cpu实例化，传参switch(n)
    cpu mycpu(clk,oc,rst,4'b1010, result);

initial
        begin
            #1 rst=1'b0;
            #4 rst=1'b1;
        end
        
     initial
     $monitor($time, "result is 0x%d", result);
endmodule
