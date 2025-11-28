.MODEL SMALL
.STACK 100h
.DATA

msgGreen db 'GREEN LED IS TURNED ON$',0
msgRed   db 'RED LED IS TURNED ON$',0
line     db '-----------------------------------------------------$',0
waitMsg  db 'Another Reading in 3 seconds Please Wait...$',0

.CODE
MAIN PROC
    mov ax, @data
    mov ds, ax

    mov bx, 0           ; Init toggle flag

START:
    xor bx, 1           ; Toggle flag (0 or 1)
    cmp bx, 1
    je  SHOW_GREEN
    jmp SHOW_RED

SHOW_GREEN:
    mov dx, OFFSET msgGreen
    mov ah, 09h
    int 21h
    jmp PRINT_REST

SHOW_RED:
    mov dx, OFFSET msgRed
    mov ah, 09h
    int 21h

PRINT_REST:
    ; Newline
    mov ah, 02h
    mov dl, 0Dh
    int 21h
    mov dl, 0Ah
    int 21h

    ; Print line
    mov dx, OFFSET line
    mov ah, 09h
    int 21h

    ; Newline
    mov ah, 02h
    mov dl, 0Dh
    int 21h
    mov dl, 0Ah
    int 21h

    ; Print wait message
    mov dx, OFFSET waitMsg
    mov ah, 09h
    int 21h

    ; Newline
    mov ah, 02h
    mov dl, 0Dh
    int 21h
    mov dl, 0Ah
    int 21h

    CALL DELAY3SEC
    jmp START

MAIN ENDP

; -----------------------------
; Delay for 3 seconds
; -----------------------------
DELAY3SEC PROC
    mov cx, 3           ; 3 iterations
delay_loop:
    CALL ONE_SECOND_DELAY
    loop delay_loop
    ret
DELAY3SEC ENDP

; -----------------------------
; Delay for ~1 second
; -----------------------------
ONE_SECOND_DELAY PROC
    PUSH CX             ; Save outer loop counter
    
    mov cx, 40h         ; Adjust for speed
outer:
    mov dx, 0FFFFh
inner:
    dec dx
    jnz inner
    loop outer
        
    POP CX              ; Restore outer loop counter
    ret
ONE_SECOND_DELAY ENDP

END MAIN
