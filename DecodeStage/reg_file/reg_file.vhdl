LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE work.ALL;

ENTITY reg_file IS
    GENERIC (n : INTEGER := 16);
    PORT (
        Clk : IN STD_LOGIC;
        address_read_1, address_read_2, address_read_3, address_write : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        en_write : IN STD_LOGIC;
        write_data_bus : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
        read_1_data_bus, read_2_data_bus, read_3_data_bus : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));

END entity;

ARCHITECTURE my_reg_file OF reg_file IS
    COMPONENT my_nDFF IS
        PORT (
            Clk, en : IN STD_LOGIC;
            d : IN STD_LOGIC_VECTOR( n-1 DOWNTO 0);
            q : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
    END COMPONENT;

    COMPONENT nTRI IS
        PORT (
            control : IN STD_LOGIC;
            input : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
            output : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
    END COMPONENT;

    COMPONENT Decoder IS
        PORT (
            en : IN STD_LOGIC;
            Input : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            Output : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
    END COMPONENT;

----These will contain enable bits for Tri state buffers (read) and each one's size = 8 (number of registers)
    SIGNAL address_read_1_bus : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL address_read_2_bus : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL address_read_3_bus : STD_LOGIC_VECTOR(7 DOWNTO 0);

----This will contain enable bits for registers (write)
    SIGNAL address_write_bus : STD_LOGIC_VECTOR(7 DOWNTO 0);

----This is the output of each rigister (input to tri state)
    type signal_output is array (0 to 7) of std_logic_vector(n-1 downto 0);
    signal SIGNAL_FROM_FF : signal_output;

BEGIN

    add_read_1 : Decoder PORT MAP( en => '1', Input =>address_read_1, Output => address_read_1_bus);
    add_read_2 : Decoder PORT MAP( en => '1', Input =>address_read_2, Output => address_read_2_bus);
    add_read_3 : Decoder PORT MAP( en => '1', Input =>address_read_3, Output => address_read_3_bus);
    
    add_write : Decoder PORT MAP( en => en_write, Input =>address_write, Output => address_write_bus);

----Generate 8 FlipFlops connected to 8 Tri-state buffers
    loop1 : FOR i IN 0 TO 7 GENERATE


    flipflopx : my_nDFF PORT MAP( Clk =>clk, en =>address_write_bus(i), d => write_data_bus, q => SIGNAL_FROM_FF(i) );
    Tri_1_statex: nTRI PORT MAP( control => address_read_1_bus(i), input =>SIGNAL_FROM_FF(i), output =>read_1_data_bus);
    Tri_2_statex: nTRI PORT MAP( control => address_read_2_bus(i), input =>SIGNAL_FROM_FF(i), output =>read_2_data_bus);
    Tri_3_statex: nTRI PORT MAP( control => address_read_3_bus(i), input =>SIGNAL_FROM_FF(i), output =>read_3_data_bus);
    END GENERATE;



END my_reg_file;