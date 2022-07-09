import random
import sys

seedValue = 10

x = []
w = []

def genInputs():
    global seedValue 
    seedValue += 1
    random.seed(seedValue)
    l = ""
    for i in range (10):
        for j in range (8):
            l += str(random.randint(0,1))
        x.append(l) 
        l = ""

    for i in range (10):
        for j in range (9):
            l += str(random.randint(0,1))
        w.append(l) 
        l = ""

sys.stdout = open("./Parallel_Multiplier_tb.vhd", "w")

for line in open("./Parallel_Multiplier.txt"):

    if "testing  <= false;" in line:
        for i in range(10): 
            genInputs()
            for j in range(10):
                print(f"\t\t\t\tx_p_{j}_tb <= \"{x[j]}\";") 
                print(f"\t\t\t\tw_p_{j}_tb <= \"{w[j]}\";") 
            print("\t\t\t\twait for 400 ns;") 
            x = []
            w = []

    print(line, end="")

sys.stdout = sys.__stdout__

print("Testbench generated")