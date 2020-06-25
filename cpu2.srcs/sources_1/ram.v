`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/01 17:00:14
// Design Name: 
// Module Name: ram
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


module ram(
    input [12:0] addr,
    input [31:0] wdata,
    input clk,
    //input ce,
    input we1,
    output reg [31:0] rdata
    );
    //reg [31:0] rdata;
    reg [12:0] ram[0:2048];
    always @(*)		//只要有输入就立即输出
      begin
          //if(we1 == 1'b0)        //使能端
          begin
              rdata <= ram[addr];
          end
      end
    initial
          $monitor($time,,"R ram[%d]=%d",addr,rdata);
    always @(posedge clk)		//脉冲信号作用下才能写
        begin
            #1 if(we1 == 1'b1)  //判断使能端是否为1
            begin
                ram[addr] <= wdata;
            end
        end
    initial
    $monitor($time,,"W ram[%d]=%d",addr,wdata);
    initial
    $monitor($time,,"we=%d, addr=%d, wdata=%d, ram[512]=%d",we1, addr,wdata,ram[512]);

        initial
    $monitor($time,,"rdata=%d",rdata);
endmodule

