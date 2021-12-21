vsim -gui work.reg_file
# vsim -gui work.reg_file 
# Start time: 10:17:11 on Dec 21,2021
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.reg_file(my_reg_file)
# Loading work.decoder(my_decoder)
# Loading work.my_ndff(b_my_ndff)
# Loading work.my_dff(a_my_dff)
# Loading work.ntri(my_ntri)
# Loading work.tri(tri_state)
add wave -position insertpoint  \
sim:/reg_file/n \
sim:/reg_file/Clk \
sim:/reg_file/address_read_1 \
sim:/reg_file/address_read_2 \
sim:/reg_file/address_read_3 \
sim:/reg_file/address_write \
sim:/reg_file/en_write \
sim:/reg_file/write_data_bus \
sim:/reg_file/read_1_data_bus \
sim:/reg_file/read_2_data_bus \
sim:/reg_file/read_3_data_bus \
sim:/reg_file/address_read_1_bus \
sim:/reg_file/address_read_2_bus \
sim:/reg_file/address_read_3_bus \
sim:/reg_file/address_write_bus \
sim:/reg_file/SIGNAL_FROM_FF
force -freeze sim:/reg_file/Clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/reg_file/address_read_1 010 0
force -freeze sim:/reg_file/address_read_2 101 0
force -freeze sim:/reg_file/address_read_3 111 0
force -freeze sim:/reg_file/address_write 010 0
force -freeze sim:/reg_file/en_write 1 0
force -freeze sim:/reg_file/write_data_bus 16#4f4f 0
run
force -freeze sim:/reg_file/address_write 111 0
force -freeze sim:/reg_file/write_data_bus 16#5555 0
run
force -freeze sim:/reg_file/en_write 0 0
force -freeze sim:/reg_file/write_data_bus 16#FFFF 0
run
run
force -freeze sim:/reg_file/address_write 101 0
force -freeze sim:/reg_file/en_write 1 0
run
run
force -freeze sim:/reg_file/address_read_1 011 0
force -freeze sim:/reg_file/address_read_2 011 0
force -freeze sim:/reg_file/address_read_3 011 0
force -freeze sim:/reg_file/address_write 011 0
force -freeze sim:/reg_file/en_write 0 0
force -freeze sim:/reg_file/en_write 1 0
force -freeze sim:/reg_file/write_data_bus 1111100011111111 0
run
