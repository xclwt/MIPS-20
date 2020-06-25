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
    input [31:0] addr,  //��ַ
    input [31:0] din,   //�ڴ���������
    input we,           //�ڴ�ʹ�ܶ�
    input clk,          
    output [31:0] dout, //�ڴ�򿪹ػ������
    input [3:0] switch, //������������
    output reg[31:0] displaydata    //�����led����
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
