include irvine32.inc

.386
.model flat, C
.stack 4096
ExitProcess PROTO, dwExitCode: DWORD

ARRAY_SIZE = 5

.data
	enterArrayPrompt byte "Enter array elements: ", 0
	array DWORD ARRAY_SIZE DUP(?)
	enterNumberToSearchPrompt byte "Enter number to search for:", 0
	num DWORD ?
	l DWORD ?
	r DWORD ?
	m DWORD ?
	i DWORD ?
	notFound byte "not found", 0

.code

main PROC
	; Print enter array prompt
	mov edx, offset enterArrayPrompt
	call writestring

	; get array elements
	mov edi, offset array
	mov ecx, ARRAY_SIZE

	L1: call ReadInt
		stosd
		loop L1

	; get target num
	mov edx, offset enterNumberToSearchPrompt
	call writestring

	call ReadInt
	mov num, eax

	; initiate binary search
	mov l, 0
	mov r, ARRAY_SIZE-1
	
	mov eax, l
	mov ebx, r
	cmp ebx, eax
	JG L3

	L3:
		mov eax, r
		mov ebx, l
		sub eax, ebx
		sub edx, edx
		mov ebx, 2
		div ebx
		add eax, l
		mov m, eax

		mov esi, offset array
		mov eax, m
		mov ebx, 4
		mul ebx
		mov ebx, [esi+eax]
		mov i, eax
		mov eax, num
		cmp eax, ebx
		jne L4

		jmp L6
		
		L4:
			mov esi, offset array
			mov eax, m
			mov ebx, 4
			mul ebx
			mov ebx, [esi+eax]
			mov eax, num
			cmp ebx, eax
			jg L5
			mov eax, m
			add eax, 1
			mov l, eax
			jmp L3

			L5:
				mov eax, m
				sub eax, 1
				mov r, eax
				jmp L3
				

		jmp NRet

		; found
		L6:
		mov eax, i
		mov ebx, 4
		div ebx
		call writeint
		jmp e

		; not found
		NRet:
			mov edx, offset notFound
			call writestring

		e:

	INVOKE ExitProcess, 0
main ENDP
end main