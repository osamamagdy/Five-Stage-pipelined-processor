LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;

ENTITY instruction_mem IS
    -- mem size = 16
    -- mem data size = 32
    -- mem address width = 20
    GENERIC (
        MEMSize         : INTEGER := 16;
        MEMDataSize     : INTEGER := 32;
        MEMAddressWidth : INTEGER := 20
    );
    PORT (
        PC          : IN STD_LOGIC_VECTOR(MEMDataSize - 1 DOWNTO 0);
        RST         : IN STD_LOGIC;
        instruction : OUT STD_LOGIC_VECTOR(MEMDataSize - 1 DOWNTO 0);
        M0_1        : OUT STD_LOGIC_VECTOR(MEMDataSize - 1 DOWNTO 0)
    );
END instruction_mem;

ARCHITECTURE instruction_mem_arch OF instruction_mem IS
    TYPE ram_type IS ARRAY(0 TO 2 ** MEMAddressWidth - 1) OF STD_LOGIC_VECTOR(MEMSize - 1 DOWNTO 0);
    SIGNAL ram : ram_type;
    --constant HALF_MEMDATASIZE :integer := integer(floor(real(MEMDataSize - 1)/REAL(2)));
BEGIN
    -- PROCESS(Clk) IS
    -- 	BEGIN
    -- 		IF rising_edge(Clk) THEN  
    -- 			instruction(15 DOWNTO 0) <= ram(to_integer(unsigned(PC)));
    -- 			instruction(MEMDataSize - 1 DOWNTO 16) <= ram(to_integer(unsigned(PC)+1));
    -- 		END IF;
    -- END PROCESS;
    instruction(MEMDataSize - 1 DOWNTO 16) <= ram(to_integer(unsigned(PC)));
    instruction(15 DOWNTO 0)               <= ram(to_integer(unsigned(PC) + 1));
    M0_1(MEMDataSize - 1 DOWNTO 16)        <= ram((0)) WHEN RST = '1' ELSE ((OTHERS => '0'));
    M0_1(15 DOWNTO 0)                      <= ram((1)) WHEN RST = '1' ELSE ((OTHERS => '0'));
    
END instruction_mem_arch;