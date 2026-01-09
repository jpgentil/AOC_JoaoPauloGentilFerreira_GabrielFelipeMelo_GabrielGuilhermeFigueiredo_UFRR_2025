library ieee;
use ieee.std_logic_1164.all;

entity tb_array_example is
end entity;

architecture sim of tb_array_example is
  signal addr : integer range 0 to 3 := 0;
  signal dout : std_logic_vector(7 downto 0);
begin
  uut: entity work.array_example(rtl)
    port map (
      addr => addr,
      dout => dout
    );

  process
  begin
    addr <= 0; wait for 10 ns;
    addr <= 1; wait for 10 ns;
    addr <= 2; wait for 10 ns;
    addr <= 3; wait for 10 ns;
    addr <= 0; wait for 10 ns;
    wait;
  end process;
end architecture;

