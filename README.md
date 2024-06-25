# RISCV_InOrder_Pipelined_CPU
RiscV In-order Pipe-lined Processor that utilizes a completely free and accessible toolchain for testing.

Started by using Project 3 of the [OpenCompArchCourse][1] as a base. This repo serves as an open-source version of the UMich EECS 470 Course on Computer Architecture.

Started by re-tooling the entire tool chain to use Verilator. Doing so allowed for simulation of the processor without the needed Synopsys VCS and Design Compiler, which were used in the course but I don't have access to. Making this change required modifications to several files, most notably testbench.sv, as well as an almost completely new makefile. I also found and included a call to an architecturally compatible elf2hex application in my makefile (I used the one available from sifive). 

The visual testbench files included in the original are currently removed and not implemented, though they may return later. The files require a specific gcc compiler flag (-lncurses) that would require a modification to my Verilator default flags or config file, or alternatively, a multi-stage chain to first compile the simulation based on the testbench into .o files with Verilator, then compile again using gcc with the virtual testbench c files and .o files. The multi-stage cahin will likely require the addition of new extern C lines and would likely be annoying, and I am not interested in modifying my Verilator configuration, as I find it to be finicky as is. 

This was originally done in another repo, and after doing that, I moved it over to this standalone repo. 

[1]: https://github.com/jieltan/OpenCompArchCourse
