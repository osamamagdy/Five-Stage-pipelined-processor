LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY IFID_BUFFER IS
    PORT (
        PC_IN, PC_NEXT_IN, IR_IN    : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        CLK, RST, FLUSH      : IN STD_LOGIC;
        PC_OUT, PC_NEXT_OUT, IR_OUT : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE StructIFID_BUFFER OF IFID_BUFFER IS
BEGIN
    PROCESS (CLK, RST)
    BEGIN
        IF (rising_edge(CLK)) THEN

            IF (RST = '1'OR FLUSH = '1') THEN
                PC_OUT      <= (OTHERS => '0');
                PC_NEXT_OUT <= (OTHERS => '0');
                IR_OUT      <= (OTHERS => '0');

            ELSE 
                PC_OUT      <= PC_IN;
                PC_NEXT_OUT <= PC_NEXT_IN;
                IR_OUT      <= IR_IN;
            END IF;
    END IF;
END PROCESS;
END StructIFID_BUFFER;