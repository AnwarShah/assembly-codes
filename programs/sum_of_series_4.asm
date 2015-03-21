; Program 12: Write a program to put the sum 100+95+90+......+5 in AX, and display
; the result
;This program is incomplete as it does not display the result yet


DATA SEGMENT
    msg db  'The sum is '
    digit1 db '00000','$'    
    temp dw ?
    temp1 dw ?
DATA    ENDS    

CODE    SEGMENT
MAIN:
    MOV ax, @data
    mov ds, ax  ; initialize ds
        
    XOR AX,AX   ; clear AX
    MOV AX,100D ; store 100 decimal in AX
    XOR CX,CX   ; clear CX
    MOV CX, 100D ;  store 95 in CX
    
WHILE:
    SUB CX,5
    ADD AX, CX
    CMP CX, 5
    JZ  to_decimal
    JMP WHILE
    
to_decimal:
    mov temp1, ax    ; store result in temp
    mov temp, ax
    
    mov di,4
    
    
next_digit:
    cmp temp, 0
    je end_decimal
    
    xor dx,dx
    mov ax,temp
    mov bx,10
    div bl  ; ah=remainder and al=ax/10
    ;int 3
    mov digit1[di], ah
    add digit1[di], 30h ; convert to ascii
    
    xor ah,ah
    mov temp, ax
    
    dec di
    jmp next_digit
end_decimal:
    
print_decimal:
    mov ah,9
    mov dx, offset msg
    int 21h                
                                         
exit:
    mov ah,4ch
    int 21h       
    
CODE    ENDS
    END MAIN