library ieee;
use ieee.std_logic_1164.all;

entity clocked_array_example is
  port (
    clk  : in  std_logic;
    addr : in  integer range 0 to 1;
    q    : out std_logic_vector(3 downto 0)
  );
end entity;

architecture rtl of clocked_array_example is
  type reg_array is array (0 to 1) of std_logic_vector(3 downto 0);
  signal r : reg_array := ("0001", "0010");
begin
  process(clk)
  begin
    if rising_edge(clk) then
      q <= r(addr);
    end if;
  end process;
end architecture;

