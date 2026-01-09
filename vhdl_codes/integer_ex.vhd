library ieee;
use ieee.std_logic_1164.all;

entity integer_example is
  port (
    clk     : in  std_logic;
    rst     : in  std_logic;
    counter : out integer range 0 to 3
  );
end entity;

architecture rtl of integer_example is
  signal c : integer range 0 to 3 := 0;
begin
  process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        c <= 0;
      else
        if c = 3 then
          c <= 0;
        else
          c <= c + 1;
        end if;
      end if;
    end if;
  end process;

  counter <= c;
end architecture;

