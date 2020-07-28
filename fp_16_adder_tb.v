`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: SVNIT Surat 
// Engineer: Kinshuk Srivastava
// 
// Create Date: 07/27/2020 11:58:29 PM
// Design Name: Testbench for fp_16 Adder
// Module Name: fp_16_adder_tb
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


module fp_16_adder_tb;
reg [15:0] num1i;
reg [15:0] num2i;
reg clk;
wire [15:0] ans;
wire sign1o;
wire sign2o;
wire [4:0] exp1o;
wire [4:0] exp2o;
wire [4:0] expdiffo;
wire szo;
wire [4:0] lambdao;
wire flago;
wire [10:0] mro;
wire [4:0] rexpo;
fp16_adder F0(
    .numi1(num1i),
    .numi2(num2i),
    .clk(clk),
    .ans(ans),
    .sign1o(sign1o),
    .sign2o(sign2o),
    .exp1o(exp1o),
    .exp2o(exp2o),
    .expdiffo(expdiffo),
    .szo(szo),
    .lambdao(lambdao),
    .flago(flago),
    .mro(mro),
    .rexpo(rexpo)
    );
    initial begin
        clk = 0;
        num1i = 16'b0_01110_0000000000;
        num2i = 16'b1_01101_1100000000;
    end
    always begin
    #50 clk = !clk;
    $display("\t\ttime,\tclk,\tnum1,\tnum2,\tans,\tsign1,\tsign2,\texp1,\texp2,\texpdiff,\tsz,\tlambda,\tflag,\tmro,\trexpo");
    $monitor("%d,\t%d,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b",$time,clk,num1i,num2i,ans,sign1o,sign2o,exp1o,exp2o,expdiffo,szo,lambdao,flago,mro,rexpo);
    end
endmodule
