library ieee;
use ieee.std_logic_1164.all;

entity tb_clocked_array_example is
end entity;

architecture sim of tb_clocked_array_example is
  signal clk  : std_logic := '0';
  signal addr : integer range 0 to 1 := 0;
  signal q    : std_logic_vector(3 downto 0);
begin
  uut: entity work.clocked_array_example(rtl)
    port map (
      clk  => clk,
      addr => addr,
      q    => q
    );

  clk <= not clk after 5 ns; -- período 10 ns

  process
  begin
    addr <= 0; wait for 12 ns;
    addr <= 1; wait for 10 ns;
    addr <= 0; wait for 10 ns;
    addr <= 1; wait for 10 ns;
    wait;
  end process;

  process
  begin
    wait until rising_edge(clk); wait for 1 ns;
    assert q = "0001"
      report "clocked_array_example: first edge expected q=0001"
      severity error;
    wait until rising_edge(clk); wait for 1 ns;
    assert q = "0010"
      report "clocked_array_example: second edge expected q=0010"
      severity error;
    wait until rising_edge(clk); wait for 1 ns;
    assert q = "0001"
      report "clocked_array_example: third edge expected q=0001"
      severity error;
    wait until rising_edge(clk); wait for 1 ns;
    assert q = "0010"
      report "clocked_array_example: fourth edge expected q=0010"
      severity error;
    wait until rising_edge(clk); wait for 1 ns;
    assert q = "0010"
      report "clocked_array_example: fifth edge expected q=0010"
      severity error;
    wait;
  end process;
end architecture;
