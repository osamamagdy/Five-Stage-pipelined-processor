vsim -gui work.write_back_stage
# vsim -gui work.write_back_stage 
# Start time: 14:10:18 on Dec 21,2021
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.write_back_stage(arch_write_back_stage)
# Loading work.mux2x1(arch_mux2x1)
add wave -position insertpoint  \
sim:/write_back_stage/clk \
sim:/write_back_stage/out_port_en \
sim:/write_back_stage/input \
sim:/write_back_stage/rd_data \
sim:/write_back_stage/output_port
force -freeze sim:/write_back_stage/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/write_back_stage/out_port_en 0 0
force -freeze sim:/write_back_stage/input 000000000000000000000000000000000000000 0
run
force -freeze sim:/write_back_stage/input 000000000000001001000000000000011100011 0
run
force -freeze sim:/write_back_stage/input 010000000000001001000000000000011100011 0
run
force -freeze sim:/write_back_stage/out_port_en 1 0
run
run
