import sys
import math

n_in = int(input('Number of bits of the input: '))
while n_in < 1:
	print ("WARNING: Insert positive integer")
	n_in = int(input('Number of bits of the input: '))

n_out = int(input('Number of bits of the output: '))
while n_out < 1:
	print ("WARNING: Insert positive integer")
	int(input('Number of bits of the output: '))

lsb_out = 1 / (2 ** (n_out - 1) - 1)
lsb_in = 11 / (2 ** (n_in - 1) - 1)

lut_lines = 2 ** (n_in - 1)

f = list(range(lut_lines))

for i in range(lut_lines):
    y = (1) / (1 + math.exp(-(i * lsb_in)))
    f[i] = round(y / lsb_out)

fname = f"LUT_{lut_lines}"

out_file = open(f"{fname}.vhd", "w")

out_file.write("library IEEE;\n")
out_file.write("use IEEE.std_logic_1164.all;\n")
out_file.write("use IEEE.numeric_std.all;\n")
out_file.write("\n")
out_file.write(f"entity {fname} is\n")
out_file.write("	port (\n")
out_file.write("		address : in  std_logic_vector(" + str(n_in-1) + " downto 0);\n")
out_file.write("		dds_out : out std_logic_vector(" + str(n_out-1) + " downto 0) \n")
out_file.write("	);\n")
out_file.write(f"end {fname};\n") 
out_file.write("\n")
out_file.write(f"architecture beh of {fname} is\n")
out_file.write("	type LUT_t is array (natural range 0 to " +str(lut_lines - 1) + ") of integer;\n")
out_file.write("	constant LUT: LUT_t := (\n")

for i in range(lut_lines):
	if i < (lut_lines-1):
		out_file.write("		" + str(i) + " => " + str(int(f[i])) +",\n")
	else:
		out_file.write("		" + str(i) + " => " + str(int(f[i])) +"\n")

out_file.write(");\n")
out_file.write("\n")
out_file.write("begin\n")

out_file.write("	dds_out <= std_logic_vector(TO_SIGNED(LUT(TO_INTEGER(unsigned(address)))," + str(n_out) + "));\n")

out_file.write("end beh;\n")

out_file.close()



 