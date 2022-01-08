LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Hazard_detection_unit IS
    GENERIC (n : INTEGER := 32);
    PORT (
        ID_EX_RegisterRd               : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        IF_ID_RegisterRs               : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        IF_ID_RegisterRt               : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        ID_EX_MemRead, ID_EX_wb        : IN STD_LOGIC;
        IF_ID_FLUSH                    : OUT STD_LOGIC;
        Is_Hazard                      : OUT std_LOGIC

    );
END ENTITY;


ARCHITECTURE Hazard_detection_unit_arch OF Hazard_detection_unit IS

BEGIN

      -- IF_ID_FLUSH <= '1' when (ID_EX_RegisterRd = IF_ID_RegisterRt or ID_EX_RegisterRd = IF_ID_RegisterRs) and ((ID_EX_wb and ID_EX_MemRead) = '1');
    -- Is_Hazard <= IF_ID_FLUSH;
    
    process (ID_EX_RegisterRd,IF_ID_RegisterRs,IF_ID_RegisterRt,ID_EX_MemRead,ID_EX_wb)
    begin
        IF ( (ID_EX_RegisterRd = IF_ID_RegisterRt or ID_EX_RegisterRd = IF_ID_RegisterRs) and ( ID_EX_wb = '1' and ID_EX_MemRead= '1') ) THEN
            IF_ID_FLUSH <= '1';
            Is_Hazard <= '1';
        END IF;
    end process;    

END ARCHITECTURE;