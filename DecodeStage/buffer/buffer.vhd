LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE work.ALL;
---------------------------------------------------------------------------
--------------------------------------------one-bit Fliflop----------------
ENTITY
    my_DFF IS
    PORT (
        d, clk, rst : IN STD_LOGIC;
        q : OUT STD_LOGIC);
END my_DFF;
---------------------------------------------------------------------------
ARCHITECTURE
    a_my_DFF OF my_DFF IS
BEGIN
    PROCESS (clk, rst)
    BEGIN
        IF (rst = '1') THEN
            q <= '0';
        ELSIF (rising_edge(clk) AND rst = '0') THEN
            q <= d;
        END IF;
    END PROCESS;
END a_my_DFF;
----------------------------------------------------------------------------
--------------------------------------Generic Reg--------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE work.ALL;
ENTITY my_nDFF IS
    GENERIC (n : INTEGER := 16);
    PORT (
        Clk, rst : IN STD_LOGIC;
        d : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
        q : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0));
END my_nDFF;

ARCHITECTURE b_my_nDFF OF my_nDFF IS
    COMPONENT my_DFF IS
        PORT (
            d, Clk, rst : IN STD_LOGIC;
            q : OUT STD_LOGIC);
    END COMPONENT;
BEGIN
    loop1 : FOR i IN 0 TO n - 1 GENERATE
        ------They have the same Clk, Rst, en bit as we want to move the entire 32-bit together
        fx : my_DFF PORT MAP(d(i), Clk, rst, q(i));
    END GENERATE;
END b_my_nDFF;
------------------------------------------------------------------------------
--------------------------------------ID/EX Buffer--------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE work.ALL;
ENTITY ID_Buffer IS
    PORT (
    Clk, rst : IN STD_LOGIC;

    --------Inputs
    Control_Signal : IN STD_LOGIC_VECTOR(16 DOWNTO 0);
    IN_PC : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    IN_NEXT_PC : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
    IN_RS_DATA : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
    IN_SEC_OP : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
    IN_RD_ADD : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    IN_RS_ADD : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    IN_RT_ADD : IN STD_LOGIC_VECTOR (2 DOWNTO 0);

    -------Outputs
    OUT_PC : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
    OUT_NEXT_PC : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
    OUT_RS_DATA : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
    OUT_SEC_OP : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
    OUT_RD_ADD : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
    OUT_RS_ADD : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
    OUT_RT_ADD : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);

    -------Outputs from Control register
    MEM_VAL : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    MEM_ADD : OUT STD_LOGIC;
    SP_OP : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    SP_NUM : OUT STD_LOGIC;
    WB : OUT STD_LOGIC;
    MEM : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    EX : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    RTI : OUT STD_LOGIC;
    BACKUP_FLAG : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    RET : OUT STD_LOGIC);

END ID_Buffer;

ARCHITECTURE my_Buffer OF ID_Buffer IS
BEGIN
    ------They have the same Clk, Rst, en bit as we want to move the entire 32-bit together
    myMem_Value : ENTITY work.my_nDFF GENERIC MAP (2) PORT MAP(Clk => Clk, rst => rst, d => Control_Signal(16 DOWNTO 15), q => MEM_VAL);
    myMem_Address : ENTITY work.my_DFF PORT MAP(Clk => Clk, rst => rst, d => Control_Signal(14), q => MEM_ADD);
    myPC : ENTITY work.my_nDFF GENERIC MAP (32) PORT MAP(Clk => Clk, rst => rst, d =>IN_PC, q => OUT_PC);
    myNext_Pc : ENTITY work.my_nDFF GENERIC MAP (32) PORT MAP(Clk => Clk, rst => rst, d =>IN_NEXT_PC, q => OUT_NEXT_PC);
    mySp_Op : ENTITY work.my_nDFF GENERIC MAP (2) PORT MAP(Clk => Clk, rst => rst, d => Control_Signal(13 DOWNTO 12), q => SP_OP);
    mySp_Num : ENTITY work.my_DFF PORT MAP(Clk => Clk, rst => rst, d => Control_Signal(11), q => SP_NUM);
    myWb : ENTITY work.my_DFF PORT MAP(Clk => Clk, rst => rst, d => Control_Signal(10), q => WB);
    myMem : ENTITY work.my_nDFF GENERIC MAP (2) PORT MAP(Clk => Clk, rst => rst, d => Control_Signal(9 DOWNTO 8), q => MEM);
    myEx : ENTITY work.my_nDFF GENERIC MAP (4) PORT MAP(Clk => Clk, rst => rst, d => Control_Signal(7 DOWNTO 4), q => EX);
    myRS_DATA : ENTITY work.my_nDFF GENERIC MAP (16) PORT MAP(Clk => Clk, rst => rst, d =>IN_RS_DATA, q => OUT_RS_DATA);
    mySecond_op : ENTITY work.my_nDFF GENERIC MAP (16) PORT MAP(Clk => Clk, rst => rst, d =>IN_SEC_OP, q => OUT_SEC_OP);
    myRti : ENTITY work.my_DFF PORT MAP(Clk => Clk, rst => rst, d => Control_Signal(3), q => RTI);
    myBackup_Flag : ENTITY work.my_nDFF GENERIC MAP (2) PORT MAP(Clk => Clk, rst => rst, d => Control_Signal(2 DOWNTO 1), q => BACKUP_FLAG);
    myRd_Address : ENTITY work.my_nDFF GENERIC MAP (3) PORT MAP(Clk => Clk, rst => rst, d =>IN_RD_ADD, q => OUT_RD_ADD);
    myRs_Address : ENTITY work.my_nDFF GENERIC MAP (3) PORT MAP(Clk => Clk, rst => rst, d =>IN_RS_ADD, q => OUT_RS_ADD);
    myRt_Address : ENTITY work.my_nDFF GENERIC MAP (3) PORT MAP(Clk => Clk, rst => rst, d =>IN_RT_ADD, q => OUT_RT_ADD);
    myRet : ENTITY work.my_DFF PORT MAP(Clk => Clk, rst => rst, d => Control_Signal(0), q => RET);

END my_Buffer;