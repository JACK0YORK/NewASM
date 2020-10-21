
.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
x word 12
y word 3

.code
main proc
	mov ax,y-x
	mov ax,y-2
	invoke ExitProcess,0
main endp
end main