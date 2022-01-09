LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ExecutionStage IS
    PORT (
        -- Inputs
        clk : IN STD_LOGIC;
        -- to enable writing on output port
        out_port_en : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        memValuein : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        memAddressin : IN STD_LOGIC;
        PCin : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        nextPCin : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        SPOPin : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        SPNUMin : IN STD_LOGIC;
        WBin : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        MEM : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        EX : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        RSdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        DATA_FOR_STORE : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        secondOperand : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        RTIin : IN STD_LOGIC;
        BackupFlag : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        rdAddressin : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        rsAddress : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        rtAddress : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        RETin : IN STD_LOGIC;
        EXflush : IN STD_LOGIC;

        ---------Forwarding Unit : Requires a mux for op1 and op2 with the selector from forwarding unit 
        MEM_WB_RD : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
        EX_MEM_ALURESULT : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
        MUX_8_SEL : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
        MUX_9_SEL : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
        abbas_SEL : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
        -- Outputs
        memValueout : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        memAddressout : OUT STD_LOGIC;
        nextPCout : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        WBout : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        MemRe : OUT STD_LOGIC;
        MemWr : OUT STD_LOGIC;
        SPOPout : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        SPNUMout : OUT STD_LOGIC;
        Rsrc1 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        RTIout : OUT STD_LOGIC;
        RETout : OUT STD_LOGIC;
        PCout : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        rdAddressout : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        -- ALU
        ALUres : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        flags : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        -- jump
        jumpAddress : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        -- to enable writing on output port
        out_port_en_out : OUT STD_LOGIC;
        IN_DISABLE_FORWARDING : IN STD_LOGIC;
        IN_IS_STORE_OP : IN STD_LOGIC;
        DISABLE_FORWARDING : OUT STD_LOGIC;
        IS_STORE_OP : OUT STD_LOGIC;
        ---Branching 
        IN_EX_BRANCH : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        IN_MEM_BRANCH : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
        OUT_EX_BRANCH : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        OUT_MEM_BRANCH : OUT STD_LOGIC_VECTOR (1 DOWNTO 0)

    );
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
    SIGNAL abbas : STD_LOGIC_VECTOR(15 DOWNTO 0);

    SIGNAL WBtemp : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL MEMtemp : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL ALUtemp : STD_LOGIC_VECTOR(15 DOWNTO 0);

BEGIN
    aluF : ALUwithFlags PORT MAP(op1, op2, EX, RTIin, clk, BackupFlag(0), reset, ALUtemp, flags);

    ------MUX 8 SELECTOR
    op1 <= EX_MEM_ALURESULT WHEN MUX_8_SEL = "10"
        ELSE
        MEM_WB_RD WHEN MUX_8_SEL = "01"
        ELSE
        RSdata;

    -----MUX 9 SELECTOR         
    op2 <= EX_MEM_ALURESULT WHEN MUX_9_SEL = "10"
        ELSE
        MEM_WB_RD WHEN MUX_9_SEL = "01"
        ELSE
        secondOperand;

    -----MUX Abbas SELECTOR  
    abbas <= MEM_WB_RD WHEN abbas_SEL = "10"
        ELSE
        EX_MEM_ALURESULT WHEN abbas_SEL = "01"
        ELSE
        DATA_FOR_STORE;

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
            out_port_en_out <= '0';
            memValueout <= (OTHERS => '0');
            memAddressout <= '0';
            nextPCout <= (OTHERS => '0');
            WBout <= (OTHERS => '0');
            MemRe <= '0';
            MemWr <= '0';
            SPOPout <= (OTHERS => '0');
            SPNUMout <= '0';
            Rsrc1 <= (OTHERS => '0');
            RTIout <= '0';
            RETout <= '0';
            PCout <= (OTHERS => '0');
            rdAddressout <= (OTHERS => '0');
            ALUres <= (OTHERS => '0');
            DISABLE_FORWARDING <= '0';
            IS_STORE_OP <= '0';
            OUT_MEM_BRANCH <= (OTHERS => '0');
            OUT_EX_BRANCH <= (OTHERS => '0');
        ELSIF rising_edge(clk) THEN
            out_port_en_out <= out_port_en;
            memValueout <= memValuein;
            memAddressout <= memAddressin;
            nextPCout <= nextPCin;
            WBout <= WBin;
            MemRe <= MEMtemp(1);
            MemWr <= MEMtemp(0);
            SPOPout <= SPOPin;
            SPNUMout <= SPNUMin;
            Rsrc1 <= abbas;
            RTIout <= RTIin;
            RETout <= RETin;
            PCout <= PCin;
            rdAddressout <= rdAddressin;
            ALUres <= ALUtemp;
            DISABLE_FORWARDING <= IN_DISABLE_FORWARDING;
            IS_STORE_OP <= IN_IS_STORE_OP;
            OUT_MEM_BRANCH <= IN_MEM_BRANCH;
            OUT_EX_BRANCH <= IN_EX_BRANCH;
        END IF;
    END PROCESS;
END ARCHITECTURE;