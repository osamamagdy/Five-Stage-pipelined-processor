vsim work.aluwithflags(arch)
add wave -radix hexadecimal -position insertpoint  \
sim:/aluwithflags/op1 \
sim:/aluwithflags/op2 \
sim:/aluwithflags/ctrl \
sim:/aluwithflags/rti \
sim:/aluwithflags/clk \
sim:/aluwithflags/backup_en \
sim:/aluwithflags/reset \
sim:/aluwithflags/outputt \
sim:/aluwithflags/flags \
sim:/aluwithflags/current_flags \
sim:/aluwithflags/flags_backup \
sim:/aluwithflags/new_flags
force -freeze sim:/aluwithflags/clk 0 0, 1 {50 ps} -r 100
force -freeze sim:/aluwithflags/op1 16#FFFF 0
force -freeze sim:/aluwithflags/op2 16#FFFF 0
force -freeze sim:/aluwithflags/ctrl 0101 0
force -freeze sim:/aluwithflags/reset 1 0
force -freeze sim:/aluwithflags/rti 0 0
force -freeze sim:/aluwithflags/backup_en 0 0
run
force -freeze sim:/aluwithflags/reset 0 0
run
force -freeze sim:/aluwithflags/backup_en 1 0
run
force -freeze sim:/aluwithflags/backup_en 0 0
force -freeze sim:/aluwithflags/ctrl 0110 0
run
force -freeze sim:/aluwithflags/ctrl 0000 0
force -freeze sim:/aluwithflags/rti 1 0
run
run
run
