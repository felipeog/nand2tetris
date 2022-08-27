// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
//
// This program only needs to handle arguments that satisfy
// R0 >= 0, R1 >= 0, and R0*R1 < 32768.

    // R2 = 0
    @2
    M=0

    // if (R0 == 0) goto END
    @0
    D=M
    @END
    D;JEQ

    // if (R1 == 0) goto END
    @1
    D=M
    @END
    D;JEQ

    // if (R0 < R1) goto LT
    // else goto GT
    @0
    D=M
    @1
    D=D-M
    @LT
    D;JLT
    @GT
    0;JMP

(LT)
    // i = R0
    @0
    D=M
    @i
    M=D

    // increment = R1
    @1
    D=M
    @increment
    M=D

(GT)
    // i = R1
    @1
    D=M
    @i
    M=D

    // increment = R0
    @0
    D=M
    @increment
    M=D

(LOOP)
    // if (i == 0) goto END
    @i
    D=M
    @END
    D;JEQ

    // R2 = R2 + increment
    @increment
    D=M
    @2
    M=M+D

    // i = i - 1
    @i
    M=M-1

    // goto LOOP
    @LOOP
    0;JMP

(END)
    @END
    0;JMP
