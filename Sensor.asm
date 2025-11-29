.MODEL SMALL
.STACK 100h
.DATA

msgGreen  db 'GREEN  (Temp < 100 C)$'
msgYellow db 'YELLOW (Temp 100–500 C)$'
msgRed    db 'RED    (Temp > 500 C)$'
newline   db 13,10,'$'

.CODE
MAIN PROC
    mov ax, @data
    mov ds, ax

START:
    mov ah, 00h
    int 1Ah
    mov ax, dx
    xor dx, dx
    mov cx, 1000
    div cx
    mov bx, dx

    cmp bx, 100
    jl  PRINT_GREEN

    cmp bx, 500
    jle PRINT_YELLOW

    jmp PRINT_RED

PRINT_GREEN:
    mov dx, OFFSET msgGreen
    jmp PRINT_MSG

PRINT_YELLOW:
    mov dx, OFFSET msgYellow
    jmp PRINT_MSG

PRINT_RED:
    mov dx, OFFSET msgRed

PRINT_MSG:
    mov ah, 09h
    int 21h

    mov dx, OFFSET newline
    mov ah, 09h
    int 21h

    CALL DELAY1SEC
    jmp START

MAIN ENDP

DELAY1SEC PROC
    mov cx, 40h
outer:
    mov dx, 0FFFFh
inner:
    dec dx
    jnz inner
    loop outer
    ret
DELAY1SEC ENDP

END MAIN
