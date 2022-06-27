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





	
	.size	searchStringInString, .-searchStringInString

