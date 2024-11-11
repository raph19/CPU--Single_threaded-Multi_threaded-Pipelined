Single-Threaded, Multi-Threaded and Pipelined CPU Implementation in VHDL


This project involves the design and implementation of a CPU in three phases. 

The first phase focuses on creating a single-threaded CPU using VHDL in the Xilinx ISE/Vivado development environment. 
In this phase, we implemented the ALU, Register File and the datapath, which includes the Instruction Set Architecture (ISA) and stages for Instruction Fetch, Instruction Decode, Execution, and Memory. 

The second phase extends the design to a multi-threaded CPU by modifying the datapath to support multiple concurrent threads. Additionally, we implemented the Control Unit to manage the execution of threads 
and coordinate the datapath operations. 

In the third phase, the multi-threaded CPU was converted into a pipelined CPU, enhancing instruction throughput by restructuring the datapath to allow overlapping execution of multiple instructions. 
The Control Unit was also updated to handle the pipelined design, ensuring proper synchronization and control. 

Summarizing, this project demonstrates the evolution of CPU architecture, from a basic single-threaded design to a multi-threaded and pipelined system, implemented using VHDL.
