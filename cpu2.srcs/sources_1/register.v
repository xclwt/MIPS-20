`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/09 14:32:15
// Design Name: 
// Module Name: register
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


module register(
    input clk,
    input oc,
    input [4:0] raddr1,     //读地址1
    input [4:0] raddr2,     //读地址2
    input [4:0] waddr,      //写地址
    input [31:0] wdata,     //写数据
    input we,       //使能端，读写信号
    output reg [31:0] rdata1,
    output reg [31:0] rdata2
    );
    //reg [31:0] rdata1;
    //reg [31:0] rdata2;
    reg [31:0] regts[1:31]; //0号寄存器固定为32'b0
    //读端口1
    always @(*) 
    begin
        if(oc == 1'b1)
        begin
            rdata1 <= 32'b0;        
        end
        else if(raddr1 == 5'b00000)     //$0号寄存器只保存0
        begin
            rdata1 <= 32'b0;
        end
        else 
        begin
            rdata1 <= regts[raddr1];
        end
    end

 
    //读端口2
    always @(*)
        begin
            if(oc == 1'b1)
            begin
                rdata2 <= 32'b0;
            end
            else if(raddr2 == 5'b00000)
            begin
                rdata2 <= 32'b0;
            end
            else
            begin
                rdata2 <= regts[raddr2];
            end
        end
        
    always @(posedge clk)   //脉冲信号作用下才能写
        begin
            #1 if((we == 1'b1) &&(waddr != 5'b00000))      //判断使能端是否为1，是否为0号地址，0号寄存器不可写
            begin
                regts[waddr] <= wdata;
            end
        end
    initial
        $monitor($time,,"regts[2]=%d",regts[2]);    
    initial
        $monitor($time,,"regts[3]=%d",regts[3]); 
    initial
        $monitor($time,,"regts[4]=%d",regts[4]);
    initial
        $monitor($time,,"regts[5]=%d",regts[5]);
    initial
        $monitor($time,,"regts[6]=%d",regts[6]);
    initial
        $monitor($time,,"regts[7]=%d",regts[7]); 
endmodule

