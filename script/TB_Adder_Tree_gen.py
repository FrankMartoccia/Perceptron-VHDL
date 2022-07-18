import random
import sys

seedValue = 10

x = []
b = ""

out_file = open("./Results_Adder_Tree_tb.txt", "a")

def genInputs(k):
    global seedValue 
    seedValue += 1
    random.seed(seedValue)
    summation = 0
    bsum = 0

    for i in range (10):
        fixedvalue = 0
        binary = ""
        for j in range (17):
            value = random.randint(0,1)
            binary += (str(value))
            if j == 1:
                fixedvalue += value * 1
            elif j == 0:
                fixedvalue += value * (-2)
            else: 
                fixedvalue += value * 2**(-(j-1))
        
        out_file.write(binary)
        out_file.write(f"\tvalue {i+1}: {fixedvalue} \n")
        summation += fixedvalue

        x.append(binary) 
        binary = ""
    global b
    b = ""

    for index in range(9):
        bvalue = random.randint(0,1)
        b += str(bvalue)
        if index == 0:
            bsum += bvalue * (-1)
        else: 
            bsum += bvalue * (2 ** (- index))
    out_file.write(f"{b}")        
    out_file.write("\t\tbias: " + str(bsum))
    summation += bsum
    out_file.write(f"\n\nsum {k}: {summation}\n\n\n")
    
sys.stdout = open("./Adder_Tree_tb.vhd", "w")

for line in open("./Adder_Tree.txt"):
    if "testing  <= false;" in line:
        for i in range(10): 
            genInputs(i + 1)
            for j in range(10):
                print(f"\t\t\t\tin{j+1}_tb  <= \"{x[j]}\";") 
            print(f"\t\t\t\tb_tb <= \"{b}\";")
            b = "" 
            print("\t\t\t\twait for 400 ns;") 
            x = []
            w = []

    print(line, end="")

out_file.close()
sys.stdout = sys.__stdout__

print("Testbench generated")