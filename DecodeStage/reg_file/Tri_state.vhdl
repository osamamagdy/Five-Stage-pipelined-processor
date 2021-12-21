LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE work.all;
ENTITY nTRI IS
    GENERIC (n : INTEGER := 16);
    PORT ( control : IN STD_LOGIC;
        input : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
        output : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0));
END nTRI;

ARCHITECTURE my_nTRI OF nTRI IS
    COMPONENT TRI IS
        PORT (
            input, control : IN STD_LOGIC;
            output : OUT STD_LOGIC);
    END COMPONENT;
BEGIN
    loop1 : FOR i IN 0 TO n - 1 GENERATE
    ------They have the same control bit as we want to move the entire 32-bit together
        fx : TRI PORT MAP(input(i), control, output(i));
    END GENERATE;
END my_nTRI;