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
        IN_EX_BRANCH : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        IN_MEM_BRANCH : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
        EX_Flush : OUT STD_LOGIC;
        ID_Flush : OUT STD_LOGIC;
        MUX_10 : OUT STD_LOGIC;
        DISABLE_FORWARDING : OUT STD_LOGIC;
        IS_STORE_OP : OUT STD_LOGIC;
        IF_Flush : OUT STD_LOGIC;
        HLT : OUT STD_LOGIC;
        MUX_5 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
        MUX_1 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
        OUT_EX_BRANCH : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        OUT_MEM_BRANCH : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
        Control_Signals : OUT STD_LOGIC_VECTOR (18 DOWNTO 0));
END CU;
ARCHITECTURE my_CU OF CU IS
BEGIN

    -------------------------------CONTROL_SIGNAL = Mem value 2, Mem Address 1 , SP OP 2, SP num 1 , WB  2, MEM 2, EX 4 , RTI 1 , Backup flage 2 , RET 1    
    PROCESS (OP_CODE, RET, IS_EXCEPTION, RTI, Flag_reg , IN_EX_BRANCH , IN_MEM_BRANCH)
    BEGIN
        IF (IS_EXCEPTION = '1' ) THEN --exception
        Control_Signals <= "0000000000000000000";
        MUX_1 <= "10";
        MUX_5 <= "00";
        MUX_10 <= '0';
        OUT_EX_BRANCH <= "000";
        OUT_MEM_BRANCH <= "00";
        IF_Flush <= '1';
        ID_Flush <= '1';
        EX_Flush <= '1';
        
        DISABLE_FORWARDING <= '0';
        IS_STORE_OP <= '0';
        ELSIF ( IN_MEM_BRANCH = "01" ) THEN --call
        Control_Signals <= "0000000000000000000";
        MUX_1 <= "11";
        MUX_5 <= "00";
        MUX_10 <= '0';
        OUT_EX_BRANCH <= "000";
        OUT_MEM_BRANCH <= "00";
        IF_Flush <= '1';
        ID_Flush <= '1';
        EX_Flush <= '1';
        DISABLE_FORWARDING <= '0';
        IS_STORE_OP <= '0';

        ELSIF ( IN_MEM_BRANCH = "10" ) THEN --INT0
        Control_Signals <= "0000000000000000000";
        MUX_1 <= "11";
        MUX_5 <= "00";
        MUX_10 <= '0';
        OUT_EX_BRANCH <= "000";
        OUT_MEM_BRANCH <= "00";
        IF_Flush <= '1';
        ID_Flush <= '1';
        EX_Flush <= '1';
        DISABLE_FORWARDING <= '0';
        IS_STORE_OP <= '0';

        ELSIF ( IN_MEM_BRANCH = "11" ) THEN --INT1
        Control_Signals <= "0000000000000000000";
        MUX_1 <= "11";
        MUX_5 <= "00";
        MUX_10 <= '0';
        OUT_EX_BRANCH <= "000";
        OUT_MEM_BRANCH <= "00";
        IF_Flush <= '1';
        ID_Flush <= '1';
        EX_Flush <= '1';
        DISABLE_FORWARDING <= '0';
        IS_STORE_OP <= '0';


        ELSIF ( RET = '1' ) THEN --RET
        Control_Signals <= "0000000000000000000";
        MUX_1 <= "11";
        MUX_5 <= "00";
        MUX_10 <= '0';
        OUT_EX_BRANCH <= "000";
        OUT_MEM_BRANCH <= "00";
        IF_Flush <= '1';
        ID_Flush <= '1';
        EX_Flush <= '1';
        DISABLE_FORWARDING <= '0';
        IS_STORE_OP <= '0';


        ELSIF ( RTI = '1' ) THEN --RTI
        Control_Signals <= "0000000000000000000";
        MUX_1 <= "11";
        MUX_5 <= "00";
        MUX_10 <= '0';
        OUT_EX_BRANCH <= "000";
        OUT_MEM_BRANCH <= "00";
        IF_Flush <= '1';
        ID_Flush <= '1';
        EX_Flush <= '1';
        DISABLE_FORWARDING <= '0';
        IS_STORE_OP <= '0';


        ELSIF (IN_EX_BRANCH = "001" AND Flag_reg(2) = '1' )THEN --Executing the JZ 
        Control_Signals <= "0000000000000000000";
        MUX_1 <= "01";
        MUX_5 <= "00";
        MUX_10 <= '0';
        OUT_EX_BRANCH <= "000";
        OUT_MEM_BRANCH <= "00";
        IF_Flush <= '1';
        ID_Flush <= '1';
        EX_Flush <= '1';
        DISABLE_FORWARDING <= '0';
        IS_STORE_OP <= '0';


        ELSIF ( IN_EX_BRANCH = "010" AND Flag_reg(1) = '1') THEN --Executing the JN
        Control_Signals <= "0000000000000000000";
        MUX_1 <= "01";
        MUX_5 <= "00";
        MUX_10 <= '0';
        OUT_EX_BRANCH <= "000";
        OUT_MEM_BRANCH <= "00";
        IF_Flush <= '1';
        ID_Flush <= '1';
        EX_Flush <= '1';
        DISABLE_FORWARDING <= '0';
        IS_STORE_OP <= '0';

        ELSIF ( IN_EX_BRANCH = "011" AND Flag_reg(0) = '1') THEN --Executing the JC
        Control_Signals <= "0000000000000000000";
        MUX_1 <= "01";
        MUX_5 <= "00";
        MUX_10 <= '0';
        OUT_EX_BRANCH <= "000";
        OUT_MEM_BRANCH <= "00";
        IF_Flush <= '1';
        ID_Flush <= '1';
        EX_Flush <= '1';
        DISABLE_FORWARDING <= '0';
        IS_STORE_OP <= '0';

        ELSIF ( IN_EX_BRANCH = "100") THEN --Executing the Jmp
        Control_Signals <= "0000000000000000000";
        MUX_1 <= "01";
        MUX_5 <= "00";
        MUX_10 <= '0';
        OUT_EX_BRANCH <= "000";
        OUT_MEM_BRANCH <= "00";
        IF_Flush <= '1';
        ID_Flush <= '1';
        EX_Flush <= '1';
        DISABLE_FORWARDING <= '0';
        IS_STORE_OP <= '0';

        ELSE
            IF (OP_CODE = "00000") THEN ---NOP
                Control_Signals <= "0000000000000000000";
                MUX_1 <= "00";
                MUX_5 <= "00";
                MUX_10 <= '0';
                OUT_EX_BRANCH <= "000";
                OUT_MEM_BRANCH <= "00";
                IF_Flush <= IS_EXCEPTION;
                ID_Flush <= IS_EXCEPTION;
                EX_Flush <= IS_EXCEPTION;
                DISABLE_FORWARDING <= '0';
                IS_STORE_OP <= '0';
                ELSIF (OP_CODE = "00001") THEN ---HLT
                Control_Signals <= "0000000000000000000";
                MUX_1 <= "00";
                HLT <= '1';
                MUX_5 <= "00";
                MUX_10 <= '0';
                IF_Flush <= '1';
                OUT_EX_BRANCH <= "000";
                OUT_MEM_BRANCH <= "00";
                ID_Flush <= IS_EXCEPTION;
                EX_Flush <= IS_EXCEPTION;
                DISABLE_FORWARDING <= '0';
                IS_STORE_OP <= '0';
        
                ELSIF (OP_CODE = "00010") THEN ---SETC
                Control_Signals <= "0000000000000000000";
                MUX_1 <= "00";
                MUX_5 <= "00";
                MUX_10 <= '0';
                IF_Flush <= IS_EXCEPTION;
                ID_Flush <= IS_EXCEPTION;
                EX_Flush <= IS_EXCEPTION;
                OUT_EX_BRANCH <= "000";
                OUT_MEM_BRANCH <= "00";
                DISABLE_FORWARDING <= '0';
                IS_STORE_OP <= '0';
        
            ELSIF (OP_CODE = "00011") THEN ---NOT
                Control_Signals <= "0000000100000010000";
                MUX_1 <= "00";
                MUX_5 <= "01";
                MUX_10 <= '0';
                OUT_EX_BRANCH <= "000";
                OUT_MEM_BRANCH <= "00";
                IF_Flush <= IS_EXCEPTION;
                ID_Flush <= IS_EXCEPTION;
                EX_Flush <= IS_EXCEPTION;

                DISABLE_FORWARDING <= '0';
                IS_STORE_OP <= '0';
        
                ELSIF (OP_CODE = "00100") THEN ---INC
                Control_Signals <= "0000000100000100000";
                MUX_1 <= "00";
                MUX_5 <= "01";
                MUX_10 <= '0';
                OUT_EX_BRANCH <= "000";
                OUT_MEM_BRANCH <= "00";
                IF_Flush <= IS_EXCEPTION;
                ID_Flush <= IS_EXCEPTION;
                EX_Flush <= IS_EXCEPTION;
                DISABLE_FORWARDING <= '0';
                IS_STORE_OP <= '0';
        
                ELSIF (OP_CODE = "00101") THEN ---OUT
                Control_Signals <= "1000000000000110000";
                MUX_1 <= "00";
                MUX_5 <= "01";
                MUX_10 <= '0';
                OUT_EX_BRANCH <= "000";
                OUT_MEM_BRANCH <= "00";
                IF_Flush <= IS_EXCEPTION;
                ID_Flush <= IS_EXCEPTION;
                EX_Flush <= IS_EXCEPTION;
                DISABLE_FORWARDING <= '0';
                IS_STORE_OP <= '0';
        
                ELSIF (OP_CODE = "00110") THEN ---IN
                Control_Signals <= "0000000100000110000";
                MUX_1 <= "00";
                MUX_5 <= "00";
                MUX_10 <= '0';
                OUT_EX_BRANCH <= "000";
                OUT_MEM_BRANCH <= "00";
                IF_Flush <= IS_EXCEPTION;
                ID_Flush <= IS_EXCEPTION;
                EX_Flush <= IS_EXCEPTION;
                DISABLE_FORWARDING <= '1';
                IS_STORE_OP <= '0';
        
                ELSIF (OP_CODE = "00111") THEN ---MOV
                Control_Signals <= "0000000100000110000";
                OUT_EX_BRANCH <= "000";
                OUT_MEM_BRANCH <= "00";
                MUX_1 <= "00";
                MUX_5 <= "10";
                MUX_10 <= '0';
                IF_Flush <= IS_EXCEPTION;
                ID_Flush <= IS_EXCEPTION;
                EX_Flush <= IS_EXCEPTION;
                DISABLE_FORWARDING <= '0';
                IS_STORE_OP <= '0';
        
                ELSIF (OP_CODE = "01000") THEN ---ADD
                Control_Signals <= "0000000100001000000";
                MUX_1 <= "00";
                OUT_EX_BRANCH <= "000";
                OUT_MEM_BRANCH <= "00";
                MUX_5 <= "10";
                MUX_10 <= '0';
                IF_Flush <= IS_EXCEPTION;
                ID_Flush <= IS_EXCEPTION;
                EX_Flush <= IS_EXCEPTION;
                DISABLE_FORWARDING <= '0';
                IS_STORE_OP <= '0';
        
                ELSIF (OP_CODE = "01001") THEN ---SUB
                Control_Signals <= "0000000100001010000";
                MUX_1 <= "00";
                OUT_EX_BRANCH <= "000";
                OUT_MEM_BRANCH <= "00";
                MUX_5 <= "10";
                MUX_10 <= '0';
                IF_Flush <= IS_EXCEPTION;
                ID_Flush <= IS_EXCEPTION;
                EX_Flush <= IS_EXCEPTION;
                DISABLE_FORWARDING <= '0';
                IS_STORE_OP <= '0';
        
                ELSIF (OP_CODE = "01010") THEN ---AND
                Control_Signals <= "0000000100001100000";
                MUX_1 <= "00";
                OUT_EX_BRANCH <= "000";
                OUT_MEM_BRANCH <= "00";
                MUX_5 <= "10";
                MUX_10 <= '0';
                IF_Flush <= IS_EXCEPTION;
                ID_Flush <= IS_EXCEPTION;
                EX_Flush <= IS_EXCEPTION;
                DISABLE_FORWARDING <= '0';
                IS_STORE_OP <= '0';
        
                ELSIF (OP_CODE = "01011") THEN ---IADD
                Control_Signals <= "0000000100001000000";
                MUX_1 <= "00";
                MUX_5 <= "10";
                MUX_10 <= '1';
                OUT_EX_BRANCH <= "000";
                OUT_MEM_BRANCH <= "00";
                IF_Flush <= IS_EXCEPTION;
                ID_Flush <= IS_EXCEPTION;
                EX_Flush <= IS_EXCEPTION;
                DISABLE_FORWARDING <= '0';
                IS_STORE_OP <= '0';
        
                ELSIF (OP_CODE = "01100") THEN ---PUSH
                Control_Signals <= "0011100000100110000";
                MUX_1 <= "00";
                OUT_EX_BRANCH <= "000";
                OUT_MEM_BRANCH <= "00";
                MUX_5 <= "01";
                MUX_10 <= '0';
                IF_Flush <= IS_EXCEPTION;
                ID_Flush <= IS_EXCEPTION;
                EX_Flush <= IS_EXCEPTION;
                DISABLE_FORWARDING <= '0';
                IS_STORE_OP <= '0';
        

                ELSIF (OP_CODE = "01101") THEN ---POP
                Control_Signals <= "0001110111000000000";
                MUX_1 <= "00";
                MUX_5 <= "00";
                OUT_EX_BRANCH <= "000";
                OUT_MEM_BRANCH <= "00";
                MUX_10 <= '0';
                IF_Flush <= IS_EXCEPTION;
                ID_Flush <= IS_EXCEPTION;
                EX_Flush <= IS_EXCEPTION;
                DISABLE_FORWARDING <= '0';
                IS_STORE_OP <= '0';
        
                ELSIF (OP_CODE = "01110") THEN ---LDM
                Control_Signals <= "0000000100001110000";
                MUX_1 <= "00";
                OUT_EX_BRANCH <= "000";
                OUT_MEM_BRANCH <= "00";
                MUX_5 <= "00";
                MUX_10 <= '1';
                IF_Flush <= IS_EXCEPTION;
                ID_Flush <= IS_EXCEPTION;
                EX_Flush <= IS_EXCEPTION;
                DISABLE_FORWARDING <= '0';
                IS_STORE_OP <= '0';
        
                ELSIF (OP_CODE = "01111") THEN ---LDD
                Control_Signals <= "0000000111001000000";
                MUX_1 <= "00";
                MUX_5 <= "10";
                OUT_EX_BRANCH <= "000";
                OUT_MEM_BRANCH <= "00";
                MUX_10 <= '1';
                IF_Flush <= IS_EXCEPTION;
                ID_Flush <= IS_EXCEPTION;
                EX_Flush <= IS_EXCEPTION;
                DISABLE_FORWARDING <= '0';
                IS_STORE_OP <= '0';
        
                ELSIF (OP_CODE = "10000") THEN ---STD
                Control_Signals <= "0000000000101000000";
                OUT_EX_BRANCH <= "000";
                OUT_MEM_BRANCH <= "00";
                MUX_1 <= "00";
                MUX_5 <= "11";
                MUX_10 <= '1';
                IF_Flush <= IS_EXCEPTION;
                ID_Flush <= IS_EXCEPTION;
                EX_Flush <= IS_EXCEPTION;
                DISABLE_FORWARDING <= '0';
                IS_STORE_OP <= '1';
        
                ELSIF (OP_CODE = "10001") THEN ---JZ
                Control_Signals <= "0000000000010000000";
                MUX_1 <= "10";
                MUX_5 <= "00";
                OUT_EX_BRANCH <= "001";
                OUT_MEM_BRANCH <= "00";
                MUX_10 <= '0';
                IF_Flush <= IS_EXCEPTION;
                ID_Flush <= IS_EXCEPTION;
                EX_Flush <= IS_EXCEPTION;
                DISABLE_FORWARDING <= '0';
                IS_STORE_OP <= '0';
        
                ELSIF (OP_CODE = "10010") THEN ---JN
                Control_Signals <= "0000000000010010000";
                MUX_1 <= "10";
                OUT_EX_BRANCH <= "010";
                OUT_MEM_BRANCH <= "00";
                MUX_5 <= "00";
                MUX_10 <= '0';
                IF_Flush <= IS_EXCEPTION;
                ID_Flush <= IS_EXCEPTION;
                EX_Flush <= IS_EXCEPTION;
                DISABLE_FORWARDING <= '0';
                IS_STORE_OP <= '0';
        
                ELSIF (OP_CODE = "10011") THEN ---JC
                OUT_EX_BRANCH <= "011";
                OUT_MEM_BRANCH <= "00";
                Control_Signals <= "0000000000010100000";
                MUX_1 <= "10";
                MUX_5 <= "00";
                MUX_10 <= '0';
                IF_Flush <= IS_EXCEPTION;
                ID_Flush <= IS_EXCEPTION;
                EX_Flush <= IS_EXCEPTION;
                DISABLE_FORWARDING <= '0';
                IS_STORE_OP <= '0';
        

                ELSIF (OP_CODE = "10100") THEN ---JMP
                Control_Signals <= "0000000000000000000";
                OUT_EX_BRANCH <= "100";
                OUT_MEM_BRANCH <= "00";
                MUX_1 <= "10";
                MUX_5 <= "00";
                MUX_10 <= '0';
                IF_Flush <= IS_EXCEPTION;
                ID_Flush <= IS_EXCEPTION;
                EX_Flush <= IS_EXCEPTION;
                DISABLE_FORWARDING <= '0';
                IS_STORE_OP <= '0';
        
                ELSIF (OP_CODE = "10101") THEN ---CALL
                Control_Signals <= "0101101000100000000";
                MUX_1 <= "10";
                OUT_EX_BRANCH <= "000";
                OUT_MEM_BRANCH <= "01";
                MUX_5 <= "00";
                MUX_10 <= '0';
                IF_Flush <= IS_EXCEPTION;
                ID_Flush <= IS_EXCEPTION;
                EX_Flush <= IS_EXCEPTION;
                DISABLE_FORWARDING <= '0';
                IS_STORE_OP <= '0';
        
                ELSIF (OP_CODE = "10110") THEN ---RET
                Control_Signals <= "0001111111000000001";
                OUT_EX_BRANCH <= "000";
                OUT_MEM_BRANCH <= "00";
                MUX_1 <= "11";
                MUX_5 <= "00";
                MUX_10 <= '0';
                IF_Flush <= '0';
                ID_Flush <= '0';
                EX_Flush <= '0';
                DISABLE_FORWARDING <= '0';
                IS_STORE_OP <= '0';
        

                ELSIF (OP_CODE = "10111") THEN ---INT0
                Control_Signals <= "0101101000100000010";
                MUX_1 <= "10";
                OUT_EX_BRANCH <= "000";
                OUT_MEM_BRANCH <= "10";
                MUX_5 <= "00";
                MUX_10 <= '0';
                IF_Flush <= '1';
                ID_Flush <= '1';
                EX_Flush <= '1';
                DISABLE_FORWARDING <= '0';
                IS_STORE_OP <= '0';
        
                ELSIF (OP_CODE = "11001") THEN ---INT1
                Control_Signals <= "0101101000100000010";
                MUX_1 <= "10";
                OUT_EX_BRANCH <= "000";
                OUT_MEM_BRANCH <= "11";
                MUX_5 <= "00";
                MUX_10 <= '0';
                IF_Flush <= '1';
                ID_Flush <= '1';
                EX_Flush <= '1';
                DISABLE_FORWARDING <= '0';
                IS_STORE_OP <= '0';
        
                ELSIF (OP_CODE = "11000") THEN ---RTI
                Control_Signals <= "0001111111000001100";
                MUX_1 <= "11";
                OUT_EX_BRANCH <= "000";
                OUT_MEM_BRANCH <= "00";
                MUX_5 <= "00";
                MUX_10 <= '0';
                IF_Flush <= '0';
                ID_Flush <= '0';
                EX_Flush <= '0';
                DISABLE_FORWARDING <= '0';
                IS_STORE_OP <= '0';
        
                END IF;
        END IF;

    END PROCESS;

END my_CU;