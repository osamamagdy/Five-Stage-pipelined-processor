LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
---------------------------------------------------------------------------
--------------------------------------------one-bit Fliflop----------------
ENTITY
    my_DFF IS
    PORT (
        d, clk, en : IN STD_LOGIC;
        q : OUT STD_LOGIC);
END my_DFF;
---------------------------------------------------------------------------
ARCHITECTURE
    a_my_DFF OF my_DFF IS
BEGIN
    PROCESS (clk, en)
    BEGIN
        IF (falling_edge(clk) AND en = '1') THEN
            q <= d;
        END IF;
    END PROCESS;
END a_my_DFF;
---------------------------------------------------------------------------
-------------------------------------------TRI-STATE Buffer---------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
ENTITY
    TRI IS
    PORT (
        input, control : IN STD_LOGIC;
        output : OUT STD_LOGIC);
END TRI;
---------------------------------------------------------------------------
ARCHITECTURE
    TRI_State OF TRI IS
BEGIN
    WITH control SELECT

        output <= input WHEN '1',
        'Z' WHEN OTHERS;
END TRI_State;
