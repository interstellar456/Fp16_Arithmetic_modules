# Fp16_Arithmetic_modules
FP16_Arithmetic modules designed by Verilog and VHDL 

28/07/2020: Added Verilog file for FP16 Adder. The adder currently doesn't perform rounding or handle exceptions like underflow and overflow.
            Input : normalized floating point numbers of the format ((-1)^s).m.(beta)^exp [IEEE Std 754-2008]. 
            Output: ans = result (16-bit), other signals are for debugging purposes.
                    sign1, sign2 = sign bit values of num1 and num2 respectively.
                    exp1, exp2 = exponent bit values of num1 and num2 respectively after being subtracted by bias. (5-bit)
                    expdiff = exponent difference
                    sz = sign1 xor sign2 
                    lambda = number of leading zeroes in case of significand cancellation, used for normalization.
                    flag = used in calculation of lambda
29/07/2020 added support for exceptions
