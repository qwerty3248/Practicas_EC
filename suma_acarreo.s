### sección de datos ################################################
.section .data

##### tests a realizar (definidos mediante macros)
#ifndef TEST
#define TEST 20
#endif

.macro linea
    #if TEST == 1
        .int 1, 1, 1, 1
    #elif TEST == 2 
        .int 0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF
    #elif TEST == 3
        .int 0x10000000, 0x10000000, 0x10000000, 0x10000000
    #elif TEST == 4
        .int 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF
    #elif TEST == 5
        .int -1, -1, -1, -1
    #elif TEST == 6
        .int 200000000, 200000000, 200000000, 200000000
    #elif TEST == 7
        .int 300000000, 300000000, 300000000, 300000000
    #elif TEST == 8
        .int 5000000000, 5000000000, 5000000000, 5000000000
    #else
        .error "Definir TEST entre 1 y 8"
    #endif
.endm

# creación del array usando la macro 'linea'
lista:      .irpc i,1234
                linea
            .endr
longlista:  .int    (.-lista)/4
resultado:  .quad   8

# formato de salida
formato:    .ascii "resultado \t =   %18lu (uns)\n"
            .ascii         "\t\t = 0x%18lx (hex)\n"
            .asciz "\t\t = 0x %08x %08x \n"
	

### sección de texto ################################################

##### main #####
.section .text
main: .global main

    # llamada a 'suma'
    movq $lista, %rbx       # dirección del array
    movl longlista, %ecx    # longitud del array
    call suma               # llamada

    movl %eax, resultado
    movl %edx, resultado+4

    # resultados y salida del programa
    call imprim_C
    call acabar_C



##### suma #####
# argumentos:
# 'rbx' -> dirección del array
# 'ecx' -> longitud del array
#
# devuelve:
# 'edx:eax' -> resultado
suma:
    # poner a 0 los registros:
    xorl %edx, %edx     # registro superior de la suma
    xorl %eax, %eax     # registro inferior de la suma
    xorq %rsi, %rsi     # índice

suma_bucle:
    # sumar el siguiente elemento
    add (%rbx, %rsi, 4), %eax # suma el elemento de índice 'rsi'
    inc %rsi                  # incrementa el índice en el array

    # acarreo
    adc $0, %edx
    #jnc suma_noacarreo  # salta si no hay acarreo
    #inc %edx            # añade el acarreo

#suma_noacarreo:
    # comprobar si ha llegado al final
    cmp %rsi, %rcx      # compara el índice actual con el último
    jne suma_bucle      # si no, vuelve al inicio del bucle
    ret



##### printf ##### 
imprim_C:
    mov %edx,%ecx
    mov %eax,%r8d
    mov $formato,  %rdi     # formato de la salida
    mov resultado, %rsi     # resultado (decimal)
    mov resultado, %rdx     # resultado (hexadecimal)
    mov $0,        %eax     # varargin sin xmm
    call printf             # llamada a printf()
    ret



##### exit #####
acabar_C:
    mov resultado,  %edi    # código de salida
    call _exit              # llamada a exit()
    ret
