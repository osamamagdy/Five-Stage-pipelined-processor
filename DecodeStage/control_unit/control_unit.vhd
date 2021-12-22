LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE work.ALL;
ENTITY CU IS
    PORT (
        RET : IN STD_LOGIC;
        IS_EXCEPTION : IN STD_LOGIC;
        RTI : IN STD_LOGIC;
        Flag_reg : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        OP_CODE : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
        EX_Flush : OUT STD_LOGIC;
        ID_Flush : OUT STD_LOGIC;
        MUX_10 : OUT STD_LOGIC;
        IF_Flush : OUT STD_LOGIC;
        HLT : OUT STD_LOGIC;
        MUX_5 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
        MUX_1 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
        Control_Signals : OUT STD_LOGIC_VECTOR (16 DOWNTO 0));
END CU;
ARCHITECTURE my_CU OF CU IS
BEGIN

    -------------------------------CONTROL_SIGNAL = Mem value 2, Mem Address 1 , SP OP 2, SP num 1 , WB  1, MEM 2, EX 4 , RTI 1 , Backup flage 2 , RET 1    
    PROCESS (OP_CODE, RET, IS_EXCEPTION, RTI, Flag_reg)
    BEGIN
        IF (OP_CODE = "00000") THEN ---NOP
            Control_Signals <= "00000000000000000";
            MUX_1 <= "00";
            HLT <= '0';
            MUX_5 <= "00";
            MUX_10 <= '0';
            IF_Flush <= IS_EXCEPTION;
            ID_Flush <= IS_EXCEPTION;
            EX_Flush <= IS_EXCEPTION;
        ELSIF (OP_CODE = "00001") THEN ---HLT
            Control_Signals <= "00000000000000000";
            MUX_1 <= "00";
            HLT <= '1';
            MUX_5 <= "00";
            MUX_10 <= '0';
            IF_Flush <= '1';
            ID_Flush <= IS_EXCEPTION;
            EX_Flush <= IS_EXCEPTION;
        ELSIF (OP_CODE = "00010") THEN ---SETC
            Control_Signals <= "00000000000000000";
            MUX_1 <= "00";
            HLT <= '0';
            MUX_5 <= "00";
            MUX_10 <= '0';
            IF_Flush <= IS_EXCEPTION;
            ID_Flush <= IS_EXCEPTION;
            EX_Flush <= IS_EXCEPTION;

        ELSIF (OP_CODE = "00011") THEN ---NOT
            Control_Signals <= "00000010000010000";
            MUX_1 <= "00";
            HLT <= '0';
            MUX_5 <= "01";
            MUX_10 <= '0';
            IF_Flush <= IS_EXCEPTION;
            ID_Flush <= IS_EXCEPTION;
            EX_Flush <= IS_EXCEPTION;
        ELSIF (OP_CODE = "00100") THEN ---INC
            Control_Signals <= "00000010000100000";
            MUX_1 <= "00";
            HLT <= '0';
            MUX_5 <= "01";
            MUX_10 <= '0';
            IF_Flush <= IS_EXCEPTION;
            ID_Flush <= IS_EXCEPTION;
            EX_Flush <= IS_EXCEPTION;
        ELSIF (OP_CODE = "00101") THEN ---OUT
            Control_Signals <= "00000000000110000";
            MUX_1 <= "00";
            HLT <= '0';
            MUX_5 <= "01";
            MUX_10 <= '0';
            IF_Flush <= IS_EXCEPTION;
            ID_Flush <= IS_EXCEPTION;
            EX_Flush <= IS_EXCEPTION;
        ELSIF (OP_CODE = "00110") THEN ---IN
            Control_Signals <= "00000010000110000";
            MUX_1 <= "00";
            HLT <= '0';
            MUX_5 <= "00";
            MUX_10 <= '0';
            IF_Flush <= IS_EXCEPTION;
            ID_Flush <= IS_EXCEPTION;
            EX_Flush <= IS_EXCEPTION;
        ELSIF (OP_CODE = "00111") THEN ---MOV
            Control_Signals <= "00000010000110000";
            MUX_1 <= "00";
            HLT <= '0';
            MUX_5 <= "10";
            MUX_10 <= '0';
            IF_Flush <= IS_EXCEPTION;
            ID_Flush <= IS_EXCEPTION;
            EX_Flush <= IS_EXCEPTION;
        ELSIF (OP_CODE = "01000") THEN ---ADD
            Control_Signals <= "00000010001000000";
            MUX_1 <= "00";
            HLT <= '0';
            MUX_5 <= "10";
            MUX_10 <= '0';
            IF_Flush <= IS_EXCEPTION;
            ID_Flush <= IS_EXCEPTION;
            EX_Flush <= IS_EXCEPTION;
        ELSIF (OP_CODE = "01001") THEN ---SUB
            Control_Signals <= "00000010001010000";
            MUX_1 <= "00";
            HLT <= '0';
            MUX_5 <= "10";
            MUX_10 <= '0';
            IF_Flush <= IS_EXCEPTION;
            ID_Flush <= IS_EXCEPTION;
            EX_Flush <= IS_EXCEPTION;
        ELSIF (OP_CODE = "01010") THEN ---AND
            Control_Signals <= "00000010001100000";
            MUX_1 <= "00";
            HLT <= '0';
            MUX_5 <= "10";
            MUX_10 <= '0';
            IF_Flush <= IS_EXCEPTION;
            ID_Flush <= IS_EXCEPTION;
            EX_Flush <= IS_EXCEPTION;
        ELSIF (OP_CODE = "01011") THEN ---IADD
            Control_Signals <= "00000010001000000";
            MUX_1 <= "00";
            HLT <= '0';
            MUX_5 <= "10";
            MUX_10 <= '1';
            IF_Flush <= IS_EXCEPTION;
            ID_Flush <= IS_EXCEPTION;
            EX_Flush <= IS_EXCEPTION;
        ELSIF (OP_CODE = "01100") THEN ---PUSH
            Control_Signals <= "01110000100110000";
            MUX_1 <= "00";
            HLT <= '0';
            MUX_5 <= "01";
            MUX_10 <= '0';
            IF_Flush <= IS_EXCEPTION;
            ID_Flush <= IS_EXCEPTION;
            EX_Flush <= IS_EXCEPTION;
        ELSIF (OP_CODE = "01101") THEN ---POP
            Control_Signals <= "00111011000000000";
            MUX_1 <= "00";
            HLT <= '0';
            MUX_5 <= "00";
            MUX_10 <= '0';
            IF_Flush <= IS_EXCEPTION;
            ID_Flush <= IS_EXCEPTION;
            EX_Flush <= IS_EXCEPTION;
        ELSIF (OP_CODE = "01110") THEN ---LDM
            Control_Signals <= "00000010001110000";
            MUX_1 <= "00";
            HLT <= '0';
            MUX_5 <= "00";
            MUX_10 <= '1';
            IF_Flush <= IS_EXCEPTION;
            ID_Flush <= IS_EXCEPTION;
            EX_Flush <= IS_EXCEPTION;
        ELSIF (OP_CODE = "01111") THEN ---LDD
            Control_Signals <= "00000011001000000";
            MUX_1 <= "00";
            HLT <= '0';
            MUX_5 <= "00";
            MUX_10 <= '1';
            IF_Flush <= IS_EXCEPTION;
            ID_Flush <= IS_EXCEPTION;
            EX_Flush <= IS_EXCEPTION;
        ELSIF (OP_CODE = "10000") THEN ---STD
            Control_Signals <= "00000000101000000";
            MUX_1 <= "00";
            HLT <= '0';
            MUX_5 <= "00";
            MUX_10 <= '1';
            IF_Flush <= IS_EXCEPTION;
            ID_Flush <= IS_EXCEPTION;
            EX_Flush <= IS_EXCEPTION;
        ELSIF (OP_CODE = "10001") THEN ---JZ
            Control_Signals <= "00000000010000000";
            MUX_1 <= "10";
            HLT <= '0';
            MUX_5 <= "00";
            MUX_10 <= '0';
            IF_Flush <= IS_EXCEPTION;
            ID_Flush <= IS_EXCEPTION;
            EX_Flush <= IS_EXCEPTION;
        ELSIF (OP_CODE = "10010") THEN ---JN
            Control_Signals <= "00000000010010000";
            MUX_1 <= "10";
            HLT <= '0';
            MUX_5 <= "00";
            MUX_10 <= '0';
            IF_Flush <= IS_EXCEPTION;
            ID_Flush <= IS_EXCEPTION;
            EX_Flush <= IS_EXCEPTION;
        ELSIF (OP_CODE = "10011") THEN ---JC
            Control_Signals <= "00000000010100000";
            MUX_1 <= "10";
            HLT <= '0';
            MUX_5 <= "00";
            MUX_10 <= '0';
            IF_Flush <= IS_EXCEPTION;
            ID_Flush <= IS_EXCEPTION;
            EX_Flush <= IS_EXCEPTION;
        ELSIF (OP_CODE = "10100") THEN ---JMP
            Control_Signals <= "00000000000000000";
            MUX_1 <= "10";
            HLT <= '0';
            MUX_5 <= "00";
            MUX_10 <= '0';
            IF_Flush <= IS_EXCEPTION;
            ID_Flush <= IS_EXCEPTION;
            EX_Flush <= IS_EXCEPTION;
        ELSIF (OP_CODE = "10101") THEN ---CALL
            Control_Signals <= "10110100100000000";
            MUX_1 <= "10";
            HLT <= '0';
            MUX_5 <= "00";
            MUX_10 <= '0';
            IF_Flush <= IS_EXCEPTION;
            ID_Flush <= IS_EXCEPTION;
            EX_Flush <= IS_EXCEPTION;
        ELSIF (OP_CODE = "10110") THEN ---RET
            Control_Signals <= "00111101000000001";
            MUX_1 <= "11";
            HLT <= '0';
            MUX_5 <= "00";
            MUX_10 <= '0';
            IF_Flush <= '0';
            ID_Flush <= '0';
            EX_Flush <= '0';
        ELSIF (OP_CODE = "10111") THEN ---INT
            Control_Signals <= "10110100100000010";
            MUX_1 <= "10";
            HLT <= '0';
            MUX_5 <= "00";
            MUX_10 <= '0';
            IF_Flush <= '1';
            ID_Flush <= '1';
            EX_Flush <= '1';
        ELSIF (OP_CODE = "11000") THEN ---RTI
            Control_Signals <= "00111101000001100";
            MUX_1 <= "11";
            HLT <= '0';
            MUX_5 <= "00";
            MUX_10 <= '0';
            IF_Flush <= '0';
            ID_Flush <= '0';
            EX_Flush <= '0';
        END IF;

    END PROCESS;

END my_CU;