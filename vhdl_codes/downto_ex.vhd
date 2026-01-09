library ieee;
use ieee.std_logic_1164.all;

entity downto_example is
  port (
    a : in  std_logic_vector(7 downto 0);
    y : out std_logic
  );
end entity;

architecture rtl of downto_example is
begin
  -- Espera-se que y seja o MSB
  y <= a(7);
end architecture;
