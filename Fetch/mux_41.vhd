LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY mux_41 IS
    GENERIC (
        N : INTEGER := 32
    );
    PORT (
        selector : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        muxIn1   : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
        muxIn2   : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
        muxIn3   : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
        muxIn4   : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
        muxOut   : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0)
    );
END mux_41;

ARCHITECTURE mux_41_structure OF mux_41 IS
BEGIN
    muxOut <= muxIn1 WHEN selector = "00" ELSE
        muxIn2 WHEN selector = "01" ELSE
        muxIn3 WHEN selector = "10" ELSE
        muxIn4 WHEN selector = "11";
END mux_41_structure;