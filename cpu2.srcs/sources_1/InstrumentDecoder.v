`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/01 16:13:17
// Design Name: 
// Module Name: InstrumentDecoder
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


module InstrumentDecoder(
    input [31:0] instrument,     //指令
    output reg[5:0] opcode,     //类型
    output reg[5:0] func,       //功能码
    output reg[4:0] rs,
    output reg[4:0] rt,
    output reg[4:0] rd,
    output reg[4:0] sa,
    output reg[15:0] immediate,
    output reg[25:0] addr
    );
    
    always @(*)
    begin
        opcode <= instrument[31:26];
        rs <= 5'b0;
        rt <= 5'b0;
        rd <= 5'b0;
        sa <= 5'b0;
        immediate <= 15'b0;
        addr <= 25'b0;
        
        case(opcode)
            6'b000000:          //R
            begin
                func <= instrument[5:0];    //add、sub、and、or、xor、sll、srl、sra、jr
                sa <= instrument[10:6];
                rd <= instrument[15:11];
                rt <= instrument[20:16];
                rs <= instrument[25:21];
            end
            6'b001000,  //addi:rs + imm -> rt 
            6'b001100,  //andi:rs & imm -> rt
            6'b001101,  //ori:rs | imm -> rt
            6'b001110,  //xori:rs ^ imm -> rt
            6'b100011,  //lw:ram[rs + offset] -> r]
            6'b101011,  //sw:rt -> ram[rs + offset]
            6'b000100,  //beq:if(rs == rt),jump pc+4 + offset<<2
            6'b000101,  //bne:if(rs != rt),jump pc+4 + offset<<2
            6'b001111:  //lui:将imm数保存到rt的高16位
            begin
                immediate <= instrument[15:0];
                rt <= instrument[20:16];
                rs <= instrument[25:21];
            end
            //J指令
            6'b000010,  //j:跳转到{pc[31:28],address<<2}
            6'b000011:  //jal:跳转到{pc[31:28],address<<2},并将pc+4保存到$31中
            begin
                addr <= instrument[25:0];
            end
        endcase
    end
endmodule
