// Loesung Termin6 Rechnerarchitektur WS2020/21
// Name: 	Matrikelnummer:
// Name: 	Matrikelnummer:
// Datum:

@ in R0 wird die Adresse des zu durchsuchenden Text erwartet.
@ in R1 wird die Adresse des zu suchendenn Text erwartet.
@ sollte R0 auf einen leeren String zeigen,
@ oder der gesuchte Text nicht gefunden werden,
@ so wird in R0 der Wert 0 zurueck geliefert.
@ zeigt R1 auf einen leeren String so wird in R0 der Wert 0 zurueck gegeben
 
	.file	"searchStringInString.S"
	.text
	.align	2
	.global	searchStringInString
	.type	searchStringInString, %function
	
searchStringInString:
	push	{r4, lr}			
	ldrb	r4, [r1]			//ist der zu suchende string 0?
	cmp 	r4, #0
	bleq	getLengthOfString		//Wenn 0, dann return länge von zu durchsuchende string 
	popeq	{r4, pc}			
	ldrb	r4, [r0]			//Ist der zu durchsuchende string 0?
	cmp	r4, #0
	moveq	r0, #0				//return 0
	popeq	{r4, pc}	
	bl	getNumberOfOccurences		//sonst finde vorkomnisse von zu suchende string
	mov	r0, r2				//vorkomnisse in r0 speichern
	pop	{r4, pc}			//cleanup 
	

getLengthOfString:
	push	{r4, r5, r6}			//save von non scratch register
	mov	r4, #0				// lade 0
	mov	r5, r0				// zu durchsuchende string in r5
find_end:
	ldrb	r6, [r5], #1			//ist character 0?
	cmp	r6, #0				//wenn das so
	addne	r4, r4, #1			// wenn !=0 sonst länge +1	 
	bne	find_end			//und weiter itterieren		
	mov	r0, r4				//wenn 0, dann länge in r0 laden
	pop	{r4, r5, r6}			//und return 
	bx	lr				//return 

getNumberOfOccurences:
	push	{r4, r5, r6, r7, r8, lr}	
	mov	r2, #0				//lade vorkomnisse in 0 in r2
	mov	r4, r0				//vorkomnisse in r4
	
forEach:
	mov	r5, r1				//von scratch zu non scratch		
	mov	r6, r4				//hole adresse von ersten char aus zu durchsuchende string
	add	r4, r4, #1			//gehe in string 1 weiter 
checkForEqual:
	ldrb	r7, [r6], #1			//lade aktuellen charackter aus zu DS
	ldrb	r8, [r5], #1			//lade aktuellen charackter aus ZSS
	cmp	r8, #0				//wenn 0; dann fertig
	addeq	r2, r2, #1			//vorkomnisse ++
	beq	forEach				//gehe zu nächsten character von zu DS
	cmp	r7, #0				//Schaue ob zu DS zu ende ist
	popeq	{r4, r5, r6, r7, r8, pc}	//alle vorkomnisse gefunden 
	cmp	r7, r8				
	beq	checkForEqual			//vergleiche wenn gleich, dann checkforEqual 
	b	forEach
	

	
	.size	searchStringInString, .-searchStringInString

