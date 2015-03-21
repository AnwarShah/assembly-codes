;Program 19:
; A program which prompts the user to enter 
; a character and print its ascii code in binary
; and count the number of 1 bit
; in its ascii code

; The program assumes that the user enter a valid character

DATA    segment
    msg1    db 'Type a character: $', 0AH, 0DH
    msg2    db  0AH,0DH,'The ASCII Code of ', 
    msg3    db  ?,' in binary is $'
    msg4    db  0AH,0DH,'The number of 1 bits is '
    msg5    db  ?,'$'
DATA    ENDS

Code    segment
    assume  cs:code, DS: DATA
    
START:
    MOV AX, DATA
    MOV DS, AX  ; initialize data segment
    
    XOR BL,BL   ; BL will contain the ascii code
    
    ; prompt user
    mov ah,9
    Lea DX, msg1
    int 21H;     
    
    ; read the value
    MOV AH, 1
    INT 21H
    
    ; store it in BL
    MOV BL,AL
    ;also in msg3
    MOV msg3, AL
    
    ; display message
    MOV AH,9
    LEA DX ,msg2
    INT 21H
    
    ; CH counts the number of one's 
    MOV CH, 00H
    
    ; display the ascii code in binary
    MOV AH,2    ; select the display funct
    
    ; counter for binay bits
    MOV CL, 8
   
DISPLAY:
    ; Rotate left to get the msb of AL in CF
    RCL BL,1
    ; see if CF is 1 or 0
    JC  ONE ; it is one, so jump to appropriate location
    ; if zero than ready to display it
    MOV DL, '0'
    JMP PRINT
ONE:
    MOV DL, '1'    
    INC CH ; increase number of 1 count
PRINT:
    INT 21H
    DEC CL  ; decrease count of CL
    CMP CL, 0 ; check if CL is zero
    JZ  NO_OF_ONES
    JMP DISPLAY
           
NO_OF_ONES:
    ADD CH,30H; get the count of 1 is ascii
    MOV msg5, CH;   store it in msg5
               
    ; print the number of 1 bits
    MOV AH,9
    LEA DX,msg4
    INT 21H    
              
EXIT:
    MOV AH, 4CH
    INT 21H
        
CODE    ENDS
    END START