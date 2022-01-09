Library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;
ENTITY ExceptionUnit IS
	PORT(
		
		mem_Address: In std_logic; -- if 0: data, if 1: stack
        stack_op: In std_logic; -- sp_op[0]: if 0: push if 1: pop
		stack_address : IN  std_logic_vector(31 DOWNTO 0); 
        memory_address : IN  std_logic_vector(15 DOWNTO 0); -- coming from alu result
		we: In std_logic; -- if 0: data, if 1: stack
        re: In std_logic; -- if 0: data, if 1: stack
		is_exception: OUT std_logic
		);
END ENTITY ExceptionUnit;

ARCHITECTURE EUArch OF ExceptionUnit IS
begin
    is_exception<='1' WHEN( (we='1' or re='1' ) and (mem_Address ='0' and memory_address>"1111111100000000")) or 
    ((we='1' or re='1' ) and(mem_Address='1' and stack_op='1' and stack_address>="00000000000100000000000000000000"))
    ELSE '0'; 
END EUArch;