.section .data
lista:      .int 268435456,268435456,268435456,268435456
        .int 268435456,268435456,268435456,268435456
        .int 268435456,268435456,268435456,268435456
        .int 268435456,268435456,268435456,268435456

longlista:  .int   (.-lista)/4

resultado:  .quad   0
formato:    .asciz  "suma = %lu = 0x%lx hex\n"

.section .text
.globl main

main:
    call trabajar
    call imprim_C
    ret

trabajar:
    mov $lista, %rbx
    mov longlista, %rcx
    call suma
    mov %rdi, resultado
    mov %rsi, resultado+4
    ret

suma:
    xor %rdi, %rdi    # Inicializar %rdi a 0 (para la parte baja de 64 bits)
    xor %rsi, %rsi    # Inicializar %rsi a 0 (para la parte alta de 64 bits)
    mov $0, %rcx

bucle:
    add (%rbx,%rcx,4), %edi  # Suma de 32 bits en %edi
    adc $0, %rsi            # Acarreo en %rsi

    inc %rcx
    cmp %rcx, %rdx
    jne bucle

    ret

imprim_C:
    mov $formato, %rdi
    mov resultado, %rsi
    mov resultado+4, %rdx
    xor %rax, %rax
    call printf
    ret

