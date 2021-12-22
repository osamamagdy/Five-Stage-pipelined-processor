vsim -gui work.checkimmediate
# vsim -gui work.checkimmediate 
# Start time: 11:32:36 on Dec 22,2021
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.checkimmediate(checkimmediate_struct)
add wave -position insertpoint sim:/checkimmediate/*
force -freeze sim:/checkimmediate/PcIn X\"AAAA\" 0
force -freeze sim:/checkimmediate/IR_temp 01111011110111101111011110111100 0
run
run
force -freeze sim:/checkimmediate/PcIn X\"0AA0\" 0
force -freeze sim:/checkimmediate/IR_temp 01110011110111101111011110111100 0
run
force -freeze sim:/checkimmediate/IR_temp 01010011110111101111011110111100 0
run