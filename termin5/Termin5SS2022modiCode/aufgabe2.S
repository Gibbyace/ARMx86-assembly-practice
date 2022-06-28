// Name:		Matrikelnummer:
// Name:		Matrikelnummer:
// Datum:

	.file	"aufgabe2.S"
	.text			@ legt eine Textsection fuer PrgrammCode + Konstanten an
	.align	2		@ sorgt dafuer, dass nachfolgende Anweisungen auf einer durch 4 teilbaren Adresse liegen
				@ unteren 2 Bit sind 0
	.global	main		@ nimmt das Symbol main in die globale Sysmboltabelle auf
	.type	main,function
main:
	push	{lr}

	bl	up1
	bl	up2
	bl	up3
	
	pop		{pc}

// UP1 benutzt nur Scratchregister und stellt keine Blattroutine dar (ruft somit weitere
// Unterprogramme auf)	
up1:
	push	{r4, r5, r6, lr}
	mov	r4, #1
	mov	r5, #5
	sub	r6, r5, r4
	bl	up2
	pop	{r4, r5, r6, pc}

// UP2 benutzt nur Scratchregister und stellt eine Blattroutine dar (ruft somit keine weiteren
// Unterprogramme auf)
up2:
	mov	r0, #1
	mov	r1, #0
loop:	add	r1, r1, r0
	cmp	r1, #42
	bne	loop
	bx	lr

//UP3 benutzt Nicht-Scratchregister und stellt keine Blattlroutine dar
up3:
	push	{r4, r5, r6}
	mov	r4, #5
	mov	r5, #5
	add	r6, r4, r5
	
	pop	{r4, r5, r6}
	bx	lr

.Lfe1:
	.size	main,.Lfe1-main

// End of File
