# suma.s del GuiÃ³n anterior
# 1.- cambiando a convenciÃ³n SystemV
# 2.- aÃ±adiendo printf() y cambiando syscall por exit()
# 3.- extrayendo suma a mÃ³dulo C para linkar
# 4.- dejando sÃ³lo los datos, que el resto lo haga suma() en mÃ³dulo C
# 5.- entero en C
# 6.- volviendo a sacar la suma a ensamblador
#	gcc -Og -g    suma_06_CS_c.c    suma_06_SC_s.s -o suma_06_CS
#
#	gcc -Og -g -c suma_06_CS_c.c
#	as      -g    suma_06_CS_s.s -o suma_06_CS_s.o
#	gcc           suma_06_CS_c.o    suma_06_CS_s.o -o suma_06_CS
#
#	ld            suma_06_CS_c.o    suma_06_CS_s.o -o suma_06_CS \
#					/usr/lib/x86*/crt?.o -lc     \
#					-dynamic-linker /lib64/ld-linux*

.section .text
suma:	.global suma
	mov  $0, %eax		# acumulador
	mov  $0, %rdx		# Ã­ndice
bucle:
	add  (%rdi,%rdx,4), %eax
	inc   %rdx
	cmp   %rdx,%rsi
	jne    bucle

	ret
