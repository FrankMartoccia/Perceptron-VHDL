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

out_file = open("./Results_Parallel_Multiplier_tb.txt", "a")

def genResults(n):
    for i in range(10):
        value1 = 0
        value2 = 0
        for j in range(8):
            if j == 0:
                value1 += int(x[i][j]) * -1
            else:
                value1 += int(x[i][j]) * (2 ** (-j)) 

        for k in range(9):
            if k == 0:
                value2 += int(w[i][k]) * -1
            else:
                value2 += int(w[i][k]) * (2 ** (-k)) 
        out_file.write(f"{value1} * {value2} = {value1*value2}\n")
    out_file.write("\n\n")



sys.stdout = open("./Parallel_Multiplier_tb.vhd", "w")

for line in open("./Parallel_Multiplier.txt"):
    if "testing  <= false;" in line:
        for i in range(10): 
            genInputs()
            out_file.write(f"Test {i + 1}:\n")
            genResults(i + 1)
            for j in range(10):
                print(f"\t\t\t\tx_p_{j}_tb <= \"{x[j]}\";") 
                print(f"\t\t\t\tw_p_{j}_tb <= \"{w[j]}\";") 
            print("\t\t\t\twait for 400 ns;") 
            x = []
            w = []

    print(line, end="")


sys.stdout = sys.__stdout__

print("Testbench generated")