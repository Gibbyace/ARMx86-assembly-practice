// C-Programm um die in Assembler geschriebene Funktion zu testen.
// Das Programm kann/sollte für weitere Tests erweitert werden.
// von: Manfred
// vom: 16.02.2011 geaendert 25.01.2021
//
int searchStringInString(char*, char*);

int main (void)
{
	int Anzahl;
	char* Text="hallo Alles klar?";
	char* Suchstring="ll";
	char* Leerstring="";
	char* Text2="aaaaa";
	char* Suchstring2="aaa";
	
	Anzahl = searchStringInString(Text, Suchstring);
	Anzahl = searchStringInString(Text, Leerstring);	
	Anzahl = searchStringInString(Leerstring, Suchstring);
	Anzahl = searchStringInString(Leerstring, Leerstring);
// Aufrufe funktionieren auch so..
	Anzahl = searchStringInString("aabaabaab", "ab");
	Anzahl = searchStringInString(Text2, Suchstring2);
	
	return 0;
}
