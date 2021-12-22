LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ALU IS
    PORT (
        op1 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        op2 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        ctrl : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        current_flags : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        outputt : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        new_flags : OUT STD_LOGIC_VECTOR(2 DOWNTO 0));
END ALU;

ARCHITECTURE arch_ALU OF ALU IS
    COMPONENT my_nadder IS
        GENERIC (n : INTEGER := 8);
        PORT (
            a, b : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            cin : IN STD_LOGIC;
            s : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            cout : OUT STD_LOGIC);
    END COMPONENT;
    SIGNAL outp : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL adder : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL subtractor : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL inc : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL Nop2 : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL adder_carry, subtractor_carry, inc_carry, zero : STD_LOGIC;

    CONSTANT SETC_c : STD_LOGIC_VECTOR (3 DOWNTO 0) := "0000";
    CONSTANT NOT_c : STD_LOGIC_VECTOR (3 DOWNTO 0) := "0001";
    CONSTANT INC_c : STD_LOGIC_VECTOR (3 DOWNTO 0) := "0010";
    CONSTANT PASSOP1_c : STD_LOGIC_VECTOR (3 DOWNTO 0) := "0011";
    CONSTANT ADD_c : STD_LOGIC_VECTOR (3 DOWNTO 0) := "0100";
    CONSTANT SUB_c : STD_LOGIC_VECTOR (3 DOWNTO 0) := "0101";
    CONSTANT AND_c : STD_LOGIC_VECTOR (3 DOWNTO 0) := "0110";
    CONSTANT PASSOP2_c : STD_LOGIC_VECTOR (3 DOWNTO 0) := "0111";
    CONSTANT CLEARZ_c : STD_LOGIC_VECTOR (3 DOWNTO 0) := "1000";
    CONSTANT CLEARN_c : STD_LOGIC_VECTOR (3 DOWNTO 0) := "1001";
    CONSTANT CLEARC_c : STD_LOGIC_VECTOR (3 DOWNTO 0) := "1010";

BEGIN
    u1 : my_nadder GENERIC MAP(16) PORT MAP(op1, op2, '0', adder, adder_carry);
    -- A - B = A + ~B + 1
    u2 : my_nadder GENERIC MAP(16) PORT MAP(op1, Nop2, '1', subtractor, subtractor_carry);
    u3 : my_nadder GENERIC MAP(16) PORT MAP(op1, X"0001", '0', inc, inc_carry);

    outputt <= outp;

    Nop2 <= NOT(op2);
    zero <= '1' WHEN outp = X"0000" ELSE
        '0';
    outp <= op1 WHEN ctrl = PASSOP1_c -- Pass op1
        ELSE
        op2 WHEN ctrl = PASSOP2_c -- Pass op2
        ELSE
        NOT(op1) WHEN ctrl = NOT_c -- NOT
        ELSE
        inc WHEN ctrl = INC_c -- INC
        ELSE
        adder WHEN ctrl = ADD_c -- ADD
        ELSE
        subtractor WHEN ctrl = SUB_c -- SUB
        ELSE
        op1 AND op2 WHEN ctrl = AND_c -- AND
        ELSE
        (OTHERS => '0');

    new_flags <= current_flags(2 DOWNTO 1) & '1' WHEN ctrl = SETC_c -- SETC
        ELSE
        zero & outp(15) & current_flags(0) WHEN ctrl = NOT_c -- NOT
        ELSE
        zero & outp(15) & current_flags(0) WHEN ctrl = INC_c -- INC
        ELSE
        zero & outp(15) & adder_carry WHEN ctrl = ADD_c -- ADD 
        ELSE
        zero & outp(15) & NOT(subtractor_carry) WHEN ctrl = SUB_c -- SUB
        ELSE
        zero & outp(15) & current_flags(0) WHEN ctrl = AND_c -- AND
        ELSE
        '0' & current_flags(1 DOWNTO 0) WHEN ctrl = CLEARZ_c -- CLEAR Z
        ELSE
        current_flags(2) & '0' & current_flags(0) WHEN ctrl = CLEARN_c -- CLEAR N
        ELSE
        current_flags(2 DOWNTO 1) & '0' WHEN ctrl = CLEARC_c -- CLEAR C 
        ELSE
        current_flags;

END ARCHITECTURE;