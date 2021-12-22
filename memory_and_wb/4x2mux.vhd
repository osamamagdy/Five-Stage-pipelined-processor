--4x2 Mux
--Library
Library ieee;
use ieee.std_logic_1164.all;

--Entity
ENTITY mux4x1 IS
GENERIC (n : integer := 8);
PORT( in0,in1,in2,in3: IN std_logic_vector (n-1 DOWNTO 0);
              sel : IN std_logic_vector (1 DOWNTO 0);
              out1: OUT std_logic_vector (n-1 DOWNTO 0));
END mux4x1;

--Architecture
ARCHITECTURE  arch_mux4x1 OF mux4x1 IS
BEGIN
     out1 <=   in0 WHEN sel(0) = '0' AND sel(1) ='0'
        ELSE in1 WHEN   sel(0) = '1'  AND sel(1) ='0'
        ELSE in2 WHEN   sel(0) = '0'  AND sel(1) ='1'
	ELSE in3 WHEN   sel(0) = '1'  AND sel(1) ='1'
	ELSE (others=>'Z')
;

END arch_mux4x1;
