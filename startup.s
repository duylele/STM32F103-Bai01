.syntax unified
.cpu cortex-m3
.thumb

.global _estack
.global Reset_Handler

.extern main
.extern SysTick_Handler


.section .isr_vector, "a", %progbits

.word _estack
.word Reset_Handler

.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0

/* SysTick */
.word SysTick_Handler


.section .text.Reset_Handler
.type Reset_Handler, %function

Reset_Handler:

    bl main

Loop:
    b Loop
