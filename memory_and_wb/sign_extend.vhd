library ieee;
USE IEEE.std_logic_1164.ALL;
use ieee.numeric_std.all;
ENTITY sign_extend IS
	GENERIC ( n : integer := 32);
	PORT(
        input_16  : IN std_logic_vector( 15 downto 0);
        out_n : OUT std_logic_vector(n - 1 downto 0)
    );
END sign_extend;
architecture arch_sign_extend of sign_extend is
begin
    out_n <= std_logic_vector(resize(unsigned(input_16), out_n'length));
end arch_sign_extend;