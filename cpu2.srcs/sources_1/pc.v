`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/01 16:11:52
// Design Name: 
// Module Name: pc
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


module pc(
    input clk,
    input rst,
    input [31:0] nextAddr,
    output reg [31:0] insAddr
    );
    always @(posedge clk)
    begin
        if(rst==1'b0)
            insAddr<=32'h0;    //��rst=0ʱ���г�ʼ������ʼָ��ĵ�ַΪ0
        else
            insAddr<=nextAddr; 
    end
    initial
        $monitor($time,,"pc:%h", insAddr);
endmodule

