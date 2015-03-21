; decimal input and store in binary

org 100h

;;------------------- Pseudo-code ----------------------
; input a number
; if negative sign is encountered, put negative = true
; initialize product = 0
; read digit,
; convert it to binary
; product = product * 10 + digit
; until CR is encountered
; if the number is negative (CX=1) negate it 
;;------------------------------------------------------

; BX will be used to hold the number converted into binary
; AX will hold the digit read
; CX will be used for negative marking flag, CX=1 means negative
BEGIN:

XOR BX,BX   ; clear BX
XOR AX,AX   ; clear AX
XOR CX,CX   ; clear CX

; read a number of sign
MOV AH,1
INT 21H

; if negative sign, set CX
CMP AL, '-'
JE MINUS

;otherwise store it in bx
     
REPEAT:
; check if the entered digit is in range 0-9
CMP AL, 30H     
JL ILLEGAL_DIGIT
CMP AL, 39H
JG ILLEGAL_DIGIT

; if CR , end of input
CMP AL, 0DH
JE  END_INPUT 

; convert to binary
AND AX, 000FH
; save the number in stack
PUSH AX

MOV AX, BX  ; load previos product in AX
MOV BX, 10  ; multiplicand 10 in BX
MUL BX      ; multiply

MOV BX, AX  ; save product in BX
POP AX      ; pop previous number in AX
ADD BX, AX  ; add the number with total product

; read another
mov ah,1
int 21h

JMP REPEAT


MINUS:
MOV CX, 1
INT 21H ; read next
JMP REPEAT
    
END_INPUT:

; if CX = 1, number is negative
CMP CX, 1
JNE POSITIVE
NEG BX
; number is positive
POSITIVE:
MOV AX,BX ; put the number in AX

ILLEGAL_DIGIT:
; illegal digit read
; go to next line start again
MOV AH,2
MOV DL, 0dh
int 21h
mov dl, 0ah
int 21h
mov ah,9
LEA dx, msg
int 21h
JMP BEGIN

;data

msg db 0dh,0ah,'Illegal digit, Enter again',0dh,0ah,0h
    
ENDP



