vsim work.executionstage(arch)
add wave -radix hexadecimal -position insertpoint  \
sim:/executionstage/clk \
sim:/executionstage/reset \
sim:/executionstage/memValuein \
sim:/executionstage/memValueout \
sim:/executionstage/memAddressin \
sim:/executionstage/memAddressout \
sim:/executionstage/PCin \
sim:/executionstage/PCout \
sim:/executionstage/nextPCin \
sim:/executionstage/nextPCout \
sim:/executionstage/SPOPin \
sim:/executionstage/SPOPout \
sim:/executionstage/SPNUMin \
sim:/executionstage/SPNUMout \
sim:/executionstage/WBin \
sim:/executionstage/WBout \
sim:/executionstage/MEM \
sim:/executionstage/MemWr \
sim:/executionstage/MemRe \
sim:/executionstage/RTIin \
sim:/executionstage/RTIout \
sim:/executionstage/RETin \
sim:/executionstage/RETout \
sim:/executionstage/rdAddressin \
sim:/executionstage/rdAddressout \
sim:/executionstage/rsAddress \
sim:/executionstage/rtAddress \
sim:/executionstage/EX \
sim:/executionstage/RSdata \
sim:/executionstage/Rsrc1 \
sim:/executionstage/secondOperand \
sim:/executionstage/BackupFlag \
sim:/executionstage/EXflush \
sim:/executionstage/ALUres \
sim:/executionstage/flags \
sim:/executionstage/jumpAddress 
force -freeze sim:/executionstage/clk 0 0, 1 {50 ps} -r 100
force -freeze sim:/executionstage/reset 1 0
run
force -freeze sim:/executionstage/reset 0 0
force -freeze sim:/executionstage/memValuein 01 0
force -freeze sim:/executionstage/memAddressin 0 0
force -freeze sim:/executionstage/PCin 16#FF0A 0
force -freeze sim:/executionstage/nextPCin 16#FF0B 0
force -freeze sim:/executionstage/SPOPin 10 0
force -freeze sim:/executionstage/SPNUMin 0 0
force -freeze sim:/executionstage/WBin 10 0
force -freeze sim:/executionstage/MEM 11 0
force -freeze sim:/executionstage/EX 0000 0
force -freeze sim:/executionstage/RSdata 16#010C 0
force -freeze sim:/executionstage/secondOperand 16#F0BD 0
force -freeze sim:/executionstage/RTIin 0 0
force -freeze sim:/executionstage/BackupFlag 00 0
force -freeze sim:/executionstage/rdAddressin 111 0
force -freeze sim:/executionstage/rsAddress 010 0
force -freeze sim:/executionstage/rtAddress 001 0
force -freeze sim:/executionstage/RETin 0 0
force -freeze sim:/executionstage/EXflush 0 0
run