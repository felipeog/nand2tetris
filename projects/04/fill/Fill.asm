// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed.
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

(LOOP)
    // i = 16384
    // 16384 is the first screen register
    @SCREEN
    D=A
    @i
    M=D

    // if (KBD == 0) goto EMPTY
    // else goto FILL
    @KBD
    D=M
    @EMPTY
    D;JEQ
    @FILL
    0;JMP

(FILL)
    // value = -1
    @value
    M=-1

    // goto PAINT
    @PAINT
    0;JMP

(EMPTY)
    // value = 0
    @value
    M=0
    
    // goto PAINT
    @PAINT
    0;JMP

(PAINT)
    // R[i] = value
    @value
    D=M
    @i
    A=M
    M=D

    // i = i + 1
    @i
    M=M+1

    // 24576 - i
    // 24576 is the first keyboard register
    // 24575 is the last screen register
    @i
    D=M
    @KBD
    D=A-D

    // if (24576 - i == 0) goto LOOP
    // else goto PAINT
    @LOOP
    D;JEQ
    @PAINT
    0;JMP
