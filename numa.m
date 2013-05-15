function retVal = numa (N, fileIdData, fileIdTask3)
	retVal = false;			# default Zuweisung
	
	if (isnumeric (N) && is_valid_file_id (fileIdData) && is_valid_file_id (fileIdTask3))
		clc;
		N--;
		#
		# Zähler und Nenner der gegebenen Funktion
		#
		numerator = [1];
		denominator = [1, 1];
		#
		# Erzeugen der Matrix
		#
		for i = 0:N
			for j = 0:N
				H(i+1, j+1) = 1/(1 + i + j);
			endfor
		endfor
		#
		# Anlegen des Lösungsvektors
		#
		R(1) = log(2);		# r0 ist gleich ln2
		for i = 1:N
			sum = 0;
			for j = 1:i
				sum = sum + ((-1)^j)/j;
			endfor
			 R(i+1) = (-1)^i * (log(2) + sum);
		endfor
		#
		# Lösen des LGS
		#
		solved = H\R'
		#
		# Ausgabe
		#
		printf ("Matrix 'H' %ix%i:\n" ,N+1 ,N+1)
		disp (H)
		commentLine = strcat ("#\n# 'H' Matrix-",  num2str (N+1), "x",  num2str (N+1), "\n#");
		fdisp (fileIdData, commentLine);
		fdisp (fileIdData, H);
		printf ("zugehöriger Lösungsvektor 'r':\n")
		disp (R)
		commentLine = "#\n# 'R' Lösungsvektor\n#";
		fdisp (fileIdData, commentLine);
		fdisp (fileIdData, R);
		commentLine = "#\n# Lösung des LGS\n#";
		fdisp (fileIdData, commentLine);
		fdisp (fileIdData, solved');
		printf ("Eigenwerte:\n")
		lambda = eig (H);
		disp (lambda)
		commentLine = strcat ("#\n# Eigenwerte der Matrizze 'H' -",  num2str (N+1), "x",  num2str (N+1), "\n#");
		fdisp (fileIdTask3, commentLine);
		fdisp (fileIdTask3, lambda');		# lambda ist transponiert, um besser lesbar in eine Datei zu schreiben
		printf ("Kondition:\n")
		cond = cond (H);
		disp (cond)
		commentLine = "#\n# Kondition\n#";
		fdisp (fileIdTask3, commentLine);
		fdisp (fileIdTask3, cond);		
		printf ("\n")
		#
		# Return bool 'true'
		#
		retVal = true;
	else
		printf ("Fehlerhafter Funktionsaufruf!\nSyntax: function (numericValue, fileId, fileId)\n")		
	endif
endfunction