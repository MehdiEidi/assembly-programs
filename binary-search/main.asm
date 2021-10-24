include irvine32.inc

.386
.model flat, C
.stack 4096
ExitProcess PROTO, dwExitCode: DWORD

ARRAY_SIZE = 5

.data
	enterArrayPrompt byte "Enter array elements: ", 0
	enterNumberToSearchPrompt byte "Enter number to search for: ", 0
	notFound byte "not found", 0
	foundAtStr byte "Found at: ", 0

	array DWORD ARRAY_SIZE DUP(?)
	
	num DWORD ?
	
	l DWORD ?
	r DWORD ?
	m DWORD ?
	i DWORD ?
	

.code

main PROC
	; Print 'enter array' prompt
	mov edx, offset enterArrayPrompt
	call writestring

	; get array elements
	mov edi, offset array						; edi = ptr to array
	mov ecx, ARRAY_SIZE							; loop coounter

	L1: call ReadInt							; read to eax
		stosd									; move eax to next position of array (edi)
		loop L1

	; print 'enter target' prompt
	mov edx, offset enterNumberToSearchPrompt
	call writestring

	; get target num
	call ReadInt
	mov num, eax								; num = eax -> contains target now

	; initiate binary search
	mov l, 0									; l = 0 the left boundry
	mov r, ARRAY_SIZE-1							; r = len(array)-1 right boundry
	
L3:
	mov eax, l									; eax = l
	mov ebx, r									; ebx = r
	cmp ebx, eax								; (l <= r) ?
	JGE L7										; if (r >= l) jump L7
	jmp NRet										; if (r < l) exit

	L7:
		mov eax, r								; eax = r
		mov ebx, l								; ebx = l
		sub eax, ebx							; eax = eax - ebx
		sub edx, edx							; edx = 0 need to do this because div is edx:eax / ebx
		mov ebx, 2								; ebx = 2
		div ebx									; eax = eax / 2
		add eax, l								; eax = l
		mov m, eax								; m = l + (r - l) / 2

		mov esi, offset array					; esi = ptr to array
		mov eax, m								; eax = m
		mov ebx, 4								; ebx = 4
		mul ebx									; eax = m * 4
		mov ebx, [esi+eax]						; ebx = array[m]
		mov i, eax								; i = m * 4 for getting the index later
		mov eax, num							; eax = num
		cmp eax, ebx							; array[m] == num ?
		jne L4									; if (array[m] != num) jump L4
		jmp L6									; if (array[m] == num) yay! we found it!
		
	L4:
		mov esi, offset array					; esi = ptr to array
		mov eax, m								; eax = m
		mov ebx, 4								; ebx = 4
		mul ebx									; eax = m * 4
		mov ebx, [esi+eax]						; ebx = array[m]
		mov eax, num							; eax = num
		cmp ebx, eax							; num > array[m] ?
		jg L5									; if (num < array[m]) jump L5
		
		; if (num > array[m])
		mov eax, m								; eax = m
		add eax, 1								; eax = m + 1
		mov l, eax								; l = m + 1
		jmp L3									; Loop

	L5:
		mov eax, m								; eax = m
		sub eax, 1								; eax = m - 1
		mov r, eax								; r = m - 1
		jmp L3							     	; Loop
				

	jmp NRet

	; found
	L6:
		mov eax, i								; eax = index * 4
		mov ebx, 4								; ebx = 4
		div ebx									; eax = index
		mov edx, offset foundAtStr				; edx = ptr to foundAtStr
		call writestring
		call writeint							; write found index
		jmp e									; exit

	; print 'not found'
	NRet:
		mov edx, offset notFound				
		call writestring

	; exit
	e:

	INVOKE ExitProcess, 0
main ENDP
end main