# Perceptron-VHDL

![alt text](https://github.com/FrankMartoccia/Perceptron-VHDL/blob/main/perceptron.jpg)

## General info
The perceptron is an algorithm for learning a binary classifier called a threshold
function: a function that maps its input x (a real-valued vector) to an output value
f(x) (a single binary value).

The perceptron is implemented as follows:

**Inputs**
* 10 'x' vectors (8 bits);
* 10 'w' vectors (9 bits);
* bias vector (9 bits).

All the inputs are considered in the range [-1,1] with the standard
2’s complement notation.

The **activation function** is a sigmoid.

**Output**
* vector of 16 bits with value in range [0,1].

## Technologies
The behaviour and structure of the perceptron is described with the following **language**:
* VHDL

The **tests** to verify the correctness of the system were made with:

* VHDL (for the writing of testbenches)
* ModelSim (for the simulation phase)
* Python (for the check of the results)

The **synthesis** and **analysis** phases were carried out using the following tool:
* Xilinx Vivado
