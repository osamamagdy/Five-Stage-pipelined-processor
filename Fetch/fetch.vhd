LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY fetch IS
    GENERIC (
        N : INTEGER := 32
    );
    PORT (

        JumpAddress : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
        Exception   : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
        Stack       : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
        clk, reset  : IN STD_LOGIC;
        MUX1_SEL    : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        HLT         : IN STD_LOGIC;
        --
        MO_1 : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
        --
        pcOut      : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
        next_pcout : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
        IR         : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0)
    );
END fetch;
ARCHITECTURE fetch_structure OF fetch IS
    -------------- COMPONENTS --------------------------
    COMPONENT CheckImmediate IS PORT (
        PcIn    : IN STD_LOGIC_VECTOR (N - 1 DOWNTO 0);
        IR_temp : IN STD_LOGIC_VECTOR (N - 1 DOWNTO 0);
        pcOut   : OUT STD_LOGIC_VECTOR (N - 1 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT mux_21 IS
        PORT (
            selector : IN STD_LOGIC;
            muxIn1   : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
            muxIn2   : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
            muxOut   : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT mux_41 IS
        PORT (
            selector : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            muxIn1   : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
            muxIn2   : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
            muxIn3   : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
            muxIn4   : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
            muxOut   : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT instruction_mem IS
        GENERIC (
            MEMSize         : INTEGER := 16;
            MEMDataSize     : INTEGER := 32;
            MEMAddressWidth : INTEGER := 20
        );
        PORT (
            PC          : IN STD_LOGIC_VECTOR(MEMDataSize - 1 DOWNTO 0);
            RST         : IN STD_LOGIC;
            instruction : OUT STD_LOGIC_VECTOR(MEMDataSize - 1 DOWNTO 0);
            M0_1        : OUT STD_LOGIC_VECTOR(MEMDataSize - 1 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT PC_REGISTER IS
        PORT (
            D        : IN STD_LOGIC_VECTOR (N - 1 DOWNTO 0);
            CLK, HLT : IN STD_LOGIC;
            Q        : OUT STD_LOGIC_VECTOR (N - 1 DOWNTO 0)
        );
    END COMPONENT;

    ------------- SIGNALS -----------------------------------
    SIGNAL MUX1_PC, MUX2_PC, REG_PC, IRTEMP,pcIn, middle_pc,M0_1: STD_LOGIC_VECTOR(N - 1 DOWNTO 0);

BEGIN
     -- next pc chooser mux
     Mux1 : mux_41 GENERIC MAP(N) PORT MAP(MUX1_SEL, pcIn, JumpAddress ,Exception, Stack, MUX1_PC);

     Mux2 : mux_21 GENERIC MAP(N) PORT MAP(reset, MUX1_PC, M0_1, MUX2_PC);
 
     ------------------- PC --------------------------------
     PC : PC_REGISTER GENERIC MAP(N) PORT MAP(MUX2_PC, CLK, HLT, REG_PC);
     pcOut <= REG_PC;
     ------------- INSTUCTION MEMORY -----------------------
     INSTRUC_MEM : instruction_mem PORT MAP(REG_PC, CLK, IRTEMP, M0_1);
     IR <= IRTEMP;
 
     IMM_CHECK : CheckImmediate GENERIC MAP(N) PORT MAP(REG_PC, IRTEMP, middle_pc);
     next_pcout <= middle_pc;
     PcIn <= middle_pc ;

END fetch_structure;