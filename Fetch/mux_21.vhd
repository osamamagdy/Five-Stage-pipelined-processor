LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY mux_21 IS
    GENERIC (
        N : INTEGER := 32
    );
    PORT (
        selector : IN STD_LOGIC;
        muxIn1   : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
        muxIn2   : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
        muxOut   : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0)
    );
END mux_21;

ARCHITECTURE mux_21_structure OF mux_21 IS
BEGIN
    muxOut <= muxIn1 WHEN selector = '0'
        ELSE muxIn2 WHEN selector = '1';
END mux_21_structure;