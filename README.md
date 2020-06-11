# picoMIPS
An application specific processor using the picoMIPS architecture. The top level file was designed to use the Altera DE1-SoC FPGA for the required switches and 7-segment displays. The required task involves calculating the affine transformation for a pixel while using the minimal required instruction set and hardware. The total number of DSP was limited to 2.
The given parameters for the affine transformation is A=[0.5 -0.875; -0.875 0.75], B=[5; 12]. The inputs are handled using switch SW0-8 where SW0-7 are the input byte data and SW8 is the control switch. The calculated output is displayed on the 7 segment display.
The order of input is as follows:
1. SW8 goes high
1. Input x on SW0-7
1. SW8 goes low
1. SW8 goes high
1. Input y on SW0-7
1. SW8 goes low
1. Output shows x on 7-segment
1. SW8 goes high
1. Output shows y on 7-segment
1. SW8 goes low

The program will now execute NOP until the program counter overflows and executes the code again.
