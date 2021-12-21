LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ExecutionStage IS
    PORT (
        -- Inputs
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        memValuein : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        memAddressin : IN STD_LOGIC;
        PCin : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        nextPCin : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        SPOPin : IN STD_LOGIC;
        SPNUMin : IN STD_LOGIC;
        WBin : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        MEM : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        EX : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        RSdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        secondOperand : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        RTIin : IN STD_LOGIC;
        BackupFlag : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        rdAddressin : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        rsAddress : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        rtAddress : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        RETin : IN STD_LOGIC;
        EXflush : IN STD_LOGIC;
        Rsrc1in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);

        -- Outputs
        memValueout : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        memAddressout : OUT STD_LOGIC;
        nextPCout : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        WBout : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        MemRe : OUT STD_LOGIC;
        MemWr : OUT STD_LOGIC;
        SPOPout : OUT STD_LOGIC;
        SPNUMout : OUT STD_LOGIC;
        Rsrc1out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        RTIout : OUT STD_LOGIC;
        RETout : OUT STD_LOGIC;
        PCout : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        rdAddressout : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        -- ALU
        ALUres : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        flags : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        -- jump
        jumpAddress : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END ExecutionStage;

ARCHITECTURE arch OF ExecutionStage IS
    COMPONENT ALUwithFlags IS
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
    END COMPONENT;

    SIGNAL op1 : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL op2 : STD_LOGIC_VECTOR(15 DOWNTO 0);

    SIGNAL WBtemp : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL MEMtemp : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL ALUtemp : STD_LOGIC_VECTOR(15 DOWNTO 0);
BEGIN
    aluF : ALUwithFlags PORT MAP(op1, op2, EX, RTIin, clk, BackupFlag(0), reset, ALUtemp, flags);

    -- op1 <= RSdata WHEN mux = '0'
    --     ELSE
    --     forward WHEN mux = '1';

    op1 <= RSdata;
    op2 <= secondOperand;

    jumpAddress <= "0000000000000000" & op1;
    WBtemp <= WBin WHEN EXflush = '0'
        ELSE
        (OTHERS => '0') WHEN EXflush = '1';
    MEMtemp <= MEM WHEN EXflush = '0'
        ELSE
        (OTHERS => '0') WHEN EXflush = '1';

    backup : PROCESS (clk, reset)
    BEGIN
        IF reset = '1' THEN

            memValueout <= (OTHERS => '0');
            memAddressout <= '0';
            nextPCout <= (OTHERS => '0');
            WBout <= (OTHERS => '0');
            MemRe <= '0';
            MemWr <= '0';
            SPOPout <= '0';
            SPNUMout <= '0';
            Rsrc1out <= (OTHERS => '0');
            RTIout <= '0';
            RETout <= '0';
            PCout <= (OTHERS => '0');
            rdAddressout <= (OTHERS => '0');
            ALUres <= (OTHERS => '0');
        ELSIF rising_edge(clk) THEN
            memValueout <= memValuein;
            memAddressout <= memAddressin;
            nextPCout <= nextPCin;
            WBout <= WBin;
            MemRe <= MEMtemp(0);
            MemWr <= MEMtemp(1);
            SPOPout <= SPOPin;
            SPNUMout <= SPNUMin;
            Rsrc1out <= Rsrc1in;
            RTIout <= RTIin;
            RETout <= RETin;
            PCout <= PCin;
            rdAddressout <= rdAddressin;
            ALUres <= ALUtemp;
        END IF;
    END PROCESS;

END ARCHITECTURE;