; this program reads a string and display it with reversed word
; example: 'this is a test' outputs 'siht si a tset'

.model small
.stack 100h
.data
    temp dw 0
    string db   100 dup(32)
    total db    ?
.code
MAIN PROC
    ; initialize data segment
    mov ax, @data
    mov ds, ax
    
    ; setup counters
    mov cx,0
    mov di, 0 ; points to start point of the last word
    
read:
    ; read value
    mov ah,1
    int 21h
    
    ; if CR, go to display
    cmp al, 0DH
    je  display
    
    ; if space, ready for another word
    cmp al, 20h
    je space
    
    ; else push it on stack
    mov byte ptr temp, al
    push temp
    
    inc cx  ; increase letter count in the current word
    inc total ; increase total char count in the string
    
    jmp read

space:  
    ; space means the word is finished
    ; so we pop all the chars and assign them 
    ; to string
    assign:
        pop bx
        mov string[di], bl
        inc di
        loop assign
    
    ;store the space
    
    mov string[di+1], al
    
    ; reset the word count
    mov cx,0
    
    ; di points to next words' first position
    add di, 1
    
    ; increase total
    inc total
    
    jmp read    

display:
    ; CR means end of input 
    ; so we pop all the chars of the last word
    ; and assign them to string
     
    last_word:
        pop bx
        mov string[di], bl
        inc di
        loop last_word
    
    ;store the null at the end
    mov string[di], 00h
    
    ; increase total
    inc total
    
    ; display the string
    mov cl, total   ; counter
    mov di,0
    
    mov ah,2
    print:
    mov dl, string[di]
    int 21h
    inc di
    loop print

exit:
    mov ah,4ch
    int 21h        
main endp
    end main