function retVal = numa (N, fileIdData, fileIdTask3)
	retVal = false;			# default Zuweisung
	
	if (isnumeric (N) && is_valid_file_id (fileIdData) && is_valid_file_id (fileIdTask3))
		N--;
		taylorsize = 10;		# Länge des Taylor Polynoms
		entwPkt = 0.5;			# und dessen Entwicklungspunkt
		xmin = -0.5;
		xmax =  1.5;
		xval = [xmin:0.01:xmax];
		ymin = 0;
		ymax = 2;
		#
		# Erzeugen der Matrix
		#
		for i = 0:N
			for j = 0:N
				H(i+1, j+1) = 1/(1 + i + j);
			endfor
		endfor
		# Anlegen des Lösungsvektors
		R(1) = log(2);		# r0 ist gleich ln2
		for i = 1:N
			sum = 0;
			for j = 1:i
				sum = sum + ((-1)^j)/j;
			endfor
			 R(i+1) = (-1)^i * (log(2) + sum);
		endfor
		# Lösungsvektor mit 5-Stelliger genauigkeit		
		Rtrim(1) = 0.69315;
		for i = 1:N
			sum = 0;
			for j = 1:i
				sum = sum + ((-1)^j)/j;
			endfor
			 Rtrim(i+1) = (-1)^i * (0.69315 + sum);
		endfor
		#
		# Lösen des LGS
		#
		solved = H\R';
		printf("--------------------------------------------------------------------------------\n");
		printf("--                                 N = %2d                                     --\n", N+1);
		printf("--------------------------------------------------------------------------------\n");
		printf("Lösungsvector mit voller Genauigkeit :\n");
		disp(solved')
		#		
		printf("\nLösungsvector mit 5 stelliger Genauigkeit :\n");		
		solvedTrim = gaussElim (H, Rtrim);
		disp(solvedTrim')
		#
		# Ausgabe
		#
		printf ("\nMatrix 'H' %ix%i:\n" ,N+1 ,N+1)
		disp (H)
		commentLine = strcat ("#\n# 'H' Matrix-",  num2str (N+1), "x",  num2str (N+1), "\n\n#");
		fdisp (fileIdData, commentLine);
		fdisp (fileIdData, H);
		printf ("\nzugehörige Lösungsvektoren 'r' und 'rTrim':\n")
		format long;				# größeres Anzeigeformat
		disp (R)
		disp (Rtrim)
		format short;				# normales Anzeigeformat
		commentLine = "#\n# 'R' Lösungsvektor\n#";
		fdisp (fileIdData, commentLine);
		fdisp (fileIdData, R);
		commentLine = "#\n# Lösung des LGS\n#";
		fdisp (fileIdData, commentLine);
		fdisp (fileIdData, solved');
		printf ("\nEigenwerte:\n")
		lambda = eig (H);
		disp (lambda)
		commentLine = strcat ("#\n# Eigenwerte der Matrizze 'H' -",  num2str (N+1), "x",  num2str (N+1), "\n#");
		fdisp (fileIdTask3, commentLine);
		fdisp (fileIdTask3, lambda');		# lambda ist transponiert, um besser lesbar in eine Datei zu schreiben
		printf ("\nKondition:\n")
		cond = cond (H);
		disp (cond)
		commentLine = "#\n# Kondition\n#";
		fdisp (fileIdTask3, commentLine);
		fdisp (fileIdTask3, cond);		
		printf ("\n")
		#
		# Berechnen des Taylorpolynoms
		#		
		taylor = zeros (1, size (xval, 2));
		for i = 1:size (xval, 2)
			for n = 0:taylorsize
				taylor(i) += (-1)^n * ( (xval(i)-entwPkt)^n / ((1+entwPkt)^(n+1)) );
			endfor
		endfor
		solved = solved(end:-1:1);	# Potenzen umsortieren
		solvedTrim = solvedTrim(end:-1:1);
		# berechne die ursprüngliche Funktion
		ref = zeros (1, N);
		for n = 1:size (xval, 2)
			ref(n) = 1/(1+xval(n));
		endfor
		#
		# Plot des Polynoms
		#
		printf("Zum Anzeigen des Plots Taste drücken...");
		pause;
		plotPdf (xval, ref, solvedTrim, taylor, xmin, xmax, ymin, ymax);	# Aufruf des externen Plot Scripts
		printf("\nZum Fortfahren Taste drücken...");
		#
		# Return bool 'true'
		#
		retVal = true;
	else
		printf ("Fehlerhafter Funktionsaufruf!\nSyntax: function (numericValue, fileId, fileId)\n")		
	endif
endfunction