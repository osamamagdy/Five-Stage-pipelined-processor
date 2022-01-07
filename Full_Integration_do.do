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


mem load -skip 0 -filltype rand -filldata 12 -fillradix decimal /processor/Fetch_Decode_Stages/mydecode/myReg_file/SIGNAL_FROM_FF
mem load -skip 0 -filltype value -filldata 12 -fillradix decimal /processor/Fetch_Decode_Stages/mydecode/myReg_file/SIGNAL_FROM_FF
mem load -skip 0 -filltype inc -filldata 12 -fillradix decimal /processor/Fetch_Decode_Stages/mydecode/myReg_file/SIGNAL_FROM_FF
mem load -skip 0 -filltype inc -filldata 12 -fillradix decimal /processor/Fetch_Decode_Stages/mydecode/myReg_file/SIGNAL_FROM_FF
mem load -skip 0 -filltype inc -filldata 0000000000000000 -fillradix binary -startaddress 0 -endaddress 0 /processor/Fetch_Decode_Stages/myfetch/INSTRUC_MEM/ram
mem load -skip 0 -filltype inc -filldata 0001101001000000 -fillradix binary -startaddress 1 -endaddress 1 /processor/Fetch_Decode_Stages/myfetch/INSTRUC_MEM/ram
mem load -skip 0 -filltype inc -filldata 0010000000000000 -fillradix binary -startaddress 2 -endaddress 2 /processor/Fetch_Decode_Stages/myfetch/INSTRUC_MEM/ram
mem load -skip 0 -filltype inc -filldata 0010111111100000 -fillradix binary -startaddress 3 -endaddress 3 /processor/Fetch_Decode_Stages/myfetch/INSTRUC_MEM/ram
mem load -skip 0 -filltype inc -filldata 0011111100000000 -fillradix binary -startaddress 4 -endaddress 4 /processor/Fetch_Decode_Stages/myfetch/INSTRUC_MEM/ram
mem load -skip 0 -filltype inc -filldata 0100011100000000 -fillradix binary -startaddress 5 -endaddress 5 /processor/Fetch_Decode_Stages/myfetch/INSTRUC_MEM/ram
mem load -skip 0 -filltype inc -filldata 0100111100000000 -fillradix binary -startaddress 6 -endaddress 6 /processor/Fetch_Decode_Stages/myfetch/INSTRUC_MEM/ram
mem load -skip 0 -filltype inc -filldata 0101011100000000 -fillradix binary -startaddress 7 -endaddress 7 /processor/Fetch_Decode_Stages/myfetch/INSTRUC_MEM/ram
mem load -skip 0 -filltype inc -filldata 0101111100000000 -fillradix binary -startaddress 8 -endaddress 8 /processor/Fetch_Decode_Stages/myfetch/INSTRUC_MEM/ram
mem load -skip 0 -filltype inc -filldata 0000000000000001 -fillradix binary -startaddress 9 -endaddress 9 /processor/Fetch_Decode_Stages/myfetch/INSTRUC_MEM/ram


force -freeze sim:/processor/clk 1 0, 0 {50 ps} -r 100


force -freeze sim:/processor/Fetch_Decode_Stages/myfetch/MUX1_SEL 00 0
# ** Warning: (vsim-8780) Forcing /processor/Fetch_Decode_Stages/MUX1_SEL as root of /processor/Fetch_Decode_Stages/myfetch/MUX1_SEL specified in the force.
force -freeze sim:/processor/Fetch_Decode_Stages/myfetch/HLT 0 0
# ** Warning: (vsim-8780) Forcing /processor/Fetch_Decode_Stages/HLT as root of /processor/Fetch_Decode_Stages/myfetch/HLT specified in the force.
force -freeze sim:/processor/Fetch_Decode_Stages/myfetch/pcIn x\"0000\" 0
force -freeze sim:/processor/Fetch_Decode_Stages/reset 0 0
force -freeze sim:/processor/Fetch_Decode_Stages/JumpAddress x\"00ac\" 0
force -freeze sim:/processor/Fetch_Decode_Stages/Exception x\"00af\" 0
force -freeze sim:/processor/Fetch_Decode_Stages/Stack x\"00ad\" 0
force -freeze sim:/processor/Fetch_Decode_Stages/MO_1 x\"00a0\" 0
force -freeze sim:/processor/Fetch_Decode_Stages/IF_ID_BUFFER/FLUSH 0 0

force -freeze sim:/processor/Fetch_Decode_Stages/mydecode/IS_HAZARD 0 0

# ** Warning: (vsim-8780) Forcing /processor/Fetch_Decode_Stages/FLUSH as root of /processor/Fetch_Decode_Stages/IF_ID_BUFFER/FLUSH specified in the force.


#Until we make the exception unit
force -freeze sim:/processor/Fetch_Decode_Stages/IS_EXCEPTION 0 0



run 


noforce sim:/processor/Fetch_Decode_Stages/myfetch/MUX1_SEL
noforce sim:/processor/Fetch_Decode_Stages/myfetch/HLT
noforce sim:/processor/Fetch_Decode_Stages/myfetch/pcIn
noforce sim:/processor/Fetch_Decode_Stages/JumpAddress 
noforce sim:/processor/Fetch_Decode_Stages/Exception
noforce sim:/processor/Fetch_Decode_Stages/Stack 
noforce sim:/processor/Fetch_Decode_Stages/MO_1 
noforce sim:/processor/Fetch_Decode_Stages/IF_ID_BUFFER/FLUSH 
