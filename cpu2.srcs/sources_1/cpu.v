`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/16 14:09:58
// Design Name: 
// Module Name: cpu
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


module cpu(
    input clk,
    input oc,
    input rst,
    input [3:0] switch, //开关输入数据
    output [31:0] displaydata    //输出到led数据
    );
        //ID
        wire[5:0] opcode;   //指令类型
        wire[5:0] func;     //指令功能码
        wire [4:0] rs;
        wire [4:0] rt;
        wire[4:0] rd;
        wire[4:0] sa;
        wire[31:0] sa1={27'b0,sa};//为了统一sa和cpu、selector2里的接口位数，确保数值传输和运算正确，将其扩展为32位
        wire[15:0] immediate;
        wire[25:0] addr;
        //CU
        wire[1:0] pcindex;//4选1
        wire ram2reg;
        wire ramWE;     //ram写信号
        wire[3:0] aluOP;//alu运算类型
        wire regWE;     //reg写信号
        wire imm;       //立即数信号
        wire shift;     //移位信号
        wire isrt;      //1：rd 0：rt
        wire sign_ext;  //1：符号扩展 0：零扩展
        wire jal;       //跳转信号
        //alu
        wire [31:0] f;
        wire z;
        //reg
        wire [31:0]rs_data;
        wire [31:0]rt_data;
        //rom
        wire [31:0]instrument;  //指令
        //pc
        wire [31:0]nextAddr, insAddr;
        //数据选择器
        wire [31:0]sel2_1, sel2_2, sel2_3, sel2_4, sel2_5, sel2_6;
        //extend
        wire [31:0]immediate_32;
        //ram/IOManager
        wire [31:0]ramOut;
        
        //程序计数器
        pc my_pc(clk, rst, nextAddr, insAddr);
        //四选一数据选择器，确定pc下一个地址
        selector selector_4(insAddr+4, immediate_32, rs_data, addr, pcindex, nextAddr);
        //waddr的选择
        selector2 rt_or_rd(rt, rd, isrt, sel2_1);
        //alu参数a的选择
        selector2 rs_or_sd(rs_data, sa1, shift, sel2_2);
        //alu参数b的选择
        selector2 rt_or_imm(rt_data,immediate_32, imm, sel2_3);//imm
        //waddr选择（jal时选择31号寄存器）
        selector2 write_addr(sel2_1, 5'b11111, jal, sel2_4);
        //输出结果选择（默认为alu结果f，ram2reg置1时选用ramOut）
        selector2 f_or_ram(f, ramOut, ram2reg, sel2_5);
        //wdata选择（jal时选择pc+4）
        selector2 write_data(sel2_5, insAddr+4, jal, sel2_6);
        //指令解码器
        InstrumentDecoder ID(instrument, opcode, func, rs, rt, rd, sa1, immediate, addr);
        //寄存器堆
        register my_reg(clk, oc, rs, rt, sel2_4, sel2_6, regWE|ram2reg, rs_data, rt_data);
        //立即数扩展
        extend imm_extd(immediate, sign_ext, immediate_32);
        //运算单元
        alu my_alu(sel2_2, sel2_3, aluOP, f, z);
        //rom存储器
        rom my_rom(insAddr,instrument);
        //输入输出设备
        IOManager my_iom(f, rt_data, ramWE, clk, ramOut, switch, displaydata);
        //ram存储器
        //ram my_ram(f, rt_data, clk, ramWE, ramOut);   //实现fib是在IOManager中进行实例化的
        //控制单元
        ControlUnit CU(opcode, func, z, pcindex, ram2reg, ramWE, aluOP, regWE, imm, shift, isrt, sign_ext, jal);
        //initial
        //$monitor($time,,"sel2_2=%h",sel2_2); 
       //$monitor($time,,"sel2_1=%b;sel2_5=%b;regWE=%b;ram2reg=%b;regWE|ram2reg=%b;rs_data=%b;rt_data=%b",sel2_1, sel2_5, regWE,ram2reg,regWE|ram2reg,rs_data, rt_data);
endmodule
