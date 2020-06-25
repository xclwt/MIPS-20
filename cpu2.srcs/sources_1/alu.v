`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/09 17:53:28
// Design Name: 
// Module Name: alu
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


module alu(
    input [31:0] a,
    input [31:0] b,
    input [3:0] operation,
    output [31:0] f,
    output z
    );
    reg[31:0]result;
    always@(*)
    begin
        case(operation)
            4'b0000:result=32'b0;
            4'b0001:result=a+b;//º”∑®
            4'b0010:result=a-b;//ºı∑®
            4'b0011:result=a&b;//”Î
            4'b0100:result=a|b;//ªÚ
            4'b0101:result=a^b;//“ÏªÚ
            4'b0110:result=b<<a;//¬ﬂº≠◊Û“∆
            4'b0111:result=b>>a;//¬ﬂº≠”““∆
            4'b1000:result=b<<16;
            4'b1001:result=$signed(b)<<<a;//À„ ı◊Û“∆
            4'b1010:result=$signed(b)>>>a;//À„ ı”““∆
            default:result=32'b0;
        endcase
    end
    assign f=result;
    assign z=~(|result);
    
    initial
        $monitor($time,,"alu:a=%d,b=%h,operation=0b%b",a,b,operation);
    initial
        $monitor($time,,"alu:f=%d,z=0b%b",f,z);
endmodule

