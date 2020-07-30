----------------------------------------------------------------------------------
-- Company: SVNIT SURAT
-- Engineer: Kinshuk Srivastava
-- 
-- Create Date: 07/30/2020 11:36:45 PM
-- Design Name: 
-- Module Name: FP16-Simple-Multiplier - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FP16-Simple-Multiplier is
--  Port ( );
    port (numi1,numi2 : in std_logic_vector(15 downto 0);
        clk : in std_logic;
        ans: out std_logic_vector(15 downto 0));
end FP16-Simple-Multiplier;

architecture Behavioral of FP16-Simple-Multiplier is
    signal num1 : std_logic_vector(9 downto 0) := (others => '0') ;
    signal num2 : std_logic_vector(9 downto 0) := (others => '0');
    signal exp1 : std_logic_vector(4 downto 0) := (others => '0');
    signal exp2 : std_logic_vector(4 downto 0) := (others => '0');
    signal expsum : std_logic_vector(4 down to 0) := (others => '0');
    signal tempreg : std_logic_vector(11 down to 0):= (others => '0');
    signal multi: std_logic_vector(20 downto 0) := (others => '0');
    signal s1,s2,sz : std_logic := "0";
begin
    variable xt : bit := 0;
    process
        wait until rising_edge(clk);
            num1 <= numi1(9 downto 0);
            num2 <= numi2(9 downto 0);
            exp1 <= numi1(14 downto 10);
            exp2 <= numi2(14 downto 10);
            s1 <= numi1(15);
            s2 <= numi2(15);
            bit:= 1;
            if(bit = '1') then
                sz <= s1 xor s2;
                expsum <= std_logic_vector(unsigned(exp1) + unsigned(exp2) - unsigned(2#01111#));
                multi <= std_logic_vector(unsigned(num1) * unsigned(num2));
                
            
            
            
        

end Behavioral;
