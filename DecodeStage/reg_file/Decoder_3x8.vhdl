LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE work.all;
ENTITY Decoder IS
    PORT ( en : IN STD_LOGIC;
        Input : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        Output : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END Decoder;
ARCHITECTURE my_Decoder OF Decoder IS
BEGIN
    output <= "00000000" WHEN en='0'
    ELSE "00000001" WHEN en='1' AND input="000"
    ELSE "00000010" WHEN en='1' AND input="001"
    ELSE "00000100" WHEN en='1' AND input="010"
    ELSE "00001000" WHEN en='1' AND input="011"
    ELSE "00010000" WHEN en='1' AND input="100"
    ELSE "00100000" WHEN en='1' AND input="101"
    ELSE "01000000" WHEN en='1' AND input="110"
    ELSE "10000000" WHEN en='1' AND input="111";
END my_Decoder;