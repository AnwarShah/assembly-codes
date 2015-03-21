
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

outdec proc
    
; save registers
push ax
push bx
push cx
push dx

; if ax < 0
    or ax, ax   
    jge end_if
;then
    push ax ; save number
    mov dl, '-'
    mov ah,2
    int 21h
    pop ax
    neg ax ; ax = -ax    

end_if:
    ; get decimal digit
    xor cx,cx   ;cx counts digits
    mov bx, 10d ; load divisor
repeat:    
    xor dx,dx   ; clear dividend high word
    div bx
    push  dx    ; save remainder
    inc cx
; if dividend 0, its over
    or ax,ax
    jne repeat
    
; convert digits to characters and print
    mov ah,2
print_loop:    
    pop dx  ; digits in dl
    or dl, 30h  ; convert to character
    int 21h
    loop print_loop
;end print_loop

    pop dx
    pop cx
    pop bx
    pop ax
        
ret
endp



