vsim -gui work.pc_register
# vsim -gui work.pc_register 
# Start time: 12:16:26 on Dec 22,2021
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.pc_register(structpc_register)
add wave -position insertpoint sim:/pc_register/*
force -freeze sim:/pc_register/CLK 1 0, 0 {50 ps} -r 100
force -freeze sim:/pc_register/RST 1 0
force -freeze sim:/pc_register/ENABLE 0 0
force -freeze sim:/pc_register/D X\"0A0A\" 0
run
run
force -freeze sim:/pc_register/RST 0 0
run
force -freeze sim:/pc_register/ENABLE 1 0
run
force -freeze sim:/pc_register/D X\"010A\" 0
run
run