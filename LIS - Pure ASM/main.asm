INCLUDE Irvine32.inc

.data

	arr dword 14, 17, 26, 42, -5, 10, 20, 22, 19, -5
	c dword 0
	p dword 0
	l dword lengthof arr

.code

main PROC

	mov esi, offset arr
	mov edi, offset arr + type dword
	mov ecx, lengthof arr
	mov edx, 0; set c
L1:
	mov eax, [esi]
	mov ebx, [edi]
	cmp ebx, eax
	jl L2
	inc edx	
	jmp L3
L2 : 
	mov eax, c
	cmp edx, eax
	jb L3
	mov c, edx
	mov p, esi
	mov edx, 0
L3:
	add esi, type dword
	add edi, type dword
	loop L1

	mov esi, p
	mov eax, c	
	mov ebx, type dword
	mul ebx
	sub esi, eax
	mov edi, offset s
	mov ecx, c
	inc ecx
L4 :
	mov eax, [esi]
	mov[edi], eax
	call WriteInt
	call Crlf
	add esi, type dword
	add edi, type dword
	loop L4

INVOKE ExitProcess, 0
main ENDP
END main