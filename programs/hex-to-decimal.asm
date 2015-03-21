; Hex digit to Decimal

DATA    segment
   msg1  db  'Enter a Hex Digit: $'
   msg2 db   0Ah,0dh,'In Decimal it is '
        db      '$'
   msg3 db  0AH,0dh, 'Do you want to do it again? $'
DATA    ends

Code segment
    assume  cs:code, ds:code

start:
    ; initialize data segment
    mov ax,data
    mov ds,ax
    jmp while
      
new_line:
    mov ah,2
    mov dl, 0ah
    int 21h
    mov dl, 0dh
    int 21h      
      
WHILE:    
    ; display prompt
    mov ah,9
    mov dx, offset msg1
    int 21h
    
    ;read value
    mov ah,1
    int 21h
    mov bl,al ; store
    
    ; determine whether digit or letter
    cmp al, 39H
    ja  letter  ; no it is letter
    
    ; else display the digit in decimal
    mov ah,9
    mov dx, offset msg2
    int 21h
    mov ah,2
    mov dl, bl
    int 21h
    jmp prompt
    
letter:
    cmp al,41h  ; check if it is A
    je  A
    cmp al,42h  ; or B
    je B
    cmp al,43h  ; or C
    je  C
    cmp al,44h  ; or D
    je D
    cmp al,45h  ; or E
    je E    
    cmp al, 46h ; or F
    je F
    
A:  
    mov dx, offset msg2
    mov ah,9
    int 21h
    mov ah,2
    mov dl, '1'
    int 21h
    mov dl, '0'
    int 21h
    JMP prompt
B:
    
    mov dx, offset msg2
    mov ah,9
    int 21h
    mov ah,2
    mov dl, '1'
    int 21h
    mov dl, '1'
    int 21h
    JMP prompt
C:  
    
    mov dx, offset msg2
    mov ah,9
    int 21h
    mov ah,2
    mov dl, '1'
    int 21h
    mov dl, '2'
    int 21h
    JMP prompt
D:                                  
    
    mov dx, offset msg2
    mov ah,9
    int 21h
    mov ah,2
    mov dl, '1'
    int 21h
    mov dl, '3'
    int 21h
    JMP prompt
E: 
    
    mov dx, offset msg2
    mov ah,9
    int 21h
    mov ah,2
    mov dl, '1'
    int 21h
    mov dl, '4'
    int 21h
    JMP prompt
F:
    
    mov dx, offset msg2
    mov ah,9
    int 21h
    mov ah,2
    mov dl, '1'
    int 21h
    mov dl, '5'
    int 21h
    JMP prompt     

prompt:
     mov ah,9
     mov dx, offset msg3
     int 21h
     ; read option
     mov ah,1
     int 21h
     ; compare
     cmp al, 59h    ; big Y
     je new_line
     cmp al, 79h    ; small y
     je new_line
EXIT:
    mov ah,4ch
    int 21h
     
Code ends
    end start
    