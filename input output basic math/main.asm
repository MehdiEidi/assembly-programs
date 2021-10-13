                    
.MODEL SMALL      ; model small tells the assembler that you intend to use the small memory model - one code segment, one data segment and one stack segment
.STACK 256        ; 256 bytes of stack determined to use in our program
                                                       

.data
    num1 dw ?                    ; define num1 word uninitialized
    num2 dw ?                    ; define num2 word uninitialized
    
    multRes dw ?                 ; result of multiplication 
    sumRes dw ?                  ; result of summation
    subRes dw ?                  ; result of subtraction
    divRes dw ?                  ; result of division
   
    printSomeKeyPrompt db "press some key to end...$"


.code
    ; entry point of our program      
    MAIN PROC                                   
        MOV ax, @DATA                         
        MOV DS, ax          ; Data segment register (DS): points to the data segment of the memory where the data is stored                  
               
               
        call getNum         ; calling procedure getNum to get a number from user
        mov num1, bx        ; move the num to num1
    
        call lineFeed       ; print a newline (line feed)              
                                          
        call getNum         
        mov num2, bx                                                        
    
        call lineFeed    
                    
                    
        ; summation
        mov ax, num1
        add ax, num2
        mov sumRes, ax
    
        ; subtraction
        mov ax, num1
        sub ax, num2
        mov subRes, ax
              
        ; multiplication
        mov ax, num1
        mul num2
        mov multRes, ax
          
        ; division
        mov ax, num1
        div num2
        mov divRes, ax
              
              
        ; print sumRes
        mov bx, sumRes
        call printRes
    
        ; print subRes
        mov bx, subRes
        call printRes
                     
        ; print multRes
        mov bx, multRes
        call printRes
       
        ; print divRes
        mov bx, divRes
        call printRes
                                     
                                     
        lea dx, printSomeKeyPrompt   ; load the pointer to printSomeKeyPromt in dx
        mov ah, 9                    ; ah=9 sys_write system call
        int 21h                      ; perform an interrupt
                                     
        mov ah, 1                    ; ah=1 sys_read system call
        int 21h                      ; perform an interrupt
    
        mov ax, 4c00h                ; ax=4c ah=00 sys_exit system call to give control back to operating system
        int 21h                      ; perform an interrupt
    MAIN ENDP

    
    ; getNum gets a number from the user char by char and converts it to int from ASCII
    getNum PROC
        mov bx, 0

        mov ah, 1       ; ah=1 sys_readChar the char will be stored in AL
        int 21H         ; interrupt

        jmp @INPUT

        ; convert the given character to number and get the next char until \n entered
        @INPUT:
            and ax, 000FH   ; a digit is between 0-9 so we only need 4 less significant bits. so we clear the rest of the bits 

            push ax         ; save the current value in ax

            mov ax, 10      ; algorithm of atoi -> 123 = (1*10+2)*10+3 
            mul bx
            mov bx, ax

            pop ax

            add bx, ax

            mov ah, 1       ; get next char
            int 21H

            cmp al, 0DH     ; check to see if user input ==  \n
            jne @INPUT      ; if \n not enterd get next char

        RET
    getNum ENDP


    ; printRes prints content of BX
    printRes PROC
        cmp bx, 0       ; check to see bx > 0
        jge @s          ; if bx > 0 jumpt to s
        
        mov ah, 2       ; ah=2 sys_writeChar writes content of DL to stdout
        mov dl, "-"     ; because number is negative at this point, we add a - char before displaying the number
        int 21H

        neg bx

        @s:
            mov ax, bx
            mov cx, 0
            mov bx, 10
    
                @L:
                    mov dx, 0
                    div bx
                    push dx
                    inc cx
                    or ax, ax
                    jne @L

                mov ah, 2          ; ah=2 sys_writeChar writes content of DL to stdout

                @printChar:
                    pop dx
                    or dl, 30H
                    int 21H
                    loop @printChar     
        
                call lineFeed

        RET
    printRes ENDP


  ; lineFeed prints a newline character \n in stdout
  lineFeed PROC 
    ; save ax, dx
    push ax
    push dx
              
    ; write a char to stdout (line feed char)          
    mov ah, 2
    mov dl, 0DH
    int 21H
    
    ; write carriage return char to stdout
    mov dl, 0AH
    int 21H
    
    ; restore ax, dx
    pop dx
    pop ax

    ret
  lineFeed ENDP