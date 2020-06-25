`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/01 16:26:33
// Design Name: 
// Module Name: ControlUnit
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


module ControlUnit(
    input [5:0] opcode,         //指令类型
    input [5:0] func,           //指令功能码
    input z,                    //判断
    output reg [1:0] pcindex,   //pc来源
    output reg ram2reg,         //是否将数据从ram写到reg
    output reg ramWE,           //ram写信号
    output reg [3:0] aluOP,     //alu运算类型
    output reg regWE,           //reg写信号
    output reg imm,             //立即数信号
    output reg shift,           //移位信号
    output reg isrt,            //1：rd 0：rt
    output reg sign_ext,        //1：符号扩展 0：零扩展
    output reg jal              //跳转信号
    );
    
    always @(*)
    begin
        shift <= 1'b0;
        ram2reg <= 1'b0;
        ramWE = 1'b0;
        regWE <= 1'b0;
        imm <= 1'b0;
        isrt <= 1'b0;   //isrt为0选择rt，为1选择rd
        sign_ext <= 1'b0;
        pcindex <= 2'b0;
        aluOP <= 4'b0;
        jal <= 1'b0;
        
        case(opcode)
            6'b000000:
            begin
                case(func)
                    6'b100000:  //add
                    begin
                        aluOP <= 4'b0001;
                        regWE <= 1'b1;
                        isrt <= 1'b1;
                    end
                    6'b100010:  //sub
                    begin
                        aluOP <= 4'b0010;
                        regWE <= 1'b1;
                        isrt <= 1'b1;
                    end
                    6'b100100:  //and
                    begin
                        aluOP <= 4'b0011;
                        regWE <= 1'b1;
                        isrt <= 1'b1;
                    end
                    6'b100101:  //or
                    begin
                        aluOP <= 4'b0100;
                        regWE <= 1'b1;
                        isrt <= 1'b1;
                    end
                    6'b100110:  //xor
                    begin
                        aluOP <= 4'b0101;
                        regWE <= 1'b1;
                        isrt <= 1'b1;
                    end
                    6'b000000:  //sll
                    begin
                        aluOP <= 4'b0110;
                        regWE <= 1'b1;
                        shift <= 1'b1;
                        isrt <= 1'b1;
                    end
                    6'b000010:  //srl
                    begin
                        aluOP <= 4'b0111;
                        regWE <= 1'b1;
                        shift <= 1'b1;
                        isrt <= 1'b1;
                    end
                    6'b000011:  //sra
                    begin
                        aluOP<=4'b1010;
                        //jal <= 1'b0;
                        regWE <= 1'b1;
                        shift <= 1'b1;
                        isrt <= 1'b1;
                    end
                    6'b001000:  //jr
                    begin
                        pcindex <= 2'b10;
                    end
                 endcase
            end
            6'b001000:  //addi
            begin
                regWE <= 1'b1;
                aluOP <= 4'b0001;
                sign_ext <= 1'b1;
                imm<=1'b1;
            end
            6'b001100:  //andi
            begin
                regWE <= 1'b1;
                aluOP <= 4'b0011;
                imm<=1'b1;
            end
            6'b001101:  //ori
            begin
                regWE <= 1'b1;
                aluOP <= 4'b0100;
                imm<=1'b1;
            end
            6'b001110:  //xori
            begin
                regWE <= 1'b1;
                aluOP <= 4'b0101;
                imm<=1'b1;
            end
            6'b100011:  //lw,关于offset，15，14位为操作识别码，13位为计算进位，丢弃，0-12位是有效地址位
            begin
                ram2reg <= 1'b1;
                aluOP <= 4'b0001;
                //sign_ext <= 1'b1;
                imm<=1'b1;
            end
            6'b101011:  //sw，offset设计同lw
            begin
                ramWE <= 1'b1;
                aluOP <= 4'b0001;
                //sign_ext <= 1'b1;
                imm<=1'b1;
            end
            6'b000100:  //beq
            begin
                aluOP <= 4'b0010;
                sign_ext <= 1'b1;
                if(z != 0)
                    pcindex <= 2'b01;
            end
            6'b000101:  //bne
            begin
                aluOP <= 4'b0010;
                sign_ext <= 1'b1;
                if(z == 0)
                     pcindex <= 2'b01;
            end
            6'b001111:  //lui
            begin
                regWE <= 1'b1;
                imm <= 1'b1;
                aluOP <= 4'b1000;
            end
            6'b000010:  //j
            begin
                pcindex <= 2'b11;
            end
            6'b000011:  //jal
            begin
                jal <= 1'b1;
                pcindex <= 2'b11;
                regWE <= 1'b1;
            end
        endcase
    end
endmodule
