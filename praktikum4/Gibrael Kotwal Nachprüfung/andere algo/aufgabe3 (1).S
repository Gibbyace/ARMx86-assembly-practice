// Loesung zu Aufgaben 3 und folgende
// Name: Moritz reinhardt		Matrikelnummer: 
// Name: Semih Bozok		Matrikelnummer: 1112213 
// Datum:
	.file "aufgabe3.S"
	.text 		@ legt eine Textsection fuer PrgrammCode + Konstanten an
	.align 2 	@ sorgt dafuer, dass nachfolgende Anweisungen auf einer durch 4 teilbaren Adresse liegen	
			@ unteren 2 Bit sind 0
	.global main 	@ nimmt das Symbol main in die globale Sysmboltabelle auf
	.type main,function
main:
	push {lr} @ Ruecksprungadresse und Register sichern
	
	@ kopieren
	ldr 	R0, Adr_StringA	@ Adresse von StringA laden
	ldr 	R1, =StringB	@ Adresse von StringB laden
	bl 	kopieren		@ Kopierroutine aufrufen
	
	
	ldr 	R0, Adr_StringA	@ Register wieder auf Anfang von StringA setzen
	ldr 	R1, =StringB	@ Register wieder auf Anfang von StringB setzen
	ldr	R3, =StringC	@ Adresse von StringC laden (reduzierter String)
	bl 	loop_reduzieren	@ Reduzierroutine aufrufen



	ldr 	R1, =StringB	@ Register wieder auf Anfang von StringB setzen
	ldr 	R3, =StringC	@ Register wieder auf Anfang von StringB setzen
	bl	laenge_berechnen


	bl 	sortieren
	pop {pc}
	
	
	
kopieren:

loop_kopieren:
	LDRB	R5, [R0], #1	@ Quellbyte laden und Quelladresse inkrementieren
	STRB	R5, [R1], #1	@ Byte speichern und Zieladresse inkrementieren
	CMP 	R5, #0
	BNE	loop_kopieren
	bx lr
	
	
loop_reduzieren:

	MOV	R4, #0		@ Pruefbedingung: < 2: Buchstabe; 2: kein Buchstabe
	LDRB	R5, [R1], #1	@ Zeichen laden
	CMP	R5, #0		@ Falls Terminierungszeichen: Abbruch
	STREQB	R5, [R3]
	BXEQ	lr
				
	CMP	R5, #65		@ Wenn kleiner als 'A': continue
	BLT	loop_reduzieren
	
	CMP	R5, #122	@ Wenn groesserer als 'z': continue
	BGT	loop_reduzieren
	
	CMP	R5, #90		
	ADDGT	R4, #1
	
	CMP	R5, #97
	ADDLT	R4, #1
	
	CMP	R4, #2		@ Wenn zwischen Klein- und Grossbuchstaben: �berspringen, sonst kopieren
	STRNEB	R5, [R3], #1		
	
	B	loop_reduzieren
	

	
laenge_berechnen:
	mov	r4, #0		@ Laenge auf 0 initialisieren
	mov	ip, #0		@ ip speichert Position im String
loop_laenge:
	ldrb	r5, [r3, ip]	@ erstes Zeichen laden
	add	ip, ip, #1
	cmp	r5, #0		@ Pr�fen, ob Terminierungszeichen
	addne	r4, #1		@ Counter inkrementieren
	bne	loop_laenge
	bx lr	
	
sortieren:


init_iteration:			@ R3 zeigt auf String, R4 beinhaltet Laenge
	mov	ip, #0		@ ip speichert index des aktuellen Elements
	mov	r7, #0		@ r7 speichert Anzahl an Vertauschungen (wichtig f�r Abbruchbedingung)	

loop_bubblesort:
	add	r9, ip, #1	@ r9 speichert index des folgenden Elements
	cmp	r9, r4		@ Pruefen ob Folgeelement das Ende ist
	bge	abbruch_pruefen
	ldrb	r5, [r3, ip]	@ aktuelles Element wird in r5 gespeichert
	ldrb	r6, [r3, r9]	@ Folgeelement in r6 speichern
	cmp	r5, r6
	strgtb	r5, [r3, r9]	@ Falls r5 > r6: speichere aktuelles Element an Index des Folgeelements
	strgtb	r6, [r3, ip]	@ Falls r5 > r6: speichere Folgeelement an Index des aktuellen Elements
	addgt	r7, r7, #1	@ Es gab eine Vertauschung: update Counter
	mov	ip, r9		@ ip zeigt nun auf Folgeindex // entspricht add ip, ip, #1
	b	loop_bubblesort
	
abbruch_pruefen:
	cmp	r7, #0		@ Pruefen ob es Vertauschungen gab
	bgt	init_iteration 	@ falls es Vertauschungen gab: weitere Iteration
	bx	lr		@ falls keine Vertauschungen: Abbruch	
	
	

Adr_StringA:	.word StringA 	@ auf dieser Speicherstelle liegt die Adresse,
				@ welche auf das erste Zeichen von StringA zeigt

.Lfe1:
	.size main,.Lfe1-main

// .data-Section fuer initialisierte Daten
	.data
StringA: .asciz	"Dies ist eine EMAil-Adresse: nicklas.scherm@h-da.de !"

// .comm-Section fuer nicht initialisierte Daten
	.comm StringB, 256 	@ Speicherbereich mit der max. Groesse eines StringA reservieren
	.comm StringC, 256	@ Speicheradresse f�r den reduzierten String

// End of File

