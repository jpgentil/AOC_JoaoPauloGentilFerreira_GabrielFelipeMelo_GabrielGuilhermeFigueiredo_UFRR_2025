library ieee;
use ieee.std_logic_1164.all;

entity tb_integer_example is
end entity;

architecture sim of tb_integer_example is
  signal clk     : std_logic := '0';
  signal rst     : std_logic := '1';
  signal counter : integer range 0 to 3;
begin
  uut: entity work.integer_example(rtl)
    port map (
      clk     => clk,
      rst     => rst,
      counter => counter
    );

  clk <= not clk after 5 ns; -- período 10 ns

  process
  begin
    wait for 20 ns;  -- segura reset por 2 ciclos
    rst <= '0';

    wait for 80 ns;  -- observa o contador rodar
    wait;
  end process;
end architecture;

