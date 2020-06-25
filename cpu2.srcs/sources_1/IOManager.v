`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/18 20:53:51
// Design Name: 
// Module Name: IOManager
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


module IOManager(
    input [31:0] addr,  //地址
    input [31:0] din,   //内存输入数据
    input we,           //内存使能端
    input clk,          
    output [31:0] dout, //内存或开关获得数据
    input [3:0] switch, //开关输入数据
    output reg[31:0] displaydata    //输出到led数据
    );
    
    reg[31:0] indata, outdata;
    wire[31:0] ramout;
    wire ramWE, enable;
    
    assign enable = ~(|addr[15:14]);
    ram my_ram(addr[12:0], din, clk, ramWE, ramout);
    assign dout = addr[15]?{{28{1'b0}}, switch}:ramout;
    assign ramWE = we&(~addr[14]); 
    
    always @(posedge clk)
    begin
    if((addr[14] == 1'b1) && we)
        displaydata <= din;
    end
endmodule
