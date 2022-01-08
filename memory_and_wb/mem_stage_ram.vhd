--memory stage ram (data, stack)
--Library
Library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;

ENTITY memStageRam IS
	PORT(
		clk : IN std_logic;
		we  : IN std_logic; -- write enable (store)
        	re  : IN std_logic; -- read enable (load)
		sp_num: IN std_logic; -- if 0 then add 1, if 1 then add 2
		mem_Address: In std_logic; -- if 0: data, if 1: stack
		is_exception: In std_logic;
		is_int: IN std_logic_vector(1 downto 0);
		address : IN  std_logic_vector(31 DOWNTO 0); 
		datain  : IN  std_logic_vector(31 DOWNTO 0); -- databus width
		dataout : OUT std_logic_vector(31 DOWNTO 0)); 
END ENTITY memStageRam;

ARCHITECTURE memStageRamArch OF memStageRam IS
	COMPONENT sign_extend IS
	GENERIC ( n : integer := 32);
	PORT(
        input_16  : IN std_logic_vector( 15 downto 0);
        out_n : OUT std_logic_vector(n - 1 downto 0)
    	);
	END COMPONENT;
	TYPE ram_type IS ARRAY(0 TO 2 ** 20 - 1) OF std_logic_vector(15 DOWNTO 0);
	SIGNAL ram : ram_type ;
	----------------------------------
	SIGNAL mem_out: STD_LOGIC_VECTOR(15 downto 0);
	SIGNAL mem_extended: STD_LOGIC_VECTOR(31 downto 0);
	----------------------------------
	BEGIN
		PROCESS(clk) IS
			BEGIN
				IF falling_edge(clk) THEN  
					IF we = '1' AND is_exception='0' THEN
						ram(to_integer(unsigned(address))) <= datain(15 downto 0);
						IF mem_Address = '1' and sp_num ='1' THEN -- push pc into stack 
							ram(to_integer(unsigned(address)-1)) <= datain(31 downto 16);
						END IF;
					END IF;
                		END IF;

		END PROCESS;
	-- extending ram data to fit the output
	extend_alu: sign_extend GENERIC MAP(32) PORT MAP( mem_out,mem_extended);
	-----------------------------------

	mem_out<=ram(to_integer(unsigned(address))) WHEN re='1' and (mem_Address = '0' or ( mem_Address = '1' and sp_num ='0'));
    
	dataout <= ram(2)&ram(3) WHEN is_exception='1' and mem_Address='0' 
	
	ELSE ram(4)&ram(5) WHEN is_exception='1' and mem_Address='1'
	ELSE mem_extended 
	WHEN re='1' and (mem_Address = '0' or ( mem_Address = '1' and sp_num ='0'))
	ELSE ram(to_integer(unsigned(address)))&ram(to_integer(unsigned(address)+1))
	WHEN is_int="01" or (re='1' and mem_Address = '1' and sp_num ='1');
	

    END memStageRamArch;
