.MODEL SMALL 
.STACK 100H 
.DATA 
	text DB 'this is a sample string', '$'
  
.CODE 
	MAIN PROC 
 		MOV AX,@DATA 
 		MOV DS,AX 

		; reposition the curser
		mov     dl, 10  ; col
		mov     dh, 10  ; row 
		mov     ah, 02h
		int     10h
  
 		; store offset of the text (load effective address)
		LEA DX, text
     
 		; print the text
 		MOV AH,09H
 		int 21H 
    
 		; exit
 		MOV AH,4CH
 		int 21H 
  
	MAIN ENDP 
	END MAIN 