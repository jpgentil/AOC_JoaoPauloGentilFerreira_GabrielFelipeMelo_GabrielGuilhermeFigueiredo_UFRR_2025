library ieee;
use ieee.std_logic_1164.all;

entity tb_clocked_example is
end entity;

architecture sim of tb_clocked_example is
  signal clk : std_logic := '0';
  signal d   : std_logic := '0';
  signal q   : std_logic;
begin
  uut: entity work.clocked_example(rtl)
    port map (
      clk => clk,
      d   => d,
      q   => q
    );

  clk <= not clk after 5 ns; -- período 10 ns

  process
  begin
    d <= '0'; wait for 12 ns; -- muda fora da borda
    d <= '1'; wait for 10 ns;
    d <= '0'; wait for 10 ns;
    d <= '1'; wait for 10 ns;
    wait;
  end process;
end architecture;

