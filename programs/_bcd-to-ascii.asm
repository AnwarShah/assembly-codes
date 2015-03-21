; Convert a BCD byte to two ASCII characters
    
DATA    SEGMENT
    lowB  db    ?
    highB   db  ?
DATA    ENDS

CODE    SEGMENT
    ASSUME CS:CODE, DS:DATA
    
START:      MOV AX, DATA
            MOV DS, AX  ; initialize data segment
    
            MOV AL, 57H ;
            MOV lowB,   AL ; preserve low byte
            MOV highB,  AL  ; preserve high byte
             
            AND AL, 0FH;  mask high 4 bits
            OR  AL, 30H;  set high bits
            MOV lowB, AL;   store in lowB
            
            MOV AL, highB;
            ROR AL, 4;  rotate right 4 bits
            AND AL, 0FH  ; mash high 4 bits
            OR  AL, 30H ; set high bits
            MOV highB,  AL; store high byte
            
            ; Display the ascii bytes
            MOV AH, 2
            MOV DL, highB;
            INT 21H
            MOV DL, lowB;
            INT 21H
            
CODE    ENDS
    END START
    
    