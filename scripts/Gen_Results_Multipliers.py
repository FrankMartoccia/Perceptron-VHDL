def product(x):
	product = 0
	value1 = 0
	value2 = 0
	
	for i in range(len(x[0])):
		if i == 0:
			value1 += int(x[0][i]) * -1
		else:
			value1 += int(x[0][i]) * (2 ** (-i)) 
	print("\n"+ str(value1))
	for j in range(len(x[1])):
		if j == 0:
			value2 += int(x[1][j]) * -1
		else:
			value2 += int(x[1][j]) * (2 ** (-j)) 
	print
	print(value2)
	print(f"\nproduct: {value1*value2}\n")

x = []

def UPM_test():
	x = ["01111111", "011111111"]
	product(x)

	x = ["00111111", "011101111"]
	product(x)

	x = ["01011011", "001001101"]
	product(x)

def SPM_test():
	x = ["11111111", "011111111"]
	product(x)

	x = ["10111111", "111101111"]
	product(x)

	x = ["11011011", "001001101"]
	product(x)


print("0 - Unsigned Parallel Multiplier TB\n1 - Signed Parallel Multiplier TB\n")
choice = int(input("Insert choice: "))

x = ["00000101", "000000011"]
product(x)

x = ["00101101", "000000101"]
product(x)

x = ["00001100", "000000011"]
product(x)

if choice == 0:
	UPM_test()
else:
	SPM_test()