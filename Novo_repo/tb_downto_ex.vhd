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
    assert y = '0'
      report "downto_example: a=00000000 expected y=0"
      severity error;
    a <= "10000000"; wait for 10 ns; -- y = 1 (MSB)
    assert y = '1'
      report "downto_example: a=10000000 expected y=1"
      severity error;
    a <= "01111111"; wait for 10 ns; -- y = 0
    assert y = '0'
      report "downto_example: a=01111111 expected y=0"
      severity error;
    wait;
  end process;
end architecture;
