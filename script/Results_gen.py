import math
import sys

LSB_out = 1 / (2 ** 15 - 1)
LSB_in = 11 / (2 ** 12 - 1)

out_file = open(f"Results.txt", "w")

def genResults(x, w, b, n):
    out_file.write(f"TEST {n}:\n\n")
    out_file.write("x:" + str(x))
    out_file.write("\tw:" + str(w))
    out_file.write("\tb:" + str(b))

    sum_result = addition(x, w, b)
    out_file.write(f"\n\nSum:\t\t {sum_result}")

    sum_quantized = round(sum_result/LSB_in)
    out_file.write(f"\n\nQuantized sum:\t {sum_quantized}")

    s_out = s_output(sum_result)
    out_file.write(f"\n\nSigmoid output:\t {s_out}")

    s_out_quantized = round(s_out/LSB_out)
    out_file.write(f"\n\nQuantized sigmoid output:\t {s_out_quantized}\n\n")

    out_file.write("-" * 150 + "\n\n")

def addition(x, w, b):
    sum_result = 0
    for i in range(0, 10):
        sum_result += x[i] * w[i]
    sum_result += b
    return sum_result

def s_output(s):
    s_out = 1 / (1 + math.exp(-s))
    return s_out

# Test 1
x = [1,1,1,1,1,1,1,1,1,1]
w1 = [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]
b1 = -1
genResults(x, w1, b1, 1)

# Test 2
w2 = [-0.8,-0.8,-0.8,-0.8,-0.8,-0.8,-0.8,-0.8,-0.8,-0.8]
b2 = -1
genResults(x, w2, b2, 2)

# Test 3
w3 = [-0.5,-0.5,-0.5,-0.5,-0.5,-0.5,-0.5,-0.5,-0.5,-0.5]
b3 = -0.5
genResults(x, w3, b3, 3)

# Test 4
w4 = [-0.25,-0.25,-0.25,-0.25,-0.25,-0.25,-0.25,-0.25,-0.25,-0.25]
b4 = -0.25
genResults(x, w4, b4, 4)

# Test 5
w5 = [0,0,0,0,0,0,0,0,0,0]
b5 = 0
genResults(x, w5, b5, 5)

# Test 6 
w6 = [0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25]
b6 = 0.25
genResults(x, w6, b6, 6)

# Test 7
w7 = [0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5]
b7 = 0.5
genResults(x, w7, b7, 7)

# Test 8
w8 = [0.8,0.8,0.8,0.8,0.8,0.8,0.8,0.8,0.8,0.8]
b8 = 1
genResults(x, w8, b8, 8)

# Test 9
w9 = [1,1,1,1,1,1,1,1,1,1]
b9 = 1
genResults(x, w9, b9, 9)

out_file.close()






