.syntax unified
.cpu cortex-m4
.thumb

#define varA #30
#define varB #20
#define varC #5

// Global memory locations.
.global vtable_kernel
.global __kernel_reset__

.type vtable_kernel, %object
.type __kernel_reset__, %function

.section .interrupt_vector
vtable_kernel:
    .word __stack_start 
    .word __kernel_reset__+1
    .size vtable_kernel, .-vtable_kernel

.section .rodata
    data: .asciz "kernel started!\n"
    final: .asciz "Value in register #5: "

.section .text
__kernel_reset__:
    ldr r0, =data
    bl dbgput_line
    
    //calculate 
    mov r0, varA
    mov r1, varB
    mov r2, varC
        
    sub r5, r0, r1
    cmp r5, #0
    it ge
    addge r5, r0, r1
    sdiv r5, r2

    ldr r0, =final
    bl dbgput
    mov r0, r5
    bl dbgput_num
    
    end:
    b end
