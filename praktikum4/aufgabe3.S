// Loesung zu Aufgaben 3 und folgende
// Name: 	 	Matrikelnummer: 
// Name: 		Matrikelnummer: 
// Datum:
	.file "aufgabe3.S"
	.text 		@ legt eine Textsection fuer PrgrammCode + Konstanten an
	.align 2 	@ sorgt dafuer, dass nachfolgende Anweisungen auf einer durch 4 teilbaren Adresse liegen	
			@ unteren 2 Bit sind 0
	.global main 	@ nimmt das Symbol main in die globale Sysmboltabelle auf
	.type main,function
main:
	push {lr} @ Ruecksprungadresse und Register sichern
	ldr 	R0, Adr_StringA
@	..
	bl	kopieren
@	..
@	bl 	reduzieren
@	..
	bl 	sortieren
	pop {pc}
	
kopieren:
@ hier Ihr Programm zum Kopieren eines String
	ldr	R1, =StringB
	mov	r2, r1
loop_kopieren:	
@	..
	
	LDRB	r3, [r0], #1
	STRB	r3, [r2], #1
	cmp 	r3, #0
	bne 	loop_kopieren
	bx lr


reduzieren:
@ hier Ihr Programm um alle Buchstaben (a..z; A..Z) zu entfernen
@	..	
	mov	r0, r1
	mov	r5, #0x41
	mov	r6, #0x5B
	b	inner_loop
loop_reduzieren:			@nimmt den nächsten zu überprüfenden character
	LDRB	r2, [r0, #1]!
	
	CMP	r2, #0
	BEQ	gros_klein
inner_loop:				@findet den nächsten zu entfernenden buchstaben (erst alle großen, dann alle kleinen)
	LDRB	r2, [r0]
	CMP	r2, r5
	BLT	loop_reduzieren
	CMP	r2, r6
	BGE	loop_reduzieren
	mov	r4, r0
aufruecken:				@entfernt den gefundenen buchstaben
	LDRB	r3, [r4, #1]
	STRB	r3, [r4], #1
	CMP	r3, #0
	BNE	aufruecken
	b	reduzieren
gros_klein:				@wechselt von groß- zu kleinbuchstaben
	CMP	r5, #0x41
	MOVEQ	r5, #0x61
	MOVEQ	r6, #0x7B
	MOVEQ	r0, r1
	BEQ	inner_loop
	bx	lr	
	
sortieren:
@ hier Ihr Programm zum sortieren 
@	..
	mov	r5, r1
	mov	r0, r5
finde_ende:
	LDRB	r2, [r0], #1	
	CMP	r2, #0
	BNE	finde_ende
	
	LDRB	r2, [r0, #-2]!		@r2 ist das ende vom string
	MOV	r3, r0			@adresse von ende in r3
	
	
sort_loop:
	CMP	r5, r3			@vergleicht Anfang des Strings mit dem Ende des zu sortierenden Bereichs
	BXEQ	lr			@wenn gleich -> fertig sortiert
	MOV	r0, r5
sort_inner_loop:	
	LDRB	r2, [r0]	
	LDRB	r4, [r0, #1]
	CMP	r4, r2			@wenn r4 < r2 -> vertauschen
	STRLTB	r2, [r0, #1]
	STRLTB	r4, [r0]
	ADD	r0, r0, #1
	CMP	r0, r3
	BNE	sort_inner_loop
	SUBEQ	r3, r3, #1		@ende des zu sortierenden Bereichs -1
	BEQ	sort_loop

Adr_StringA:	.word StringA 	@ auf dieser Speicherstelle liegt die Adresse,
				@ welche auf das erste Zeichen von StringA zeigt

.Lfe1:
	.size main,.Lfe1-main

// .data-Section fuer initialisierte Daten
	.data
StringA: .asciz "Dies ist eine EMAil-Adresse: Max_Mustermann@h-da.de !"

// .comm-Section fuer nicht initialisierte Daten
	.comm StringB, 256 	@ Speicherbereich mit der max. Groesse eines StringA reservieren

// End of File

