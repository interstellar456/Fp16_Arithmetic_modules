----------------------------------------------------------------------------------
-- Company: SVNIT SURAT
-- Engineer: Kinshuk Srivastava
-- 
-- Create Date: 07/31/2020 02:58:53 PM
-- Design Name: 
-- Module Name: FP16SimpleMultiplierTb - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FP16SimpleMultiplierTb is
--  Port ( );
end FP16SimpleMultiplierTb;

architecture Behavioral of FP16SimpleMultiplierTb is
    component FP16SimpleMultiplier
        port(numi1,numi2 : in std_logic_vector(15 downto 0);
            clk : in std_logic;
            ans : out std_logic_vector(15 downto 0));
        end component;
        signal numi1, numi2 : std_logic_vector(15 downto 0):= (others => '0');
        signal clk : std_logic := '0';
        signal ans : std_logic_vector(15 downto 0) := (others => '0'); 
begin
    UUT : FP16SimpleMultiplier port map (numi1 => numi1, numi2 => numi2, clk => clk, ans => ans);
    process
    begin
        numi1 <= std_logic_vector(to_unsigned(2#0011111000110010#,16));
        numi2 <= std_logic_vector(to_unsigned(2#0011111000110010#,16));
        wait for 100 ns;
        clk <= '1';
        wait for 100 ns;
        clk <= '0';
        wait for 100 ns;
        clk <= '1';
        wait;
    end process;
end Behavioral;
