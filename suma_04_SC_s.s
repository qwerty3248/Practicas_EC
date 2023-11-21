# suma.s del GuiÃ³n anterior
# 1.- cambiando a convenciÃ³n SystemV
# 2.- aÃ±adiendo printf() y cambiando syscall por exit()
# 3.- extrayendo suma a mÃ³dulo C para linkar
# 4.- dejando sÃ³lo los datos, que el resto lo haga suma() en mÃ³dulo C
#	gcc -Og -g -c suma_04_SC_c.c
#	as      -g    suma_04_SC_s.s -o suma_04_SC_s.o
#	ld            suma_04_SC_c.o    suma_04_SC_s.o -o suma_04_SC \
#		-lc   -dynamic-linker /lib64/ld-linux-x86-64.so.2


.section .data
lista:		.int 1,2,10,  1,2,0b10,  1,2,0x10
longlista:	.int (.-lista)/4
resultado:	.int 0
formato:	.asciz	"resultado = %d = 0x%x hex\n"

.global lista, longlista, resultado, formato

.section .text
_start:  .global _start
	jmp suma
