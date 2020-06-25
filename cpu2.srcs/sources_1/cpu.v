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
    input [3:0] switch, //������������
    output [31:0] displaydata    //�����led����
    );
        //ID
        wire[5:0] opcode;   //ָ������
        wire[5:0] func;     //ָ�����
        wire [4:0] rs;
        wire [4:0] rt;
        wire[4:0] rd;
        wire[4:0] sa;
        wire[31:0] sa1={27'b0,sa};//Ϊ��ͳһsa��cpu��selector2��Ľӿ�λ����ȷ����ֵ�����������ȷ��������չΪ32λ
        wire[15:0] immediate;
        wire[25:0] addr;
        //CU
        wire[1:0] pcindex;//4ѡ1
        wire ram2reg;
        wire ramWE;     //ramд�ź�
        wire[3:0] aluOP;//alu��������
        wire regWE;     //regд�ź�
        wire imm;       //�������ź�
        wire shift;     //��λ�ź�
        wire isrt;      //1��rd 0��rt
        wire sign_ext;  //1��������չ 0������չ
        wire jal;       //��ת�ź�
        //alu
        wire [31:0] f;
        wire z;
        //reg
        wire [31:0]rs_data;
        wire [31:0]rt_data;
        //rom
        wire [31:0]instrument;  //ָ��
        //pc
        wire [31:0]nextAddr, insAddr;
        //����ѡ����
        wire [31:0]sel2_1, sel2_2, sel2_3, sel2_4, sel2_5, sel2_6;
        //extend
        wire [31:0]immediate_32;
        //ram/IOManager
        wire [31:0]ramOut;
        
        //���������
        pc my_pc(clk, rst, nextAddr, insAddr);
        //��ѡһ����ѡ������ȷ��pc��һ����ַ
        selector selector_4(insAddr+4, immediate_32, rs_data, addr, pcindex, nextAddr);
        //waddr��ѡ��
        selector2 rt_or_rd(rt, rd, isrt, sel2_1);
        //alu����a��ѡ��
        selector2 rs_or_sd(rs_data, sa1, shift, sel2_2);
        //alu����b��ѡ��
        selector2 rt_or_imm(rt_data,immediate_32, imm, sel2_3);//imm
        //waddrѡ��jalʱѡ��31�żĴ�����
        selector2 write_addr(sel2_1, 5'b11111, jal, sel2_4);
        //������ѡ��Ĭ��Ϊalu���f��ram2reg��1ʱѡ��ramOut��
        selector2 f_or_ram(f, ramOut, ram2reg, sel2_5);
        //wdataѡ��jalʱѡ��pc+4��
        selector2 write_data(sel2_5, insAddr+4, jal, sel2_6);
        //ָ�������
        InstrumentDecoder ID(instrument, opcode, func, rs, rt, rd, sa1, immediate, addr);
        //�Ĵ�����
        register my_reg(clk, oc, rs, rt, sel2_4, sel2_6, regWE|ram2reg, rs_data, rt_data);
        //��������չ
        extend imm_extd(immediate, sign_ext, immediate_32);
        //���㵥Ԫ
        alu my_alu(sel2_2, sel2_3, aluOP, f, z);
        //rom�洢��
        rom my_rom(insAddr,instrument);
        //��������豸
        IOManager my_iom(f, rt_data, ramWE, clk, ramOut, switch, displaydata);
        //ram�洢��
        //ram my_ram(f, rt_data, clk, ramWE, ramOut);   //ʵ��fib����IOManager�н���ʵ������
        //���Ƶ�Ԫ
        ControlUnit CU(opcode, func, z, pcindex, ram2reg, ramWE, aluOP, regWE, imm, shift, isrt, sign_ext, jal);
        //initial
        //$monitor($time,,"sel2_2=%h",sel2_2); 
       //$monitor($time,,"sel2_1=%b;sel2_5=%b;regWE=%b;ram2reg=%b;regWE|ram2reg=%b;rs_data=%b;rt_data=%b",sel2_1, sel2_5, regWE,ram2reg,regWE|ram2reg,rs_data, rt_data);
endmodule
