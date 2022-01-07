--Library
Library ieee;
use ieee.std_logic_1164.all;

ENTITY epc IS
	GENERIC ( n : integer := 32);
	PORT( 
		clk, en, rst : IN std_logic;
		d : IN std_logic_vector(n-1 DOWNTO 0);
		q : OUT std_logic_vector(n-1 DOWNTO 0));
END epc;

ARCHITECTURE epc_Arch of epc IS
BEGIN
PROCESS (clk,rst)
BEGIN
    IF (rst = '1') THEN
            q <= (OTHERS => '0');
    ELSIF rising_edge(clk) and (en = '1') THEN
        q <= d;
    END IF;
END PROCESS;
END  epc_Arch;
