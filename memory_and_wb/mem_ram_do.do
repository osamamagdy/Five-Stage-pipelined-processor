vsim -gui work.memstageram
# vsim -gui work.memstageram 
# Start time: 23:19:25 on Jan 06,2022
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading ieee.math_real(body)
# Loading work.memstageram(memstageramarch)
add wave -position insertpoint  \
sim:/memstageram/clk \
sim:/memstageram/we \
sim:/memstageram/re \
sim:/memstageram/sp_num \
sim:/memstageram/mem_Address \
sim:/memstageram/address \
sim:/memstageram/datain \
sim:/memstageram/dataout
# ** Warning: (vsim-WLF-5000) WLF file currently in use: vsim.wlf
# 
#           File in use by: Donia  Hostname: DESKTOP-8GKI0P1  ProcessID: 13776
# 
#           Attempting to use alternate WLF file "./wlftat1tak".
# ** Warning: (vsim-WLF-5001) Could not open WLF file: vsim.wlf
# 
#           Using alternate file: ./wlftat1tak
# 
force -freeze sim:/memstageram/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/memstageram/we 0 0
force -freeze sim:/memstageram/re 0 0
force -freeze sim:/memstageram/sp_num 0 0
force -freeze sim:/memstageram/mem_Address 0 0
force -freeze sim:/memstageram/address 00000000000000000000000000000000 0
force -freeze sim:/memstageram/datain 00000000000000000000000000000000 0
run
force -freeze sim:/memstageram/we 1 0
force -freeze sim:/memstageram/address 00000000000000000000000000000001 0
force -freeze sim:/memstageram/datain 00000000000001110000000000000101 0
run
force -freeze sim:/memstageram/re 1 0
force -freeze sim:/memstageram/we 0 0
run
force -freeze sim:/memstageram/we 1 0
force -freeze sim:/memstageram/re 0 0
force -freeze sim:/memstageram/mem_Address 1 0
force -freeze sim:/memstageram/address 00000000000000000000000000001010 0
force -freeze sim:/memstageram/datain 00000000000001110000000000001100 0
run
force -freeze sim:/memstageram/sp_num 1 0
force -freeze sim:/memstageram/datain 00000000001001000000000000001100 0
run
force -freeze sim:/memstageram/we 0 0
force -freeze sim:/memstageram/re 1 0
force -freeze sim:/memstageram/address 00000000000000000000000000001001 0
run
force -freeze sim:/memstageram/sp_num 0 0
run