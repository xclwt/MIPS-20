`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/16 15:04:12
// Design Name: 
// Module Name: selector2
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


module selector2(
    input [31:0] a,
    input [31:0] b,
    input sel,
    output reg [31:0] result
    );
    
    always @(*)
    begin
        case(sel)
        1'b0:
        begin
            result <= a;
        end
        1'b1:
        begin
            result <= b;
        end
        endcase
    end
endmodule
