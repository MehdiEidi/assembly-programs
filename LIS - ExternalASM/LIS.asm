; LIS function's concrete implementation
;-----------------------------------------

.386
.model flat, C
.stack 4096
ExitProcess PROTO, dwExitCode: DWORD

LIS PROTO, arr: PTR DWORD, arrLength: DWORD

.data
	maxCount DWORD 1
	maxEndIndex DWORD 1
	tempCount DWORD 1
	i DWORD 1

.code

;-----------------------------------------------------
; LIS, iterates the array and returns the start index 
; of the longest increasing sequence in the array.
;-----------------------------------------------------
LIS PROC, arr: PTR DWORD, arrLength: DWORD

	L0:
		mov eax, i
		mov ebx, TYPE arr			; ebx should be 4
		mul ebx						; eax = eax * ebx, ebx == 4
		add eax, arr				; eax = arr[i], arr is pointer to array
		mov ecx, eax				; ecx = arr[i]

		mov eax, i
		sub eax, 1					; i-1
		mov ebx, TYPE arr			; ebx should be 4
		mul ebx						; eax = eax * ebx, ebx == 4
		add eax, arr				; eax = arr[i-1], arr is pointer to array

		mov ecx, [ecx]
		mov eax, [eax]
		cmp ecx, eax
		jg INCREASE					; if arr[i] > arr[i-1]
		jle NOTINCREASE				; if not (arr[i] > arr[i-1])

	INCREASE:
		mov eax, tempCount			
		inc eax						
		mov tempCount, eax			; tempCount++

		mov eax, arrLength 
		dec eax						; arrLength-1
		mov ecx, i
		cmp ecx, eax 
		je WHOLE					; if i == arrLength-1			
		jmp L3						; if not (i == arrLength-1)

	WHOLE:
		mov eax, tempCount
		mov ecx, maxCount
		cmp eax, ecx
		jg L1						; if tempCount > maxCount			
		jmp L3						; if not (tempCount > maxCount)

	L1:
		mov eax, tempCount
		mov maxCount, eax			; maxCount = tempCount	
		mov eax, i
		mov maxEndIndex, eax		; maxEndIndex = i
		jmp L3

	NOTINCREASE:
		mov eax, tempCount
		mov ecx, maxCount
		cmp eax, ecx
		jg L2						; if tempCount > maxCount			
		jmp L3

	L2:
		mov eax, tempCount
		mov maxCount, eax			; maxCount = tempCount	
		mov tempCount, 1			; tempCount = 1	
		mov eax, i
		dec eax						; i-1			
		mov maxEndIndex, eax		; maxEndIndex = i-1

	L3:
		mov eax, i
		inc eax						; i++
		mov i, eax
	    mov ecx, arrLength
		cmp ecx, eax
		jle Exit						; if i >= arrLength then exit loop
		jmp L0							; Loop

	Exit:
		; computing the startIndex from endIndex and count
		mov eax, maxCount
		mov ecx, maxEndIndex
		sub ecx, eax
		inc ecx
		mov eax, ecx

	RET
LIS ENDP

end