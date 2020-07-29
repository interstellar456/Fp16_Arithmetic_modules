`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: SVNIT Surat 
// Engineer: Kinshuk Srivastava
// 
// Create Date: 07/27/2020 10:06:33 PM
// Design Name: Fp-16_adder
// Module Name: fp16_adder
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


module fp16_adder(
input [15:0] numi1,
input [15:0] numi2,
input clk,
output reg [15:0] ans,
output reg sign1o,sign2o,
output reg [4:0] exp1o,
output reg [4:0] exp2o,
output reg [4:0] expdiffo,
output reg szo,
output reg [4:0] lambdao,
output reg flago,
output reg [10:0] mro,
output reg [4:0] rexpo,
output reg [4:0] ra,
output reg [1:0] iszero,
output reg [1:0] isinf,
output reg isnan
    );
    reg [10:0] num1;
    reg [10:0] num2;
    reg sign1,sign2;
    reg [15:0] num3;
    reg [11:0] tempreg;
    reg [4:0] exp1;
    reg [4:0] exp2;
    reg [4:0] expdiff;
    reg sz;
    reg [4:0] lambda;
    reg flag;
    reg f1,f2;
    reg [4:0] rb,rc,rd;
    always@(posedge clk)
    begin
        if(numi1 == 16'h7c00 || numi2 == 16'h7c00)
        begin
            isinf = 2'b01;
            ans = 16'bZZZZZZZZZZZZZZZZ;
        end
        else if(numi1 == 16'hfc00 || numi2 == 16'hfc00)
        begin
            isinf = 2'b10;
            ans = 16'bZZZZZZZZZZZZZZZZ;
        end
        else if((numi1[14:10] == 5'b11111 && numi1[9:0] != 10'b0000000000) || ((numi2[14:10] == 5'b11111 && numi2[9:0] != 10'b0000000000)))
        begin
            isnan = 1;
            ans = 16'bZZZZZZZZZZZZZZZZ;
        end
        else begin
            isnan = 0;
            isinf = 0;
            ans = 0;
        end
        if(isnan == 0 && isinf == 2'b00)
        begin
            num1 = 0;
            num2 = 0;
            num3 = 0;
            exp1 = 0;
            exp2 = 0;
            sign1 = 0;
            sign2 = 0;
            tempreg = 0;
            sz = 0;
            f1 = 0;
            f2 = 0;
            //ans = 0;
            flag = 0;
            lambda = 0;
            expdiff = 0;
            num1[9:0] = numi1[9:0];
            num2[9:0] = numi2[9:0];
            num1[10] = 1;
            num2[10] = 1;
            iszero = 2'b00;
            sign1 = numi1[15];
            sign2 = numi2[15];
            if(numi1[14:10] >= numi2[14:10])
            begin
                exp1 = numi1[14:10] - 5'b01111;
                exp2 = numi2[14:10] - 5'b01111;
            end
            else 
            begin
                exp1 = numi2[14:10] - 5'b01111;
                exp2 = numi1[14:10] - 5'b01111;
            end
            expdiff = exp1 - exp2;
            num2[10:0] = num2[10:0] >> expdiff;
            mro = num2[10:0];
            sz = sign1 ^ sign2;
            if(sz)
            begin
                if(num2 < num1)
                begin
                    tempreg[11:0] = num1[10:0] - num2[10:0];
                    num3[9:0] = tempreg[9:0];
                    num3[15] = sign1;
                end
                else if(num2 > num1) begin
                    tempreg[11:0] = num1[10:0] - num2[10:0];
                    num3[9:0] = tempreg[9:0];
                    num3[9:0] = -num3[9:0];
                    num3[15] = sign2;
                end
                else begin
                    num3[15] = 1'bZ;
                    tempreg[11:0] = 0;
                    num3[9:0] = 0;
                end
                f1 = 1;
            end
            else begin
                if(sign1 == 0 && sign2 == 0) 
                begin
                    tempreg[11:0] = num1[10:0] + num2[10:0];
                    num3[9:0] = tempreg[9:0];
                    num3[15] = 0;
                end
                else begin
                    tempreg[11:0] = num1[10:0] + num2[10:0];
                    num3[9:0] = tempreg[9:0];
                    num3[15] = 1;
                end
                f2 = 1;
            end
            num3[14:10] = exp1;
            rexpo = num3[14:10];
        //ra = tempreg[11];
            if(tempreg[11])
            begin
                num3[9:0] = num3[9:0] >> 1;
                num3[14:10] = num3[14:10] + 5'b00001 + 5'b01111;
                ra = 5'bZZZZZ;
            end
            else if(tempreg[10] == 0 && tempreg[11:0] != 12'b000000000000)
            begin
                flag = 0;
                lambda = 1;
                if((num3[9] ^ 1 == 1) && flag == 0)
                begin
                    lambda = lambda + 1;
                end
                else begin
                    flag = 1;
                end
                if(((num3[8] ^ 1 == 1) && flag == 0))
                begin
                    lambda = lambda + 1;
                end
                else begin
                    flag = 1;
                end
                if((num3[7] ^ 1 == 1) && flag == 0)
                    lambda = lambda + 1;
                else flag = 1;
                if((num3[6] ^ 1 == 1) && flag == 0)
                    lambda = lambda + 1;
                else flag = 1;
                if((num3[5] ^ 1 == 1) && flag == 0)
                    lambda = lambda + 1;
                else flag = 1;
                if((num3[4] ^ 1 == 1) && flag == 0)
                    lambda = lambda + 1;
                else flag = 1;
                if((num3[3] ^ 1 == 1) && flag == 0)
                    lambda = lambda + 1;
                else flag = 1;
                if((num3[2] ^ 1 == 1) && flag == 0)
                    lambda = lambda + 1;
                else flag = 1;
                if((num3[1] ^ 1 == 1) && flag == 0)     
                    lambda = lambda + 1;
                else flag = 1;
                if((num3[0] ^ 1 == 1) && flag == 0)
                    lambda = lambda + 1;
                else flag = 1;
                if(num3[14:10] - lambda < 5'b10010)
                begin
                    num3[9:0] = num3[9:0] << (num3[14:11] + 14);
                    num3[14:10] = -14;
                    rexpo = 1;
                end
                else begin
                    num3[9:0] = num3[9:0] << lambda;
                    rexpo = num3[14:10];
                    rexpo = rexpo - lambda;
                    num3[14:10] = rexpo + 5'b01111;
                end
            end
            else begin
                //iszero = 2'b11;
                //ans = 16'bZZZZZZZZZZZZZZZZ;
                num3[14:10] = 0;
            end
     //num3[14:10] = num3[14:10];
     
        if(num3[14:0] == 15'b000000000000000)
        begin
            if(num3[15] == 1)
            begin
                iszero = 2'b10;
                ans = 16'bZZZZZZZZZZZZZZZZ;
            end
            else if(num3[15] == 1'bZ) begin
                iszero = 2'b11;
                ans = 16'bZZZZZZZZZZZZZZZZ;
            end
            else
            begin
                iszero = 2'b01;
                ans = 16'bZZZZZZZZZZZZZZZZ;
            end
        end
       else begin 
        ans = num3;
       end
        sign1o = sign1;
        sign2o = sign2;
        exp1o = exp1;
        exp2o = exp2;
        expdiffo = expdiff;
        szo = sz;
        lambdao = lambda;
        flago = flag;
        end 
    end
endmodule
