library ieee;
use ieee.std_logic_1164.all;

entity tb_downto_example is
end entity;

architecture sim of tb_downto_example is
  signal a : std_logic_vector(7 downto 0) := (others => '0');
  signal y : std_logic;
begin
  uut: entity work.downto_example(rtl)
    port map (
      a => a,
      y => y
    );

  process
  begin
    a <= "00000000"; wait for 10 ns; -- y = 0
    a <= "10000000"; wait for 10 ns; -- y = 1 (MSB)
    a <= "01111111"; wait for 10 ns; -- y = 0
    wait;
  end process;
end architecture;

