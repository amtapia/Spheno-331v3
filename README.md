# Spheno-331v3
SPheno module of 331 right-handed neutrinos model with three triplets of Higgs.
Model implemented taking as reference the paper:
PRD 80, 113009 (2009)
DOI: 10.1103/PhysRevD.80.113009

I) Installation:
   1) Please adapt the Makefile according to your f90/f95 compiler. The
      Makefile is written for the NAC f95 compiler but options have
      been included for other compilers as well.
   2) Run make Model=331v3
      This will compile the 331v3 SPheno program and put the executable in the bin
      directory.
      To run the program, change to the input directory and enter
      ../bin/SPheno331v3
      The output will be written to two files:
      - SPheno.spc.331v3 containg all information about masses, mixing matrices,
        decay widths, branching ratios and production cross sections.
      - Spheno.out containing warnings and error messages and it should
        be empty.
   3) The library libSPheno.a is stored in the subdirectory lib.
   
II) Running the program
    Copy the LesHouches.in.331v3_low file to root directory of SPheno (change the 
    numbers according to your needs), then enter
    ../bin/SPheno331v3 LesHouches.in.331v3_low

