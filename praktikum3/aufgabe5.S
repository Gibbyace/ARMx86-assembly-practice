// Name:		Matrikelnummer:
// Name:		Matrikelnummer:
// Datum:

	.file	"aufgabe5.S"
	.text		@ legt eine Textsection fuer PrgrammCode + Konstanten an
	.align	2	@ sorgt dafuer, dass nachfolgende Anweisungen auf einer durch 4 teilbaren Adresse liegen
			@ unteren 2 Bit sind 0
	.global	main	@ nimmt das Symbol main in die globale Sysmboltabelle auf
	.type	main,function
main:
	push	{r4, r5, r6, r7, lr}	@ Register retten
	mov	r4, #1
	mov	r5, #-1
	mov	r6, #15
	mov	r7, #0x80000000
	
					@ Multipliziere mit -1
	MOV	r8, r4			@ Bei MUL m�ssen ergebnisregister und erster
	MOV	r9, #-1			@ Operant verschieden sein, alle Operanten
	MUL	r4, r8, r9		@ m�ssen Register sein, keine #IMMIDIATE

	
	SUB	r5, r5, r5, LSL #1	@ ziehe das Doppelte der Zahl von sich ab
	
	RSB	r6, r6, #0		@ Ziehe die Zahl von 0 ab
	
	MVN	r7, r7			@ bilde das 1er Komplement
	ADDS	r7, #1			@ addiere 1 (also bilden des 2er Komplements)
					@ Die Zahl ist zu Gro� zum Anzeigen, daher Overflow-Flag
	
//..


	pop	{r4, r5, r6, r7, pc}	@ Register restaurieren und Rücksprung
.Lfe1:
	.size	main,.Lfe1-main

// End of File
