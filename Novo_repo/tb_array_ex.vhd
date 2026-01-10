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
    assert dout = "00000001"
      report "array_example: addr=0 expected dout=00000001"
      severity error;
    addr <= 1; wait for 10 ns;
    assert dout = "00000010"
      report "array_example: addr=1 expected dout=00000010"
      severity error;
    addr <= 2; wait for 10 ns;
    assert dout = "00000100"
      report "array_example: addr=2 expected dout=00000100"
      severity error;
    addr <= 3; wait for 10 ns;
    assert dout = "00001000"
      report "array_example: addr=3 expected dout=00001000"
      severity error;
    addr <= 0; wait for 10 ns;
    assert dout = "00000001"
      report "array_example: addr=0 expected dout=00000001 (repeat)"
      severity error;
    wait;
  end process;
end architecture;
