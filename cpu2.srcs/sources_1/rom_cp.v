`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/18 12:02:12
// Design Name: 
// Module Name: rom_cp
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


module rom_cp(
    input [31:0] addr,
    output [31:0] data
    );
    reg[31:0] romdata;
    always @(*)
        case(addr)//±àÐ´rom´æ´¢ÄÚÈÝ
        4'h0:romdata=32'h34020007;   //ori $2, $0, 7
        4'h4:romdata=32'h34030008;   //ori $3, $0, 8
        4'h8:romdata=32'h20620009;   //addi $2, $3, 9
        8'hc:romdata=32'h3062000b;   //andi $2, $3, 11
        8'h10:romdata=32'h3862000f;  // xori $2, $3, 15
        8'h14:romdata=32'h00432020;  //add $4, $2, $3 
        8'h18:romdata=32'h00432022;  //sub $4, $2, $3 
        8'h1c:romdata=32'h00432024;  //and $4, $2, $3
        8'h20:romdata=32'h00432025;  //or $4, $2, $3 
        8'h24:romdata=32'h00432026;  //xor $4, $2, $3 
        //8'h28:romdata=32'h00600008;  //jr $3
        8'h28:romdata=32'h00041080;  //sll $2, $4, 2 
        8'h2c:romdata=32'h00041842;  //srl $3, $4, 1
        8'h30:romdata=32'h00041043;  //sra $2, $4, 1
        8'h34:romdata=32'h3408000a;  //ori $8, $0, 10
        8'h38:romdata=32'h8c430001;  //lw $3, 1($2)  
        default:romdata=32'h00000000;
        endcase
    assign data=romdata;
    initial 
    $monitor($time,,"rom:instrument=%h",data);
endmodule
