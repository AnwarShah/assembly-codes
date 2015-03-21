; If input is 'this is a test' this program outputs 'siht si a tset'

.MODEL  SMALL
.STACK  100H
.DATA
    temp dw     ?   ; temp variable for garbage stack output
    stk   db  100 dup(?)  ; our own stack 
.CODE   

MAIN    PROC
    ;initialize data segment
    mov ax, @data
    mov DS, AX
    
    XOR DX,DX   ; clear DX
    XOR CX,CX   ; counter for chars
    MOV DI, 0   ; stack indexer
    
DO:    
    ; Get char 
    MOV ah,1
    INT 21h
    
    ; if carriage return stop input
    cmp al, 0dh
    JE PRINT_LINE
    
    mov stk[DI],AL   ; store in stk[di]
    INC DI
    INT 21H     ; get another
    
REPEAT:    
    
    ; if carriage return stop input
    cmp al, 0dh
    JE PRINT_LINE
    
    ; if space , store it as it is
    cmp al, 20h
    JNE NOT_SPACE   ; if not space, go as usual 
 
    MOV STK[DI], AL
    INC DI
    INT 21H
    JMP REPEAT
    
NOT_SPACE:
    ; check if the last one was space
    cmp stk[DI-1], 20h
    JNE NO
    MOV STK[DI], AL
    INC DI
    JMP REPEAT    
NO:
    ; shuffle between old and new value
    MOV  DL, stk[DI-1]   ;
    MOV stk[DI-1], AL 
    MOV STK[DI], DL
    
    INC DI  ; DI points to next empty location
    INT 21H
    JMP REPEAT

PRINT_LINE:
    
    ; IF no character input, exit
    CMP    DI, 0
    JE     EXIT
    
    ;go to new line
    MOV AH,2
    MOV DL, 0DH
    int 21h
    mov dl, 0ah
    int 21h
     
    ; pop one, and display
    
    MOV CX, DI  ; counter cx
    MOV DI, 0
POPPING:
    
    MOV DL, stk[DI]  ; first BL
    INT 21h
    INC DI 
    
    LOOP POPPING    ; loop until cx=0
          
     
EXIT:
    MOV AH,4ch
    INT 21H
MAIN    ENDP
    END MAIN
                      