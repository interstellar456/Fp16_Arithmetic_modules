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

entity FP16SimpleMultiplier is
--  Port ( );
    port (numi1,numi2 : in std_logic_vector(15 downto 0);
        clk : in std_logic;
        ans: out std_logic_vector(15 downto 0)
        );
end FP16SimpleMultiplier;

architecture Behavioral of FP16SimpleMultiplier is
begin
    process
    variable num1 : std_logic_vector(10 downto 0) := (others => '0') ;
    variable num2 : std_logic_vector(10 downto 0) := (others => '0');
    variable exp1 : std_logic_vector(4 downto 0) := (others => '0');
    variable exp2 : std_logic_vector(4 downto 0) := (others => '0');
    variable expsum : std_logic_vector(4 downto 0) := (others => '0');
    variable tempreg : std_logic_vector(15 downto 0):= (others => '0');
    variable multi: std_logic_vector(21 downto 0) := (others => '0');
    variable mrounded : std_logic_vector(11 downto 0) := (others => '0');
    variable s1,s2,sz,ready : std_logic := '0';
    variable round: std_logic_vector(9 downto 0) := (others => '0');
        begin
        wait until rising_edge(clk);
            ans <= std_logic_vector(to_unsigned(2#0000000000000000#,16));
            num1(9 downto 0) := numi1(9 downto 0);
            num1(10) := '1';
            num2(9 downto 0) := numi2(9 downto 0);
            num2(10) := '1';
            exp1 := numi1(14 downto 10);
            exp2 := numi2(14 downto 10);
            s1 := numi1(15);
            s2 := numi2(15);
            sz := s1 xor s2;
            expsum := std_logic_vector(unsigned(exp1) + unsigned(exp1) - to_unsigned(2#01111#,5));
            multi := std_logic_vector(unsigned(num1)*unsigned(num2));
            mrounded := multi(21 downto 10);
            round := multi(9 downto 0);
            case to_integer(unsigned(round)) is
                when 0 to 512 =>
                    if(sz = '1') then
                        mrounded := std_logic_vector(unsigned(mrounded) + to_unsigned(1,12));
                    end if;
                when 513 to 1023 => 
                    if(sz = '0') then
                        mrounded := std_logic_vector(unsigned(mrounded) + to_unsigned(1,12));
                    end if;
                when others =>
                    assert ready = '0';
            end case;
            if(mrounded(11) = '1') then
                mrounded := std_logic_vector(shift_right(unsigned(mrounded),1));
                expsum := std_logic_vector(unsigned(expsum) + to_unsigned(1,5));
            end if;
            tempreg(9 downto 0) := mrounded(9 downto 0);
            tempreg(14 downto 10) := expsum(4 downto 0);
            tempreg(15) := sz;
            ready := '1';
            if(ready = '1') then
                ans <= tempreg;
            end if;
        end process;
end Behavioral;
