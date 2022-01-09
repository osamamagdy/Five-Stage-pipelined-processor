
import os
from os import replace, truncate
import string

INSTRUCTION_LEN = 16
OPERAND_LEN = 5
REGISTER_LEN= 3
IMMEDIATE = ['IADD','LDM','LDD','STD']
OneOperandMem = ['LDM']
TwoOperandMem = []
NumberOfInstruction = 0
Exeption_Int = ['2','4','6','8']
isExeption_Int = False

Registers = {
    'R0': '000',
    'R1': '001',
    'R2': '010',
    'R3': '011',
    'R4': '100',
    'R5': '101',
    'R6': '110',
    'R7': '111',
}

NoOperand = {
    'NOP': '00000',
    'HLT': '00001',
    'SETC': '00010',
}
OneOperand = {
    'NOT': '00011',
    'INC': '00100',
    'OUT': '00101',
    'IN': '00110',
}

TwoOperand = {
    'MOV': '00111',
    'ADD': '01000',
    'SUB': '01001',
    'AND': '01010',
    'IADD': '01011',
}

MemoryOperations = {
    'PUSH': '01100',
    'POP': '01101',
    'LDM': '01110',
    'LDD': '01111',
    'STD': '10000',
}

Branch = {
    'JZ': '10001',
    'JN': '10010',
    'JC': '10011',
    'JMP': '10100',
    'CALL': '10101',
    'RET': '10110',
    'INT': '10111',
    'RTI': '11000',
}


#fileName = input("enter file name : ")
cwd = os.getcwd()
print(cwd)
#f = open(cwd+"\{}".format(fileName), "r")
f = open(cwd+"\\inputs\\memory.txt")
binCode= open(cwd+"\\outputs\\bin_binary.do","w")
bin_code= open(cwd+"\\bin.mem","w")

binCode.write('vsim -gui work.fetch_decode\n')
binCode.write('mem load -skip 0 -filltype value -filldata 000 -fillradix binary -startaddress 0 -endaddress 7 /processor/Fetch_Decode_Stages/mydecode/myReg_file/SIGNAL_FROM_FF\n')









comments = []
## address start from 0
address = 0

for line in f:

    is_number = False

    ## if line is empty continue
    if not(line.rstrip()):
        continue


    result = line.find('#')
    if result != -1:
        comments.append(line[result:])
        if result > 0:
            line = line[:result]
        else :
            continue
    
    

    line = line.upper()
    line = line.replace(',', ' ')
    line = line.strip()
    line = line.split()
    binaryInstruction = ''
    instuction = line[0]
    print(line)
    if instuction == '.ORG':
        hexVal = line[1]
        address = int(hexVal, 16)
        if hexVal in Exeption_Int:
            isExeption_Int = True
        else:
            isExeption_Int = False
        continue

   
    ## check if instruction is hex
    elif all(c in string.hexdigits for c in instuction) and instuction != 'ADD':
        is_number = True
        hexVal = line[0]
        binVal = str("{0:08b}".format(int(hexVal, 16)))
        if not isExeption_Int:
            binaryInstruction += '0'*(32-len(binVal))
            binaryInstruction += binVal 
        else:
            binaryInstruction += '0'*(16-len(binVal))
            binaryInstruction += binVal 
            binaryInstruction += '0'*(32-len(binaryInstruction)) 
        binaryInstruction = binaryInstruction[:16] + '\n' + binaryInstruction[16:] 
        
    else:
        #no operand
        if instuction in NoOperand.keys():
            binaryInstruction += NoOperand[instuction]
            binaryInstruction += '0'*(INSTRUCTION_LEN - OPERAND_LEN)

        #one operand
        elif instuction in OneOperand.keys():
            binaryInstruction += OneOperand[instuction]
            binaryInstruction += Registers[line[1]]*3
            binaryInstruction += '0' * (INSTRUCTION_LEN - OPERAND_LEN - 3*REGISTER_LEN)

        #two operand
        elif instuction in TwoOperand.keys():
            binaryInstruction += TwoOperand[instuction]
            
            
            #check if move replace dst with src
            if instuction == 'MOV':
                #Dst
                binaryInstruction += Registers[line[2]]
                #Src1
                binaryInstruction += Registers[line[1]]*2
                binaryInstruction += '0' * (INSTRUCTION_LEN - OPERAND_LEN - 3 * REGISTER_LEN)

            else: 
                #Dst
                binaryInstruction += Registers[line[1]]
                #Src1
                binaryInstruction += Registers[line[2]]  

                if instuction == 'IADD':
                # put the same reg src1 in src2 to avoid conflict
                    binaryInstruction += Registers[line[2]]
                    # if immediate immediate value 3rd word 
                    imm = line[3]
                    imm = "{0:08b}".format(int(imm, 16))
                    #rest zeros
                    binaryInstruction += '0' * (INSTRUCTION_LEN - OPERAND_LEN - 3 * REGISTER_LEN)
                    binaryInstruction += '\n'+ imm
                else: 
                    # if not immediate 
                    binaryInstruction += Registers[line[3]]
                    binaryInstruction += '0' * (INSTRUCTION_LEN - OPERAND_LEN - 3 * REGISTER_LEN)

                
        elif instuction in MemoryOperations.keys():
            
            binaryInstruction += MemoryOperations[instuction]

            if instuction == 'PUSH' or instuction == 'POP':
                #if push or pop takes only destination
                binaryInstruction += Registers[line[1]]*3
                binaryInstruction += '0' * (INSTRUCTION_LEN - OPERAND_LEN - 3 * REGISTER_LEN)
            else:
                # immediate value
                if instuction == 'LDM':
                    binaryInstruction += Registers[line[1]]*3
                    binaryInstruction += '0' * (INSTRUCTION_LEN - OPERAND_LEN - 3 * REGISTER_LEN)
                    imm = line[2] 
                    imm = "{0:08b}".format(int(imm, 16))
                    binaryInstruction += '\n'+ imm
                else:
                    src = line[2].replace('(', ' ').replace(')','').split()
                    #TODO: load and store
                    if instuction == 'LDD':
                        binaryInstruction += Registers[line[1]]
                        binaryInstruction += Registers[src[1]]*2
                    elif instuction == 'STD':
                        binaryInstruction += Registers[line[1]]*2
                        binaryInstruction += Registers[src[1]]
                    binaryInstruction += '0' * (INSTRUCTION_LEN - OPERAND_LEN - 3 * REGISTER_LEN)
                    imm = src[0]
                    imm = "{0:08b}".format(int(imm, 16))
                    binaryInstruction += '\n'+ imm
                

        elif instuction in Branch.keys():
            binaryInstruction += Branch[instuction]
            if instuction == 'RET' or instuction == 'RTI':
                binaryInstruction += '0' * (INSTRUCTION_LEN - OPERAND_LEN )
            elif instuction == 'INT' :
                index =  line[1]
                binaryInstruction += str("{0:08b}".format(int(index, 16)))
                binaryInstruction += '0' * (INSTRUCTION_LEN - len(binaryInstruction))
            else:
                binaryInstruction += Registers[line[1]]
                binaryInstruction += '0' * (INSTRUCTION_LEN - OPERAND_LEN - 3)  


    
    for ins in binaryInstruction.split():
        if not isExeption_Int:
            print('in address {} : {}'.format(hex(address),ins))
            binCode.write('mem load -skip 0 -filltype value -filldata {} -fillradix binary\
            -startaddress {} -endaddress {}  processor/Fetch_Decode_Stages/myfetch/INSTRUC_MEM/ram\n'.format(ins,address,address))
        else :
            print('in address {} : {}'.format(hex(address),ins))
            binCode.write('mem load -skip 0 -filltype value -filldata {} -fillradix binary\
            -startaddress {} -endaddress {}  /processor/EX_MEM_WB_Stages/MEM_Stage/DataMemAndStack/ram\n'.format(ins,address,address))
        address+=1


binCode.write(' force -freeze sim:/processor/clk 1 0, 0 {50 ps} -r 100\n\
force -freeze sim:/processor/Fetch_Decode_Stages/myfetch/MUX1_SEL 00 0\n\
force -freeze sim:/processor/Fetch_Decode_Stages/myfetch/HLT 0 0\n\
force -freeze sim:/processor/reset 1 0\n\
force -freeze sim:/processor/IN_PORT x\"01a0\" 0\n\
force -freeze sim:/processor/Fetch_Decode_Stages/MO_1 x\"00a0\" 0\n\
force -freeze sim:/processor/Fetch_Decode_Stages/IF_ID_BUFFER/FLUSH 0 0\n\
force -freeze sim:/processor/EX_MEM_WB_Stages/MEM_Stage/sp_register_call/D 16#FFFFF 0\n')

binCode.write('run \n\
noforce sim:/processor/Fetch_Decode_Stages/myfetch/MUX1_SEL\n\
noforce sim:/processor/Fetch_Decode_Stages/myfetch/HLT\n\
noforce sim:/processor/Fetch_Decode_Stages/IF_ID_BUFFER/FLUSH\n\
noforce sim:/processor/EX_MEM_WB_Stages/MEM_Stage/sp_register_call/D\n\
force -freeze sim:/processor/reset 0 0')

binCode.close




