vsim -gui work.processor

add wave -position insertpoint  \
sim:/processor/reset \
sim:/processor/clk \
sim:/processor/IN_PORT \
sim:/processor/output_port
add wave -position insertpoint sim:/processor/Fetch_Decode_Stages/myfetch/*
add wave -position insertpoint sim:/processor/Fetch_Decode_Stages/IF_ID_BUFFER/*
add wave -position insertpoint sim:/processor/Fetch_Decode_Stages/mydecode/*
add wave -position insertpoint sim:/processor/EX_MEM_WB_Stages/EX_Stage/*
add wave -position insertpoint sim:/processor/EX_MEM_WB_Stages/MEM_Stage/*
add wave -position insertpoint sim:/processor/EX_MEM_WB_Stages/WB_Stage/*
add wave -position insertpoint  \
sim:/processor/EX_MEM_WB_Stages/MEM_Stage/sp_register_call/D


mem load -skip 0 -filltype rand -filldata 12 -fillradix decimal /processor/Fetch_Decode_Stages/mydecode/myReg_file/SIGNAL_FROM_FF
mem load -skip 0 -filltype value -filldata 12 -fillradix decimal /processor/Fetch_Decode_Stages/mydecode/myReg_file/SIGNAL_FROM_FF
mem load -skip 0 -filltype inc -filldata 12 -fillradix decimal /processor/Fetch_Decode_Stages/mydecode/myReg_file/SIGNAL_FROM_FF
mem load -skip 0 -filltype inc -filldata 12 -fillradix decimal /processor/Fetch_Decode_Stages/mydecode/myReg_file/SIGNAL_FROM_FF



#Location of The first instruction
mem load -filltype value -filldata {0 } -fillradix binary /processor/Fetch_Decode_Stages/myfetch/INSTRUC_MEM/ram(0)
mem load -skip 0 -filltype inc -filldata 0000000000000111 -fillradix binary -startaddress 1 -endaddress 1 /processor/Fetch_Decode_Stages/myfetch/INSTRUC_MEM/ram



mem load -filltype value -filldata 0000000000001111 -fillradix symbolic /processor/EX_MEM_WB_Stages/MEM_Stage/DataMemAndStack/ram(4352)






#PUSH 101
mem load -skip 0 -filltype inc -filldata 0110010110100000 -fillradix binary -startaddress 7 -endaddress 7 /processor/Fetch_Decode_Stages/myfetch/INSTRUC_MEM/ram
#POP  001
mem load -skip 0 -filltype inc -filldata 0110100100100000 -fillradix binary -startaddress 8 -endaddress 8 /processor/Fetch_Decode_Stages/myfetch/INSTRUC_MEM/ram

#LDM  001
    #0001 0000 1110 1111 =?10EF
mem load -skip 0 -filltype inc -filldata 0111000100100000 -fillradix binary -startaddress 9 -endaddress 9 /processor/Fetch_Decode_Stages/myfetch/INSTRUC_MEM/ram
mem load -skip 0 -filltype inc -filldata 0001000011101111 -fillradix binary -startaddress 10 -endaddress 10 /processor/Fetch_Decode_Stages/myfetch/INSTRUC_MEM/ram

#LDD 101 111
    #0001 0000 1110 1101 => 10ED
mem load -skip 0 -filltype inc -filldata 0111110111100000 -fillradix binary -startaddress 7 -endaddress 7 /processor/Fetch_Decode_Stages/myfetch/INSTRUC_MEM/ram
mem load -skip 0 -filltype inc -filldata 0001000011101101 -fillradix binary -startaddress 8 -endaddress 8 /processor/Fetch_Decode_Stages/myfetch/INSTRUC_MEM/ram

#STD 110 101
    #0001 0000 1110 1101 => 10ED
mem load -skip 0 -filltype inc -filldata 1000011010100000 -fillradix binary -startaddress 9 -endaddress 9 /processor/Fetch_Decode_Stages/myfetch/INSTRUC_MEM/ram
mem load -skip 0 -filltype inc -filldata 0001000011101101 -fillradix binary -startaddress 10 -endaddress 10 /processor/Fetch_Decode_Stages/myfetch/INSTRUC_MEM/ram


force -freeze sim:/processor/clk 1 0, 0 {50 ps} -r 100


force -freeze sim:/processor/Fetch_Decode_Stages/myfetch/MUX1_SEL 00 0
force -freeze sim:/processor/Fetch_Decode_Stages/myfetch/HLT 0 0
force -freeze sim:/processor/reset 1 0
force -freeze sim:/processor/IN_PORT x\"01a0\" 0
force -freeze sim:/processor/Fetch_Decode_Stages/MO_1 x\"00a0\" 0
force -freeze sim:/processor/Fetch_Decode_Stages/IF_ID_BUFFER/FLUSH 0 0
force -freeze sim:/processor/EX_MEM_WB_Stages/MEM_Stage/sp_register_call/D 16#FFFFF 0


# ** Warning: (vsim-8780) Forcing /processor/Fetch_Decode_Stages/FLUSH as root of /processor/Fetch_Decode_Stages/IF_ID_BUFFER/FLUSH specified in the force.


#Until we make the exception unit
force -freeze sim:/processor/Fetch_Decode_Stages/IS_EXCEPTION 0 0



run 


noforce sim:/processor/Fetch_Decode_Stages/myfetch/MUX1_SEL
noforce sim:/processor/Fetch_Decode_Stages/myfetch/HLT
noforce sim:/processor/Fetch_Decode_Stages/IF_ID_BUFFER/FLUSH 
noforce sim:/processor/EX_MEM_WB_Stages/MEM_Stage/sp_register_call/D


force -freeze sim:/processor/reset 0 0





run















#NOP
mem load -skip 0 -filltype inc -filldata 0000000000000000 -fillradix binary -startaddress 7 -endaddress 7 /processor/Fetch_Decode_Stages/myfetch/INSTRUC_MEM/ram
#NOT
mem load -skip 0 -filltype inc -filldata 0001101001000000 -fillradix binary -startaddress 8 -endaddress 8 /processor/Fetch_Decode_Stages/myfetch/INSTRUC_MEM/ram
#INC
mem load -skip 0 -filltype inc -filldata 0010000000000000 -fillradix binary -startaddress 9 -endaddress 9 /processor/Fetch_Decode_Stages/myfetch/INSTRUC_MEM/ram
#OUT
mem load -skip 0 -filltype inc -filldata 0010111111100000 -fillradix binary -startaddress 10 -endaddress 10 /processor/Fetch_Decode_Stages/myfetch/INSTRUC_MEM/ram
#MOV
mem load -skip 0 -filltype inc -filldata 0011111100000000 -fillradix binary -startaddress 11 -endaddress 11 /processor/Fetch_Decode_Stages/myfetch/INSTRUC_MEM/ram
#ADD
mem load -skip 0 -filltype inc -filldata 0100011100000000 -fillradix binary -startaddress 12 -endaddress 12 /processor/Fetch_Decode_Stages/myfetch/INSTRUC_MEM/ram
#SUB
mem load -skip 0 -filltype inc -filldata 0100111100000000 -fillradix binary -startaddress 13 -endaddress 13 /processor/Fetch_Decode_Stages/myfetch/INSTRUC_MEM/ram
#AND
mem load -skip 0 -filltype inc -filldata 0101011100000000 -fillradix binary -startaddress 14 -endaddress 14 /processor/Fetch_Decode_Stages/myfetch/INSTRUC_MEM/ram
#IADD
mem load -skip 0 -filltype inc -filldata 0101111100000000 -fillradix binary -startaddress 15 -endaddress 15 /processor/Fetch_Decode_Stages/myfetch/INSTRUC_MEM/ram
mem load -skip 0 -filltype inc -filldata 0000000000000001 -fillradix binary -startaddress 16 -endaddress 16 /processor/Fetch_Decode_Stages/myfetch/INSTRUC_MEM/ram
#IN 111
mem load -skip 0 -filltype inc -filldata 0011011111100000 -fillradix binary -startaddress 17 -endaddress 17 /processor/Fetch_Decode_Stages/myfetch/INSTRUC_MEM/ram
#SETC
mem load -skip 0 -filltype inc -filldata 0001011100000000 -fillradix binary -startaddress 18 -endaddress 18 /processor/Fetch_Decode_Stages/myfetch/INSTRUC_MEM/ram
#HLT
mem load -skip 0 -filltype inc -filldata 0000111100000000 -fillradix binary -startaddress 19 -endaddress 19 /processor/Fetch_Decode_Stages/myfetch/INSTRUC_MEM/ram
