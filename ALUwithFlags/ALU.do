vsim -gui work.alu(arch_alu)
add wave -radix hexadecimal -position insertpoint  \
sim:/alu/op1 \
sim:/alu/op2 \
sim:/alu/ctrl \
sim:/alu/current_flags \
sim:/alu/outputt \
sim:/alu/new_flags 
force -freeze sim:/alu/current_flags 000 0
force -freeze sim:/alu/op1 16#FFFE 0
force -freeze sim:/alu/op2 16#FFFF 0
#ADD
force -freeze sim:/alu/ctrl 0000 0 
run
force -freeze sim:/alu/ctrl 0001 0 
run
force -freeze sim:/alu/ctrl 0010 0 
run
force -freeze sim:/alu/ctrl 0011 0 
run
force -freeze sim:/alu/ctrl 0100 0 
run
force -freeze sim:/alu/ctrl 0101 0 
run
force -freeze sim:/alu/ctrl 0110 0 
run
force -freeze sim:/alu/ctrl 0111 0 
run
force -freeze sim:/alu/current_flags 111 0
force -freeze sim:/alu/ctrl 1000 0 
run
force -freeze sim:/alu/current_flags 111 0
force -freeze sim:/alu/ctrl 1001 0 
run
force -freeze sim:/alu/current_flags 111 0
force -freeze sim:/alu/ctrl 1010 0 
run
# force -freeze sim:/alu/ctrl 1011 0 
# run
# force -freeze sim:/alu/ctrl 1100 0 
# run
# force -freeze sim:/alu/ctrl 1101 0 
# run
# force -freeze sim:/alu/ctrl 1110 0 
# run
# force -freeze sim:/alu/ctrl 1111 0 
# run