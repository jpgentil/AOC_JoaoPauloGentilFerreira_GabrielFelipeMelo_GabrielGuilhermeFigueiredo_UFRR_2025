library ieee;
use ieee.std_logic_1164.all;

entity array_example is
  port (
    addr : in  integer range 0 to 3;
    dout : out std_logic_vector(7 downto 0)
  );
end entity;

architecture rtl of array_example is
  type mem_t is array (0 to 3) of std_logic_vector(7 downto 0);
  signal mem : mem_t := (
    0 => "00000001",
    1 => "00000010",
    2 => "00000100",
    3 => "00001000"
  );
begin
  dout <= mem(addr);
end architecture;

