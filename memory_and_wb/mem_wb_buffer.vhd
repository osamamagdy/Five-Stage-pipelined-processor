LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY
    mem_wb_buffer IS
    PORT (
        flush : IN STD_LOGIC;
	clk: IN STD_LOGIC;
	------ INPUTS Description------
	-- INPUT[55]-> out_port_en;
	-- incication of enabling the wb
	-- INPUT[54]-> wb_en: IN std_logic;
	-- mux 14 selector
	--to choose whether to write back the alu result or the memory output
	-- INPUT[53]-> alu_mem: IN std_logic;
	-- input to mux 14: to be writed back
	-- input to output port
	-- INPUT[52: 37]-> alu_res: IN std_logic_vector(15 downto 0);
	-- memory output
	-- INPUT[36: 5]-> mem: IN std_logic_vector(31 downto 0);
	-- ret interrupt enable
	-- INPUT[4]-> rti: IN std_logic;
	-- ret from call enable
	-- INPUT[3]-> ret: in std_logic;
	-- rd address: the destination register, to enter the forwarding unit
	-- INPUT[2:0]-> rd_address_output: in std_logic_vector(2 downto 0);
	input: IN std_logic_vector( 57 downto 0 );
    output : OUT std_logic_vector( 57 downto 0 ));
END mem_wb_buffer;

ARCHITECTURE
    arch_mem_wb_buffer OF mem_wb_buffer IS
	SIGNAL q: std_logic_vector( 57 downto 0 );
	
	BEGIN
		output<= q;
    		process(clk, flush)
			begin
				if(flush= '1') THEN -- reset all outputs
					q<= (others=>'0');
				else if(rising_edge(clk))THEN 
					q<= input;
				end if;
				end if;
	
		end process;

    
END arch_mem_wb_buffer;
