LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE work.all;
ENTITY my_nDFF IS
    GENERIC (n : INTEGER := 16);
    PORT ( Clk, en : IN STD_LOGIC;
        d : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
        q : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0));
END my_nDFF;

ARCHITECTURE b_my_nDFF OF my_nDFF IS
    COMPONENT my_DFF IS
        PORT (
            d, Clk, en : IN STD_LOGIC;
            q : OUT STD_LOGIC);
    END COMPONENT;
BEGIN
    loop1 : FOR i IN 0 TO n - 1 GENERATE
        ------They have the same Clk, Rst, en bit as we want to move the entire 32-bit together
        fx : my_DFF PORT MAP(d(i), Clk, en, q(i));
    END GENERATE;
END b_my_nDFF;