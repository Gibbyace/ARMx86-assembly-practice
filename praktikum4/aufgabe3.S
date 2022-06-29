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
	ldr 	R0, Adr_StringA				//lade r0 mit adresse von StringA
@	..
	bl	kopieren
@	..
	bl 	reduzieren
@	..
	bl 	sortieren
	pop {pc}
	
kopieren:
@ hier Ihr Programm zum Kopieren eines String
	ldr	R1, = StringB				// lade r1 mit adresse von stringB	initialisierung von stringB	
	mov	r2, r1					// kopiere r1 in r2 //in r1 ist anfang von string, kein laden
loop_kopieren:	
@	..
	
	LDRB	r3, [r0], #1				// lade adresseninhalt von r0 in r3 und speichere die adresse von 1 byte weiter in r0
	STRB	r3, [r2], #1				// speichere wert von r3 auf adresse in r2 und speichere adresse von 1 byte weiter in r2
	cmp 	r3, #0					// vergleiche wenn inhalt von r3 = 0 (endcondition), sonst skip 
	bne 	loop_kopieren				// wenn char / wert ungleich 0 (endcondition), dann kopiere weiter
	bx lr						// jump in nächstes unterprogramm reduzieren, wenn vorherige conditon nicht ausgeführt wird


reduzieren:
@ hier Ihr Programm um alle Buchstaben (a..z; A..Z) zu entfernen
@	..	
	mov	r0, r1					// kopiere inhalt von r1 in r0 (kopierte Stringb in r0)
	mov	r5, #0x41				// kopiere asci wert von A (dez 64)
	mov	r6, #0x5B				// kopiere asci wert von [ (dez 91)
	b	inner_loop				// sprung zur inneren loop 

loop_reduzieren:			@nimmt den nächsten zu überprüfenden character
	LDRB	r2, [r0, #1]!				// lade byteweise inhalt von r0 + 1byte weiter in r2 und schreibe 1 byte weitere adresse in r0
	
	CMP	r2, #0					// vergleiche ob r2 = 0, end 

	BEQ	gros_klein				// wenn gleich, springe zu gros_klein

inner_loop:				@findet den nächsten zu entfernenden buchstaben (erst alle großen, dann alle kleinen)

	LDRB	r2, [r0]				// lade inhalt an adresse in r0 in r2 
	CMP	r2, r5					// vergleiche ob r2 = Acii A
	BLT	loop_reduzieren				// sonst branch with link to loop_reduzieren
	
	CMP	r2, r6					// <= ascii [ 

	BGE	loop_reduzieren				// if greater equal loop_reduzieren

	mov	r4, r0					// geht zurück zu anfang zu stringB (String B ist eine liste an adressen)

aufruecken:				@entfernt den gefundenen buchstaben

	LDRB	r3, [r4, #1]				// lade aus adresse in r4+1 byte weiter in r3
	STRB	r3, [r4], #1				// speichere wert von r3 in adresse in r4 und gehe einen byte weiter in memory und speichere das in r4
	CMP	r3, #0					// vergleiche ob null (endconditon)
	BNE	aufruecken				// wenn gleich, starte unterprogramm aufrücken
	b	reduzieren				// sonst reduzieren

gros_klein:				@wechselt von groß- zu kleinbuchstaben
					// noch eine loop zum vergleichen von kleinen buchstaben

	CMP	r5, #0x41		// Ist gleich !?		 
	MOVEQ	r5, #0x61		// ist gleich a? lade in r5
	MOVEQ	r6, #0x7B		// ist gleich [? lade in r6
	MOVEQ	r0, r1			// lade zeichen in r0; lade in r0
	BEQ	inner_loop		// Wenn gleich, inner loop
	bx	lr			// rücksprung wenn fertig mit loop 
	
sortieren:
@ hier Ihr Programm zum sortieren 
@	..			
	mov	r0, r1			//lade erstes zeichen in r0;
finde_ende:
	LDRB	r2, [r0], #1		//}
	CMP	r2, #0			//}
	BNE	finde_ende		// gehe durch liste bis ende gefunden wurde
	
	LDRB	r2, [r0, #-2]!		@r2 ist das ende vom string // -2 weil wir schauen und immer das nächste an, nach Null kommt nochmal null also muss man 2 zurück
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

// .comm-Section fuer nicht initialisierte Daten !!! Deswegen (=) zugreifen! alternative ist referenz auf die adresse // register wo adresse von speicher drinne ist
	.comm StringB, 256 	@ Speicherbereich mit der max. Groesse eines StringA reservieren

// End of File

