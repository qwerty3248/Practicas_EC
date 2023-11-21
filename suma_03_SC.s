# suma.s del GuiÃ³n anterior
# 1.- cambiando a convenciÃ³n SystemV
# 2.- aÃ±adiendo printf() y cambiando syscall por exit()
# 3.- extrayendo suma a mÃ³dulo C para linkar
#	gcc -Og -g -c suma_03_SC_c.c
#	as      -g    suma_03_SC.s -o suma_03_SC.o
#	ld            suma_03_SC_c.o    suma_03_SC.o -o suma_03_SC \
#		-lc   -dynamic-linker /lib64/ld-linux-x86-64.so.2


.section .data
lista:		.int 1,2,10,  1,2,0b10,  1,2,0x10
longlista:	.int (.-lista)/4
resultado:	.int 0
formato:	.asciz	"resultado = %d = 0x%x hex\n"
				# formato para printf() libC
.section .text
_start:	.global _start

	mov     $lista, %rdi
	mov  longlista, %esi
	call suma
	mov  %eax, resultado	# res = suma(&lista,longlista);

	mov   $formato, %rdi
	mov  resultado, %esi	# podrÃ­a haber sido %eax
	mov  resultado, %edx
	mov         $0, %eax
	call printf		# printf(formato, resultado, resultado);

	mov         $0, %edi
	call exit		# exit(status);

# suma: pasada a mÃ³dulo C

