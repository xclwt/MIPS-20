`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/01 17:09:15
// Design Name: 
// Module Name: extend
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


module extend(
    input [15:0] immediate_16,
    input sign_ext,         //1£∫∑˚∫≈ 0£∫¡„¿©’π
    output reg[31:0] immediate_32
    );   
    
    always @(*)
    begin
        case(sign_ext)
            1'b0:   //¡„¿©’π
            begin
                immediate_32 <= {16'h0000,immediate_16};
            end
            1'b1:   //∑˚∫≈¿©’π
            begin
                if(immediate_16[15] == 0)
                    immediate_32 <= {16'h0000,immediate_16};
                else
                    immediate_32 <= {16'hffff,immediate_16};
            end
        endcase
    end
    initial
    $monitor($time,,"sign_ext=%h",sign_ext);
    initial 
    $monitor($time,,"immediate_32=%h",immediate_32);    
endmodule
