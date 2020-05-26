/* Villena, A. & Asenjo, R. & Corbera, F.
Practicas basadas en Raspberry Pi */

.data
seed: 		.word 	1
const1:		.word	1103515245
const2:		.word	12345
formato: .asciz "%d\n"
cont:		.word 0
numeros:	.word 0,0,0,0,0,0

.text
.global myrand, mysrand, anadir, validar, correcto, incorrecto

myrand:
	ldr r1, =seed	@puntero a semilla
	ldr r0, [r1]	@leer valor
	ldr r2, [r1,#4]	@leer const1
	mul r3, r0, r2	@r3=seed*1103515245
	ldr r0, [r1,#8]	@leer const2
	add r0, r0, r3	@r0=r3+12345
	str r0, [r1]	@guardo en variable seed
	lsl r0, #1	@devuelve seed>>16&0x7FFF
	lsr r0, #17
	mov pc, lr

mysrand:
	ldr r1, =seed
	str r0, [r1]
	mov pc, lr


anadir:
	and r1,r1,#9
	ldr r9, =cont
	ldr r10, =numeros
	ldr r9, [r9]
	add r10, r9
	str r1, [r10]
	add r9, #4
	ldr r0, =formato
	bl printf
	mov pc, lr
	
validar:
	mov r10,#0 @contador posicion
	mov r11,#0 @contador del ciclo
	mov r12,#0 @para colocar el numer oen el vector al final
	# mov r13,#0 @donde va a estar el numero si es valido
	mov r2,#0 @boolean para saber si es valido, 1 si es valido 0 no es valido y manda a buscar otro
	revision:
		ldr r6, =numeros
		add r6,r6,r11
		ldr r6, [r6]
		cmp r6, r1
		beq igual
		bne noigual
	igual:
		mov r2, #1
		mov r10, r11
	noigual:
		cmp r6, #0
		bne seguir
		beq agregar
		seguir:
			add r11, r11, #4
			cmp r11, #28
			bne revision
	agregar:
		ldr r7, =numeros
		add r7,r7,r11
		str r6, [r7]
		mov pc, lr


correcto:
		ldr r1, =correctov
		ldr r0, =string
		bl printf

incorrecto:
		ldr r1, =incorrectov
		ldr r0, =string
		bl printf		
	

	