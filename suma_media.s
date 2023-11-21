### sección de datos ################################################
.section .data

##### tests a realizar (definidos mediante macros)
#ifndef TEST
#define TEST 20
#endif

.macro linea
    #if TEST == 1
        .int 1, 2, 1, 2
    #elif TEST == 2 
        .int -1, -2, -1, -2
    #elif TEST == 3
        .int 0x7FFFFFFF, 0x7FFFFFFF, 0x7FFFFFFF, 0x7FFFFFFF
    #elif TEST == 4
        .int 0x80000000, 0x80000000, 0x80000000, 0x80000000
    #elif TEST == 5
        .int 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF
    #elif TEST == 6
        .int 2000000000, 2000000000, 2000000000, 2000000000
    #elif TEST == 7
        .int 3000000000, 3000000000, 3000000000, 3000000000
    #elif TEST == 8
        .int -2000000000, -2000000000, -2000000000, -2000000000
    #elif TEST == 9
        .int -3000000000, -3000000000, -3000000000, -3000000000
    #elif TEST >= 10 && TEST <= 14
        .int 1, 1, 1, 1
    #elif TEST >= 15 && TEST <= 19
        .int -1, -1, -1, -1
    #else
        .error "Definir TEST entre 1 y 19"
    #endif
.endm

.macro linea0
    #if TEST >= 1 && TEST <= 9
        linea
    #elif TEST == 10
        .int 0, 2, 1, 1 
    #elif TEST == 11
        .int 1, 2, 1, 1 
    #elif TEST == 12
        .int 8, 2, 1, 1 
    #elif TEST == 13
        .int 15, 2, 1, 1 
    #elif TEST == 14
        .int 16, 2, 1, 1 
    #elif TEST == 15
        .int 0, -2, -1, -1 
    #elif TEST == 16
        .int -1, -2, -1, -1 
    #elif TEST == 17
        .int -8, -2, -1, -1 
    #elif TEST == 18
        .int -15, -2, -1, -1 
    #elif TEST == 19
        .int -16, -2, -1, -1 
    #else
        .error "Definir TEST entre 1 y 19"
    #endif
.endm

# creación del array usando la macro 'linea'
lista:      linea0
            .irpc i,123
                linea
            .endr
longlista:  .int    (.-lista)/4
resultado:  .quad   -1

# formato de salida
formato:    .ascii "media:\t = %11d \t resto:\t = %11d   \n"
            .asciz       "\t = 0x %08x \t    \t = 0x %08x\n"


### sección de texto ################################################

##### main #####
.section .text
main: .global main

    # llamada a 'suma'
    movq $lista, %rbx       # dirección del array
    movl longlista, %ecx    # longitud del array
    call suma               # llamada

    # efectuar división
    mov $16, %ecx
    idiv %ecx

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
    xorl %ebp, %ebp
    xorl %edi, %edi

suma_bucle:
    # sumar el siguiente elemento
    mov (%rbx, %rsi, 4), %eax # mueve el elemento de índice 'rsi'
    cltd                      # extendemos signo a 'edx:eax'
    add %eax, %edi            # sumar la parte menos significativa
    adc %edx, %ebp            # acarreo (sumar la más significativa)
    inc %rsi                  # incrementa el índice en el array

    # comprobar si ha llegado al final
    cmp %rsi, %rcx      # compara el índice actual con el último
    jne suma_bucle      # si no, vuelve al inicio del bucle

    # mover de los registros intermedios a 'edx:eax' 
    mov %edi, %eax
    mov %ebp, %edx
    ret



##### printf ##### 
imprim_C:
    mov %eax,      %ecx     # cociente (hex)
    mov %edx,      %r8d     # resto (hex)
    mov $formato,  %rdi     # formato de la salida
    mov %ecx,      %esi     # cociente
    mov %r8d,      %edx     # resto
    mov $0,        %eax     # varargin sin xmm
    call printf             # llamada a printf()
    ret

#formato:    .ascii "media:\t = %11d \t resto:\t = %11d   \n"
#            .asciz       "\t = 0x %08x \t    \t = 0x %08x\n"


##### exit #####
acabar_C:
    mov resultado,  %edi    # código de salida
    call _exit              # llamada a exit()
    ret



# idiv -> dividendo [EDX:EAX]
#         divisor [ECX]
#         cociente [EAX]
#         resto [EDX]
