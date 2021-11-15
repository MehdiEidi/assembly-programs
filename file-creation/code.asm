.stack 100h

.data
    text     db "Sample text", 0
    filename db "D:/text.txt", 0
    fd       dw ?

.code          
    ;Initialize data segment
    mov  ax, @data
    mov  ds, ax

    ;Creating the file
    mov  ah, 3ch
    mov  cx, 0
    mov  dx, offset filename
    int  21h  

    ;Save returned file descriptor
    mov  fd, ax

    ;Write string to the file
    mov  ah, 40h
    mov  bx, fd
    mov  cx, 12 ;String length
    mov  dx, offset text
    int  21h

    ;Close the file
    mov  ah, 3eh
    mov  bx, fd
    int  21h      

    ;Exit
    mov  ax, 4c00h
    int  21h 
     