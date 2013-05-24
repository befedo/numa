#
# Öffnen der Datei und merken der File-Id, um später in Sie zu schreiben.
# ACHTUNG! Wird 'fopen' mit dem Parameter 'w' aufgerufen, so werden existente
# Dateien überschrieben. 
#
fileIdData = fopen ('data', 'w');
fileIdTask3 = fopen ('aufgabe3', 'w');
#
# Iterationen um 3x3 bis 10x10 Matrizzen zu berechnen
#
for i = 10:10
	if (!numa (i, fileIdData, fileIdTask3))
		break;
	endif
endfor
# Schließen der Dateien
fclose (fileIdData);
fclose (fileIdTask3);