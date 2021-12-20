.MODEL SMALL 

.STACK 800H 

.DATA 
    p_s dw 50h  	        ; square size
    p_x dw 120		        ; initial position of pixel on x axis
    p_y dw 80		        ; initial position of pixel on y axis
  
.CODE 
    MAIN PROC 
        MOV AX,@DATA 
        MOV DS,AX     
        
        mov ah, 00h 	    ; set video mode 
        mov al, 13h		    ; set video mode type -> 320x200 256 color graphics (default is text mode 00h)
        int 10h
    
        mov cx, p_x 	    ; initial posotion x axis, cx = position of pixel to be drawn in x
        mov dx, p_y 	    ; initial position y axis, dx = position of pixel to be drawn in y
        
        horizontal:
            mov ah, 0ch     ; draw pixel  
            mov al, 0ch     ; pixel color
            int 10h
            
            inc cx     	    ; inc position on x axis to move forward
            
            mov ax, cx
            sub ax, p_x
            cmp ax, p_s	    ; compare to see if we have reached the size we wanted in x axis
            jng horizontal  ; jump if not greater than
            
            mov cx, p_x 	; set cx to initial pixel position
            
    	inc dx      	    ; inc posotion on y axis to move downwards
            
            mov ax, dx   
            sub ax, p_y
            cmp ax, p_s	    ; compare to see if we have reached the size we wanted in y axis
            jng horizontal
                      
                            
        mov ah, 4ch         ; exit and give control to OS
        int 21h
    MAIN ENDP 
    
END MAIN
                  
                  
    