vsim -gui work.instruction_mem
# vsim -gui work.instruction_mem 
# Start time: 11:58:56 on Dec 22,2021
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading ieee.math_real(body)
# Loading work.instruction_mem(instruction_mem_arch)
add wave -position insertpoint sim:/instruction_mem/*
force -freeze sim:/instruction_mem/Clk 1 0, 0 {50 ps} -r 100
mem load -skip 0 -filltype inc -filldata 1 -fillradix decimal /instruction_mem/ram
force -freeze sim:/instruction_mem/Clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/instruction_mem/PC x\"0000\" 0
run
force -freeze sim:/instruction_mem/PC x\"0001\" 0
run
force -freeze sim:/instruction_mem/PC x\"0007\" 0
run
force -freeze sim:/instruction_mem/PC x\"0a0a\" 0
run
run
force -freeze sim:/instruction_mem/PC x\"00ff\" 0
run