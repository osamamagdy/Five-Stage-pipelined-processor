LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ALUwithFlags IS
    PORT (
        op1 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        op2 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        ctrl : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        rti : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        backup_en : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        outputt : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        flags : OUT STD_LOGIC_VECTOR(2 DOWNTO 0));
END ALUwithFlags;

ARCHITECTURE arch OF ALUwithFlags IS
    COMPONENT ALU IS
        PORT (
            op1 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            op2 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            ctrl : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            current_flags : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            outputt : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            new_flags : OUT STD_LOGIC_VECTOR(2 DOWNTO 0));
    END COMPONENT;
    SIGNAL current_flags : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL flags_backup : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL new_flags : STD_LOGIC_VECTOR(2 DOWNTO 0);
BEGIN
    alu1 : ALU PORT MAP(op1, op2, ctrl, current_flags, outputt, new_flags);

    flags <= current_flags;

    -- en rti
    -- 0 0 backup doesn't change
    -- 0 1 flags reads from backup
    -- 1 0 backup reads from flags

    backup : PROCESS (clk, reset)
    BEGIN
        IF reset = '1' THEN
            flags_backup <= (OTHERS => '0');
            current_flags <= (OTHERS => '0');
        ELSIF rising_edge(clk) THEN
            IF backup_en = '1' THEN
                flags_backup <= current_flags;
            END IF;
            IF rti = '1' THEN
                current_flags <= flags_backup;
            ELSE
                current_flags <= new_flags;
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE;