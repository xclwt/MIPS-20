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
    input [31:0] pc4,       //˳��ִ��pc+4
    input [31:0] offset,    // bne��beq��ת
    input [31:0] rs,        //jr��ת
    input [25:0] target,    //jal��j��ת
    input [1:0] pcindex,
    output reg [31:0] nextAddr
    );
    
    always@(*)
    begin
        case(pcindex)
        2'b00:                  //˳��ִ��
        begin
            nextAddr <= pc4; 
        end
        2'b01:                  //beq��bne��ת
        begin
            nextAddr <= pc4 - 4 + (offset << 2);
        end
        2'b10:                  //jr��ת
        begin
            nextAddr <= rs;
        end
        2'b11:                  //ja1��j��ת
        begin
            nextAddr <= {pc4[31:28], 28'b0+target << 2};   //����
        end
        endcase
    end
    
    initial
        $monitor($time,,"offset=%b",offset);
endmodule
