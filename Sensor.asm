data segment
    msgGreen  db 'GREEN  (Temp < 100 C)$'
    msgYellow db 'YELLOW (Temp 100-500 C)$'
    msgRed    db 'RED    (Temp > 500 C)$'
    newline   db 13,10,'$'
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
    mov dx, offset newline
    mov ah, 09h
    int 21h
    call delay1sec
    jmp main_loop

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
