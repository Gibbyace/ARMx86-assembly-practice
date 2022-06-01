// Name:		Matrikelnummer:
// Name:		Matrikelnummer:
// Datum:

	.file	"aufgabe2.S"
	.text		@ legt eine Textsection fuer PrgrammCode + Konstanten an
	.align	2	@ sorgt dafuer, dass nachfolgende Anweisungen auf einer durch 4 teilbaren Adresse liegen
			@ unteren 2 Bit sind 0
	.global	main	@ nimmt das Symbol main in die globale Sysmboltabelle auf
	.type	main,function
main:
	MOV	R1, #0x00000001
	MOV	R2, #0x80000000
	ADDS	r0, r1, r2	@ setzt nur das Vorzeichenflag
	
	MOV	R1, #0x1
	SUBS	R0, R1, #2	@ setzt nur das Vorzeichenflag
	
	MOV	R1, #0x0
	LSRS	R0, R1, #0	@ setzt nur das Nullflag
	
	MOV	R1, #0x7FFFFFFF
	MOV	R2, #0xFFFFFFFF
	ADDS	R0, R1, R2	@ setzt nur das Carryflag
	
	MOV	R1, #0x7FFFFFFF
	MOV	R2, #0x1
	ADDS	r0, r1, r2	@ setzt Vorzeichen- und Overflowflag
	LSRS	r0, r0, #1	@ setzt das Vorzeichenflag auf 0
@ weitere Loesungen	



	bx	lr
.Lfe1:
	.size	main,.Lfe1-main

// End of File
