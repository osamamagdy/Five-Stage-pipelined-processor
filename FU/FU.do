vsim work.forwardingunit(arch)
add wave -radix unsigned -position insertpoint  \
sim:/forwardingunit/current_op1_address \
sim:/forwardingunit/current_op2_address \
sim:/forwardingunit/last_WB \
sim:/forwardingunit/last_Rd \
sim:/forwardingunit/before_last_WB \
sim:/forwardingunit/before_last_Rd \
sim:/forwardingunit/op1_mux \
sim:/forwardingunit/op2_mux\
sim:/forwardingunit/op1_equal_last \
sim:/forwardingunit/op1_equal_before_last \
sim:/forwardingunit/op1_equal_both
force -freeze sim:/forwardingunit/current_op1_address 10#1 0
force -freeze sim:/forwardingunit/current_op2_address 10#7 0
force -freeze sim:/forwardingunit/last_WB 10#0 0
force -freeze sim:/forwardingunit/last_Rd 10#2 0
force -freeze sim:/forwardingunit/before_last_WB 10#0 0
force -freeze sim:/forwardingunit/before_last_Rd 10#5 0
run
force -freeze sim:/forwardingunit/last_WB 10#0 0
force -freeze sim:/forwardingunit/last_Rd 10#1 0
force -freeze sim:/forwardingunit/before_last_WB 10#0 0
force -freeze sim:/forwardingunit/before_last_Rd 10#5 0
run
force -freeze sim:/forwardingunit/last_WB 10#2 0
force -freeze sim:/forwardingunit/last_Rd 10#1 0
force -freeze sim:/forwardingunit/before_last_WB 10#0 0
force -freeze sim:/forwardingunit/before_last_Rd 10#5 0
run
force -freeze sim:/forwardingunit/last_WB 10#3 0
force -freeze sim:/forwardingunit/last_Rd 10#1 0
force -freeze sim:/forwardingunit/before_last_WB 10#0 0
force -freeze sim:/forwardingunit/before_last_Rd 10#5 0
run
force -freeze sim:/forwardingunit/last_WB 10#0 0
force -freeze sim:/forwardingunit/last_Rd 10#3 0
force -freeze sim:/forwardingunit/before_last_WB 10#0 0
force -freeze sim:/forwardingunit/before_last_Rd 10#1 0
run
force -freeze sim:/forwardingunit/before_last_WB 10#0 0
run
force -freeze sim:/forwardingunit/before_last_WB 10#2 0
run
force -freeze sim:/forwardingunit/before_last_WB 10#3 0
run
force -freeze sim:/forwardingunit/last_Rd 10#1 0
force -freeze sim:/forwardingunit/before_last_Rd 10#1 0
force -freeze sim:/forwardingunit/before_last_WB 10#2 0
force -freeze sim:/forwardingunit/last_WB 10#0 0
run
force -freeze sim:/forwardingunit/before_last_WB 10#2 0
force -freeze sim:/forwardingunit/last_WB 10#2 0
run
force -freeze sim:/forwardingunit/before_last_WB 10#3 0
force -freeze sim:/forwardingunit/last_WB 10#2 0
run
force -freeze sim:/forwardingunit/last_WB 10#3 0
run
force -freeze sim:/forwardingunit/before_last_WB 10#2 0
run