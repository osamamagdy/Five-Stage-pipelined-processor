
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY PC_REGISTER IS
    GENERIC (N : INTEGER := 32);
    PORT (
        D                : IN STD_LOGIC_VECTOR (n - 1 DOWNTO 0);
        CLK, RST, ENABLE : IN STD_LOGIC;
        Q                : OUT STD_LOGIC_VECTOR (n - 1 DOWNTO 0)
    );
END ENTITY;
ARCHITECTURE StructPC_REGISTER OF PC_REGISTER IS
BEGIN
    PROCESS (CLK, RST)
    BEGIN
        IF (RST = '1') THEN
            Q <= (OTHERS => '0');
        ELSIF rising_edge(CLK) AND ENABLE = '1' THEN
            Q <= D;
        END IF;
    END PROCESS;
END StructPC_REGISTER;