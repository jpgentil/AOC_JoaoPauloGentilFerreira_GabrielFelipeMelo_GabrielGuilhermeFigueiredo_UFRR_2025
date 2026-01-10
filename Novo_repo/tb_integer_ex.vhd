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

  process
    variable exp : integer := 0;
  begin
    wait until rising_edge(clk);
    assert counter = 0
      report "integer_example: reset edge 1 expected counter=0"
      severity error;
    wait until rising_edge(clk);
    assert counter = 0
      report "integer_example: reset edge 2 expected counter=0"
      severity error;

    exp := 1;
    for i in 0 to 7 loop
      wait until rising_edge(clk);
      assert counter = exp
        report "integer_example: expected counter sequence"
        severity error;
      if exp = 3 then
        exp := 0;
      else
        exp := exp + 1;
      end if;
    end loop;
    wait;
  end process;
end architecture;
