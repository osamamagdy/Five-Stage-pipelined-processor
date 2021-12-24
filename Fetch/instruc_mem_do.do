vsim -gui work.fetch_decode
# vsim -gui work.fetch_decode 
# Start time: 13:28:41 on Dec 24,2021
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.fetch_decode(my_fd)
# Loading work.fetch(fetch_structure)
# Loading work.mux_41(mux_41_structure)
# Loading work.mux_21(mux_21_structure)
# Loading work.pc_register(structpc_register)
# Loading ieee.math_real(body)
# Loading work.instruction_mem(instruction_mem_arch)
# Loading work.checkimmediate(checkimmediate_struct)
# Loading work.ifid_buffer(structifid_buffer)
# Loading work.mydecode(my_decode)
# Loading work.reg_file(my_reg_file)
# Loading work.decoder(my_decoder)
# Loading work.my_ndff(b_my_ndff)
# Loading work.my_dff(a_my_dff)
# Loading work.ntri(my_ntri)
# Loading work.tri(tri_state)
# Loading work.cu(my_cu)
# Loading work.mux2(model_mux2)
# Loading work.mux4(model_mux4)
# Loading work.id_buffer(my_buffer)
# Loading work.my_ndff_2(b_my_ndff_2)
# Loading work.my_dff_2(a_my_dff_2)
mem load -skip 0 -filltype rand -filldata 12 -fillradix decimal /fetch_decode/mydecode/myReg_file/SIGNAL_FROM_FF
mem load -skip 0 -filltype value -filldata 12 -fillradix decimal /fetch_decode/mydecode/myReg_file/SIGNAL_FROM_FF
mem load -skip 0 -filltype inc -filldata 12 -fillradix decimal /fetch_decode/mydecode/myReg_file/SIGNAL_FROM_FF
mem load -skip 0 -filltype inc -filldata 12 -fillradix decimal /fetch_decode/mydecode/myReg_file/SIGNAL_FROM_FF
mem load -skip 0 -filltype inc -filldata 0000000000000000 -fillradix binary -startaddress 0 -endaddress 0 /fetch_decode/myfetch/INSTRUC_MEM/ram
mem load -skip 0 -filltype inc -filldata 0010011100000000 -fillradix binary -startaddress 1 -endaddress 1 /fetch_decode/myfetch/INSTRUC_MEM/ram
mem load -skip 0 -filltype inc -filldata 0010111100000000 -fillradix binary -startaddress 2 -endaddress 2 /fetch_decode/myfetch/INSTRUC_MEM/ram
mem load -skip 0 -filltype inc -filldata 0010111100000000 -fillradix binary -startaddress 3 -endaddress 3 /fetch_decode/myfetch/INSTRUC_MEM/ram
mem load -skip 0 -filltype inc -filldata 0011111100000000 -fillradix binary -startaddress 4 -endaddress 4 /fetch_decode/myfetch/INSTRUC_MEM/ram
mem load -skip 0 -filltype inc -filldata 0100011100000000 -fillradix binary -startaddress 5 -endaddress 5 /fetch_decode/myfetch/INSTRUC_MEM/ram
mem load -skip 0 -filltype inc -filldata 0100111100000000 -fillradix binary -startaddress 6 -endaddress 6 /fetch_decode/myfetch/INSTRUC_MEM/ram
mem load -skip 0 -filltype inc -filldata 0101011100000000 -fillradix binary -startaddress 7 -endaddress 7 /fetch_decode/myfetch/INSTRUC_MEM/ram
mem load -skip 0 -filltype inc -filldata 0101111100000000 -fillradix binary -startaddress 8 -endaddress 8 /fetch_decode/myfetch/INSTRUC_MEM/ram
mem load -skip 0 -filltype inc -filldata 0000000000000001 -fillradix binary -startaddress 9 -endaddress 9 /fetch_decode/myfetch/INSTRUC_MEM/ram

add wave -position insertpoint sim:/fetch_decode/*
add wave -position insertpoint sim:/fetch_decode/myfetch/*
force -freeze sim:/fetch_decode/myfetch/MUX1_SEL 00 0
# ** Warning: (vsim-8780) Forcing /fetch_decode/MUX1_SEL as root of /fetch_decode/myfetch/MUX1_SEL specified in the force.
force -freeze sim:/fetch_decode/myfetch/HLT 0 0
# ** Warning: (vsim-8780) Forcing /fetch_decode/HLT as root of /fetch_decode/myfetch/HLT specified in the force.
force -freeze sim:/fetch_decode/myfetch/pcIn x\"0000\" 0
force -freeze sim:/fetch_decode/reset 0 0
force -freeze sim:/fetch_decode/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/fetch_decode/JumpAddress x\"00ac\" 0
force -freeze sim:/fetch_decode/Exception x\"00af\" 0
force -freeze sim:/fetch_decode/Stack x\"00ad\" 0
force -freeze sim:/fetch_decode/MO_1 x\"00a0\" 0
add wave -position insertpoint sim:/fetch_decode/IF_ID_BUFFER/*
force -freeze sim:/fetch_decode/IF_ID_BUFFER/FLUSH 0 0
# ** Warning: (vsim-8780) Forcing /fetch_decode/FLUSH as root of /fetch_decode/IF_ID_BUFFER/FLUSH specified in the force.


