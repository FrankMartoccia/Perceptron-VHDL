import random
import sys

seedValue = 10

x = []
b = ""

def genInputs():
    global seedValue 
    seedValue += 1
    random.seed(seedValue)
    l = ""
    for i in range (10):
        for j in range (17):
            l += str(random.randint(0,1))
        x.append(l) 
        l = ""
    for _ in range(9):
        global b
        b += str(random.randint(0,1))

sys.stdout = open("./Adder_Tree_tb.vhd", "w")

for line in open("./Adder_Tree.txt"):
    if "testing  <= false;" in line:
        for i in range(10): 
            genInputs()
            for j in range(10):
                print(f"\t\t\t\tin{j+1}_tb  <= \"{x[j]}\";") 
            print(f"\t\t\t\tb_tb <= \"{b}\";")
            b = "" 
            print("\t\t\t\twait for 400 ns;") 
            x = []
            w = []

    print(line, end="")

sys.stdout = sys.__stdout__

print("Testbench generated")