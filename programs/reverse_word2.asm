; If input is 'this is a test' this program outputs 'siht si a tset'

.MODEL  SMALL
.STACK  100H
.DATA
    temp dw     ?   ; temp variable for garbage stack output
    own_stack   db  100 dup(?)  ; our own stack of byte data
.CODE   

MAIN    PROC
    
    XOR DX,DX   ; clear DX
    XOR CX,CX   ; counter for chars
    
DO:    
    ; Get char 
    MOV ah,1
    INT 21h
    
    ; if carriage return stop input
    cmp al, 0dh
    JE PRINT_LINE
    
    MOV DL,AL   ; store in DL
    PUSH    DX  ; store in DX
    INC CX      ; increase cx
    INT 21H     ; get another
    
REPEAT:    
    ; if carriage return stop input
    cmp al, 0dh
    JE PRINT_LINE
    
   
    MOV DH, DL  ; mov into DH
    MOV  DL,AL
    POP  temp     ; remove old two letters
    PUSH  DX ; store new two reversed letters
    
    INC CX
    
    INT 21H
    JMP REPEAT

PRINT_LINE:
     ; IF no character input, exit
     CMP    CX, 0
     JE     EXIT
     
     ; pop one, and display
     MOV AH,2
POPPING:
    POP BX  ; BX will contain two char
    MOV DL, BL  ; first BL
    INT 21h
    MOV DL, BH  ; second BH
    INT 21H
    
    LOOP POPPING    ; loop until cx=0
          
     
EXIT:
    MOV AH,4ch
    INT 21H
MAIN    ENDP
    END MAIN
                      