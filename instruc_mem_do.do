vsim -gui work.fetch_decode

mem load -skip 0 -filltype rand -filldata 12 -fillradix decimal /fetch_decode/mydecode/myReg_file/SIGNAL_FROM_FF
mem load -skip 0 -filltype value -filldata 12 -fillradix decimal /fetch_decode/mydecode/myReg_file/SIGNAL_FROM_FF
mem load -skip 0 -filltype inc -filldata 12 -fillradix decimal /fetch_decode/mydecode/myReg_file/SIGNAL_FROM_FF
mem load -skip 0 -filltype inc -filldata 12 -fillradix decimal /fetch_decode/mydecode/myReg_file/SIGNAL_FROM_FF
mem load -skip 0 -filltype inc -filldata 0000000000000000 -fillradix binary -startaddress 0 -endaddress 0 /fetch_decode/myfetch/INSTRUC_MEM/ram
mem load -skip 0 -filltype inc -filldata 0001101001000000 -fillradix binary -startaddress 1 -endaddress 1 /fetch_decode/myfetch/INSTRUC_MEM/ram
mem load -skip 0 -filltype inc -filldata 0010000000000000 -fillradix binary -startaddress 2 -endaddress 2 /fetch_decode/myfetch/INSTRUC_MEM/ram
mem load -skip 0 -filltype inc -filldata 0010111100000000 -fillradix binary -startaddress 3 -endaddress 3 /fetch_decode/myfetch/INSTRUC_MEM/ram
mem load -skip 0 -filltype inc -filldata 0011111100000000 -fillradix binary -startaddress 4 -endaddress 4 /fetch_decode/myfetch/INSTRUC_MEM/ram
mem load -skip 0 -filltype inc -filldata 0100011100000000 -fillradix binary -startaddress 5 -endaddress 5 /fetch_decode/myfetch/INSTRUC_MEM/ram
mem load -skip 0 -filltype inc -filldata 0100111100000000 -fillradix binary -startaddress 6 -endaddress 6 /fetch_decode/myfetch/INSTRUC_MEM/ram
mem load -skip 0 -filltype inc -filldata 0101011100000000 -fillradix binary -startaddress 7 -endaddress 7 /fetch_decode/myfetch/INSTRUC_MEM/ram
mem load -skip 0 -filltype inc -filldata 0101111100000000 -fillradix binary -startaddress 8 -endaddress 8 /fetch_decode/myfetch/INSTRUC_MEM/ram
mem load -skip 0 -filltype inc -filldata 0000000000000001 -fillradix binary -startaddress 9 -endaddress 9 /fetch_decode/myfetch/INSTRUC_MEM/ram

add wave -position insertpoint sim:/fetch_decode/*
add wave -position insertpoint sim:/fetch_decode/myfetch/*
add wave -position insertpoint sim:/fetch_decode/IF_ID_BUFFER/*
add wave -position insertpoint sim:/fetch_decode/mydecode/*

add wave -position insertpoint sim:/fetch_decode/IF_ID_BUFFER/*

force -freeze sim:/fetch_decode/clk 1 0, 0 {50 ps} -r 100


force -freeze sim:/fetch_decode/myfetch/MUX1_SEL 00 0
# ** Warning: (vsim-8780) Forcing /fetch_decode/MUX1_SEL as root of /fetch_decode/myfetch/MUX1_SEL specified in the force.
force -freeze sim:/fetch_decode/myfetch/HLT 0 0
# ** Warning: (vsim-8780) Forcing /fetch_decode/HLT as root of /fetch_decode/myfetch/HLT specified in the force.
force -freeze sim:/fetch_decode/myfetch/pcIn x\"0000\" 0
force -freeze sim:/fetch_decode/reset 0 0
force -freeze sim:/fetch_decode/JumpAddress x\"00ac\" 0
force -freeze sim:/fetch_decode/Exception x\"00af\" 0
force -freeze sim:/fetch_decode/Stack x\"00ad\" 0
force -freeze sim:/fetch_decode/MO_1 x\"00a0\" 0
force -freeze sim:/fetch_decode/IF_ID_BUFFER/FLUSH 0 0

force -freeze sim:/fetch_decode/mydecode/IS_HAZARD 0 0

# ** Warning: (vsim-8780) Forcing /fetch_decode/FLUSH as root of /fetch_decode/IF_ID_BUFFER/FLUSH specified in the force.


#Until we make the exception unit
force -freeze sim:/fetch_decode/IS_EXCEPTION 0 0



run 


noforce sim:/fetch_decode/myfetch/MUX1_SEL
noforce sim:/fetch_decode/myfetch/HLT
noforce sim:/fetch_decode/myfetch/pcIn
noforce sim:/fetch_decode/JumpAddress 
noforce sim:/fetch_decode/Exception
noforce sim:/fetch_decode/Stack 
noforce sim:/fetch_decode/MO_1 
noforce sim:/fetch_decode/IF_ID_BUFFER/FLUSH 
