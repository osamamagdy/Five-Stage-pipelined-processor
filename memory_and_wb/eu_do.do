vsim -gui work.exceptionunit
# vsim -gui work.exceptionunit 
# Start time: 11:41:22 on Jan 07,2022
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading ieee.math_real(body)
# Loading work.exceptionunit(euarch)
add wave -position insertpoint  \
sim:/exceptionunit/is_exception \
sim:/exceptionunit/mem_Address \
sim:/exceptionunit/memory_address \
sim:/exceptionunit/stack_address \
sim:/exceptionunit/stack_op
# ** Warning: (vsim-WLF-5000) WLF file currently in use: vsim.wlf
# 
#           File in use by: Donia  Hostname: DESKTOP-8GKI0P1  ProcessID: 13776
# 
#           Attempting to use alternate WLF file "./wlftdm9em7".
# ** Warning: (vsim-WLF-5001) Could not open WLF file: vsim.wlf
# 
#           Using alternate file: ./wlftdm9em7
# 
run
force -freeze sim:/exceptionunit/mem_Address 0 0
force -freeze sim:/exceptionunit/memory_address 16#ff00 0
force -freeze sim:/exceptionunit/stack_op 1 0
run
force -freeze sim:/exceptionunit/stack_address 32#000000ff 0
# ** Error: Bad base to make_vreg.
#    Time: 200 ps  Iteration: 0  Instance: /exceptionunit File: D:/DonyaAll/CMP2023-Y3/First Semester/Arc/arc projects/Project final/Five-Stage-pipelined-processor/memory_and_wb/exception_unit.vhd
# ** Error: Bad digit in make_vreg.
#    Time: 200 ps  Iteration: 0  Instance: /exceptionunit File: D:/DonyaAll/CMP2023-Y3/First Semester/Arc/arc projects/Project final/Five-Stage-pipelined-processor/memory_and_wb/exception_unit.vhd
run
force -freeze sim:/exceptionunit/stack_address 32#000000ff 0
# ** Error: Bad base to make_vreg.
#    Time: 300 ps  Iteration: 0  Instance: /exceptionunit File: D:/DonyaAll/CMP2023-Y3/First Semester/Arc/arc projects/Project final/Five-Stage-pipelined-processor/memory_and_wb/exception_unit.vhd
# ** Error: Bad digit in make_vreg.
#    Time: 300 ps  Iteration: 0  Instance: /exceptionunit File: D:/DonyaAll/CMP2023-Y3/First Semester/Arc/arc projects/Project final/Five-Stage-pipelined-processor/memory_and_wb/exception_unit.vhd
run
force -freeze sim:/exceptionunit/memory_address 1111111100000001 0
run
force -freeze sim:/exceptionunit/stack_address 00000000000000000000000000000000 0
run
force -freeze sim:/exceptionunit/memory_address 1111111100000000 0
run
force -freeze sim:/exceptionunit/mem_Address 1 0
run
