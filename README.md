# Project Overview

Welcome to the Digital Design Team of SiliconJackets!

For your onboarding project, you will design a verilog module which computes the GCD (Greatest Common Divisor) between two positive integers. This project is meant to introduce you to basic logic design, writing RTL, and verifying correct behavior. Also, this should be an opportunity to familiarize yourself with the tools that we'll be using. Ask questions if you get stuck or if you need clarification on any step :)

## Requirements:

The GCD of two numbers a and b is defined as the largest integer such that (a % GCD=0) and (b % GCD=0). We have defined the input and output requirements of the gcd module. You can see this in the gcd.sv file. Assume both inputs are unsigned integers.
The deliverables you will be responsible for are the following:

0. Read and understand the reference materials provided in refmaterials/
    - if you are new to writing HDL check out this source for some basics: https://nandland.com/introduction-to-verilog-for-beginners-with-code-examples/
    - note that the source above is for verilog and not SystemVerilog which has slightly different syntax
    - for more information on SystemVerilog basics: https://www.chipverify.com/tutorials/systemverilog
1. Finite state machine diagram for GCD calculator module
2. Synthesizable GCD module implemented in SystemVerilog
    - Use best practices (always_comb and always_ff)
    - Don't use % (modulo operator)
4. Sufficient tests added in the testbench (include tests for potential edge cases)
5. Screenshots of results showing that the module works
6. Short live demo of the resulting waveforms (be able to describe what is going on clearly)

# Directory Overview

Here's what's going on in this onboarding project's directory.

> ## refmaterials/:
> 
> Contains reference materials for introducing the concept of state machines and proper SystemVerilog coding conventions
> 
> ## scripts/:
> 
> Contains any useful scripts
> 
> > ### scripts/gcd.py
> >
> > simple script for finding the gcd of two numbers.
> > Usage: "python3 gcd.py 6 8" or "./gcd 6 8"
> > Output: "gcd: 2"
> > If "./gcd 6 8" doesn't work, you need to change the file permissions to make it executable.
> > Running "chmod +x gcd.py" will fix that.
> 
> ## src/:
> 
> Contains the source files we'll be using.
> > 
> > ### src/Makefiles/:
> > 
> > Contains the makefiles
> > 
> > ### src/verilog/:
> > 
> > Contains your verilog files.
> > 
> > #### src/verilog/gcd.include:
> > 
> > Tells vcs which files to include.
> > 
> > #### src/verilog/gcd.sv:
> > 
> > Contains your gcd module.
> > 
> > #### src/verilog/tb_gcd.sv:
> > 
> > Contains your testbench.
> 
> ## sim/:
> 
> This is the directory where you'll run simulations from
> 
> ### sim/behav/:
> 
> This is the directory for behavioral simulation (before synthesis & place/route).
> You will cd into this directory to run your simulation. More instructions below.