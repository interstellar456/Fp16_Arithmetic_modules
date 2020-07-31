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
    signal num1 : std_logic_vector(10 downto 0) := (others => '0') ;
    signal num2 : std_logic_vector(10 downto 0) := (others => '0');
    signal exp1 : std_logic_vector(4 downto 0) := (others => '0');
    signal exp2 : std_logic_vector(4 downto 0) := (others => '0');
    signal expsum : std_logic_vector(4 downto 0) := (others => '0');
    signal tempreg : std_logic_vector(11 downto 0):= (others => '0');
    signal multi: std_logic_vector(21 downto 0) := (others => '0');
    signal s1,s2,sz : std_logic := '0';
    signal round: std_logic_vector(9 downto 0) := (others => '0');
begin
    process
    variable xt : bit := '0';
    variable branch1 : bit := '0';
    variable branch2 : bit := '0';
    variable branch3 : bit := '0';
    variable branch4 : bit := '0';
        begin
        wait until rising_edge(clk);
            num1(9 downto 0) <= numi1(9 downto 0);
            num2(9 downto 0) <= numi2(9 downto 0);
            num1(10) <= '1';
            num2(10) <= '1';
            exp1 <= numi1(14 downto 10);
            exp2 <= numi2(14 downto 10);
            s1 <= numi1(15);
            s2 <= numi2(15);
            xt:= '1';
            if(xt = '1') then
                sz <= s1 xor s2;
                expsum <= std_logic_vector(unsigned(exp1) + unsigned(exp2) - to_unsigned(2#01111#,5));
                multi <= std_logic_vector(unsigned(num1) * unsigned(num2));
                branch1 := '1';
                if(branch1 = '1') then
                    round <= multi(9 downto 0);
                    branch2 := '1';
                    if(branch2 = '1') then
                        case to_integer(unsigned(round)) is
                            when 0 to 512 =>
                                tempreg <= multi(21 downto 10);
                                 if(sz = '1') then
                                    tempreg <= std_logic_vector(unsigned(tempreg) + to_unsigned(1,12));
                                end if;
                            when 513 to 1024 => 
                                tempreg <= multi(21 downto 10);
                                if(sz = '0') then
                                    tempreg <= std_logic_vector(unsigned(tempreg) + to_unsigned(1,12));
                                end if;
                            when others => tempreg <= tempreg;
                                end case;
                             if(unsigned(tempreg) >= to_unsigned(2#011111111111#,12)) then
                                   tempreg <= std_logic_vector(shift_right(unsigned(tempreg),1));
                                   expsum <= std_logic_vector(unsigned(expsum) + to_unsigned(1,5));
                                end if;
                            end if;
                        branch1 := '0';
                        end if;
                    xt := '0';
                    end if;
               ans(15) <= std_logic(sz);
               ans(14 downto 10) <= expsum;
               ans(9 downto 0) <= tempreg(9 downto 0);
        end process;
end Behavioral;
