# RISC-V-A-didactic-plateform

The development of this project is on progress...

Here are some of the major milestones of my Bachelor Project.

- [X] Create an unpiplined RV32IM processor using verilog
- [ ] Pipeline the existing unpipelined RV32IM Verilog processor in 5 stages
- [ ] Add support for custom instructions
- [ ] Create and document the entire project with the goal of making it easy to understand how a RISC-V, and in general, 
      how a processor works and how to create one using Verilog
      
The choice of not using constants for vector sizes and such is deliberate. I believe it's clearer to understand this way, 
even if it can be inconvenient when wanting to modify or adapt the processor, for example, to a 64-bit architecture.
