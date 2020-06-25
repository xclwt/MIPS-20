`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/01 17:39:53
// Design Name: 
// Module Name: rom
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


module rom(
    input [31:0] addr,
    output [31:0] data
    );
    reg[31:0] romdata;
    always @(*)
        case(addr)//±àÐ´rom´æ´¢ÄÚÈÝ
        4'h0:romdata=32'h34040400;
        4'h4:romdata=32'hac841e00;
        ////4'h0:romdata=32'h00000026;   //xor $0, $0, $0
        //4'h4:romdata=32'h8c078000;   //lw $7, 8000h($0)
        4'h4:romdata=32'h34030000;   //ori $3, $0, 0
        4'h8:romdata=32'h34040001;   //ori $4, $0, 1
        8'hc:romdata=32'h8c078000;   //lw $7, 8000h($0)
        8'h10:romdata=32'h34060001;  // ori $6, $0, 1
        8'h14:romdata=32'h10e60006;  //beq $7, $6, 24 
        8'h18:romdata=32'h00641020;  //add $2, $3, $4 
        8'h1c:romdata=32'h20830000;  //addi $3, $4, 0
        8'h20:romdata=32'h20440000;  //addi $4, $2, 0
        8'h24:romdata=32'h20e7ffff;  //addi $7, $7, -1
        //8'h28:romdata=32'h00600008;  //jr $3
        8'h28:romdata=32'h14e6fffc;  //bne $7, $6, -16
        8'h2c:romdata=32'hac044000;  //sw $4, 4000h($0) 
        //8'h2c:romdata=32'h20850000;  //addi $5, $4, 0
        //8'h30:romdata=32'h00041043;  //sra $2, $4, 1
        //8'h34:romdata=32'h3408000a;  //ori $8, $0, 10
        //8'h38:romdata=32'h8c430001;  //lw $3, 1($2)  
        //default:romdata=32'h00000000;
        endcase
    assign data=romdata;
    initial 
    $monitor($time,,"rom:instrument=%h",data);
endmodule

