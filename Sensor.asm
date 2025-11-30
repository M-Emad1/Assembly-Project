data segment                                          
    msgGreen  db 'GREEN -> Less than 100 C -> Temp = ', '$'
    msgYellow db 'YELLOW -> 100-500 C -> Temp = ', '$'
    msgRed    db 'RED -> More than 500 C -> Temp = ', '$'

    newline   db 13,10,'$'

    numStr db 5 dup('$')     
ends

stack segment
    dw 128 dup(0)
ends

code segment
start:
    mov ax, data
    mov ds, ax
    mov es, ax

main_loop:
    mov ah, 00h
    int 1Ah
    mov ax, dx
    xor dx, dx
    mov cx, 700
    div cx
    mov bx, dx       
    
    cmp bx, 100
    jl print_green

    cmp bx, 500
    jle print_yellow

    jmp print_red

print_green:
    mov dx, offset msgGreen
    jmp print_msg

print_yellow:
    mov dx, offset msgYellow
    jmp print_msg

print_red:
    mov dx, offset msgRed

print_msg:
    mov ah, 09h
    int 21h

   
    mov ax, bx           
    mov di, offset numStr
    call print_number

    mov dx, offset newline
    mov ah, 09h
    int 21h

    call delay1sec
    jmp main_loop

print_number:
    mov cx, 0      
    mov bx, 10

conv_loop:
    xor dx, dx
    div bx         
    push dx        
    inc cx
    cmp ax, 0
    jne conv_loop

write_loop:
    pop dx
    add dl, '0'     
    mov [di], dl
    inc di
    loop write_loop

    mov byte ptr [di], '$'

    mov dx, offset numStr
    mov ah, 09h
    int 21h
    ret

delay1sec:
    mov ah, 00h
    int 1Ah
    mov bx, dx

wait_loop:
    mov ah, 00h
    int 1Ah
    sub dx, bx
    cmp dx, 18h
    jb wait_loop
    ret

ends
end start
