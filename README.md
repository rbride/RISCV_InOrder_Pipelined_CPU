# RISCV_InOrder_Pipelined_CPU
RiscV In-order Pipe-lined Processor that utilizes a completely free and accessible toolchain for testing

Started with the base of Project 3 of the [OpenCompArchCourse][1] which serves as a open source version of the UMich 470 Course. Started by re-tooling the entire tool chain to use Verilator to allow for me to work on the project without the needed Synopsys VCS and design compiler tools used in the course that I don't have access to. This requred changes to several files, most noteably testbench.sv, furthere took a decent bit of time, because I played around with other tooling options. I also found and included a call to a compatible elf2hex application in my makefile, I used the one available from sifive. I also removed the virtual testbench, because verilator didn't like working with it since it needed specific compile flags, and I didn't feel like doing a multi stage chain to first compile the simulation based on the testbench, than compile again using gcc with the virtual testbench and .o files created by verilator. 

This was originally done in another repo, then after doing that I moved it over to this standalone repo. 

[1]: https://github.com/jieltan/OpenCompArchCourse
