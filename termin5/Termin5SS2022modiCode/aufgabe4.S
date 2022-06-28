// Name:		Matrikelnummer:
// Name:		Matrikelnummer:
// Datum:

	.file	"aufgabe4.S"
	.text			@ legt eine Textsection fuer PrgrammCode + Konstanten an
	.align	2		@ sorgt dafuer, dass nachfolgende Anweisungen auf einer durch 4 teilbaren Adresse liegen
				@ unteren 2 Bit sind 0
	.global	main		@ nimmt das Symbol main in die globale Sysmboltabelle auf
	.type	main,function
main:
	push	{r4, r5, r6}
	LDR	r4, =Total
	LDR	r0, [r4]
	LDR	r5, =Table
	LDR	r6, =Count
	LDR	r1, [r6]
	
Loop:	LDR	r2, [r5], #4
	ADD	r0, r0, r2
	SUB	r1, r1, #1
	CMP	r1, #0
	BGT	Loop
	pop	{r4, r5, r6}
	bx	lr

.Lfe1:
	.size	main,.Lfe1-main

	.data
//; Data definitions
//Total 	DEFW 0 ; Total - initially zero
Total:	.word	0
//One 	DEFW 1 ; The number one
//Count 	DEFW 4 ; Loop counter (loop 5x)
Count:	.word	5
//Table 	DEFW 39 ; The numbers to total ...
//	DEFW 25 ;
//	DEFW 4 ;
//	DEFW 98 ;
//	DEFW 17 ;
Table:	.word	39, 25, 4, 98, 17

	

// End of File

