`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/16 14:09:40
// Design Name: 
// Module Name: selector
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


module selector(
    input [31:0] pc4,       //顺序执行pc+4
    input [31:0] offset,    // bne、beq跳转
    input [31:0] rs,        //jr跳转
    input [25:0] target,    //jal、j跳转
    input [1:0] pcindex,
    output reg [31:0] nextAddr
    );
    
    always@(*)
    begin
        case(pcindex)
        2'b00:                  //顺序执行
        begin
            nextAddr <= pc4; 
        end
        2'b01:                  //beq、bne跳转
        begin
            nextAddr <= pc4 - 4 + (offset << 2);
        end
        2'b10:                  //jr跳转
        begin
            nextAddr <= rs;
        end
        2'b11:                  //ja1、j跳转
        begin
            nextAddr <= {pc4[31:28], 28'b0+target << 2};   //存疑
        end
        endcase
    end
    
    initial
        $monitor($time,,"offset=%b",offset);
endmodule
