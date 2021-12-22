vsim work.memory_stage 
# vsim work.memory_stage 
# Start time: 13:28:11 on Dec 21,2021
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.memory_stage(mem_arch)
# Loading work.mem_wb_buffer(arch_mem_wb_buffer)
# ** Warning: (vsim-3040) Command line generic/parameter "n" not found in design.
# 
add wave -position insertpoint  \
sim:/memory_stage/clk \
sim:/memory_stage/flush_mem_Wb \
sim:/memory_stage/reset \
sim:/memory_stage/mem_value \
sim:/memory_stage/mem_address \
sim:/memory_stage/next_pc \
sim:/memory_stage/wb \
sim:/memory_stage/mem_read \
sim:/memory_stage/mem_write \
sim:/memory_stage/sp_op \
sim:/memory_stage/sp_num \
sim:/memory_stage/r_src1 \
sim:/memory_stage/alu_res \
sim:/memory_stage/rti \
sim:/memory_stage/ret \
sim:/memory_stage/pc \
sim:/memory_stage/rd_address \
sim:/memory_stage/wb_en \
sim:/memory_stage/alu_mem_output \
sim:/memory_stage/alu_res_out \
sim:/memory_stage/mem \
sim:/memory_stage/rti_output \
sim:/memory_stage/ret_output \
sim:/memory_stage/rd_address_output \
sim:/memory_stage/q \
sim:/memory_stage/d
force -freeze sim:/memory_stage/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/memory_stage/flush_mem_Wb 0 0
force -freeze sim:/memory_stage/reset 0 0
force -freeze sim:/memory_stage/mem_value 00 0
force -freeze sim:/memory_stage/mem_address 0 0
force -freeze sim:/memory_stage/next_pc 00000000000000000000000000000000 0
force -freeze sim:/memory_stage/wb 00 0
force -freeze sim:/memory_stage/mem_read 0 0
force -freeze sim:/memory_stage/mem_write 0 0
force -freeze sim:/memory_stage/sp_op 00 0
force -freeze sim:/memory_stage/sp_num 0 0
force -freeze sim:/memory_stage/r_src1 0000000000000000 0
force -freeze sim:/memory_stage/alu_res 0000000000000000 0
force -freeze sim:/memory_stage/alu_res 0000000000000011 0
force -freeze sim:/memory_stage/r_src1 0000000000000111 0
force -freeze sim:/memory_stage/rti 1 0
force -freeze sim:/memory_stage/ret 1 0
force -freeze sim:/memory_stage/pc 00000000000000000000000000001011 0
force -freeze sim:/memory_stage/rd_address 010 0
run
run
run
force -freeze sim:/memory_stage/flush_mem_Wb 1 0
run
run
force -freeze sim:/memory_stage/wb 01 0
run
force -freeze sim:/memory_stage/flush_mem_Wb 0 0
run
run