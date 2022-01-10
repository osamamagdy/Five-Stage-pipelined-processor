LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY CheckImmediate IS
    GENERIC (
        N : INTEGER := 32
    );
    PORT (
        PcIn    : IN STD_LOGIC_VECTOR (N - 1 DOWNTO 0);
        IR_temp : IN STD_LOGIC_VECTOR (N - 1 DOWNTO 0);
        pcOut   : OUT STD_LOGIC_VECTOR (N - 1 DOWNTO 0)
    );
END CheckImmediate;

ARCHITECTURE CheckImmediate_Struct OF CheckImmediate IS
BEGIN

    pcOut <= STD_LOGIC_VECTOR(to_unsigned(to_integer(unsigned(pcIn)) + 2, 32)) WHEN (IR_temp(31 DOWNTO 27) = "01011"
        OR IR_temp(31 DOWNTO 27) = "01110" OR IR_temp(31 DOWNTO 27) = "01111" OR IR_temp(31 DOWNTO 27) = "10111" OR IR_temp(31 DOWNTO 27) = "10000")
        ELSE
        STD_LOGIC_VECTOR(to_unsigned(to_integer(unsigned(pcIn)) + 1, 32));
END CheckImmediate_Struct;