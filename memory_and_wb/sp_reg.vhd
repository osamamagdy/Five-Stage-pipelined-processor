LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY SP_REGISTER IS
    GENERIC (N : INTEGER := 32);
    PORT (
        D: IN STD_LOGIC_VECTOR (n - 1 DOWNTO 0);
        CLK, RST: IN STD_LOGIC;
        Q: OUT STD_LOGIC_VECTOR (n - 1 DOWNTO 0)
    );
END ENTITY;
ARCHITECTURE StructSP_REGISTER OF SP_REGISTER IS
BEGIN
    PROCESS (CLK, RST)
    BEGIN
        IF (RST = '1') THEN
            Q <= (OTHERS => '0');
        ELSIF rising_edge(CLK) THEN
            Q <= D;
        END IF;
    END PROCESS;
END StructSP_REGISTER;