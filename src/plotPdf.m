function retVal = plotPdf (xval, ref, solvedTrim, taylor, xmin, xmax, ymin, ymax)
	retVal = false;
	if ( isvector (xval) && isvector (ref) && isvector (solvedTrim) && isvector (taylor) )
		# settings
		papersize = [21, 29.7]/2.54; 
		figure (1, 'paperorientation', "landscape", 'papersize', papersize, 'paperposition', [0.25 0.25, papersize-0.5]);	
		hold on;		
		axis([xmin xmax ymin ymax]);
		grid;
		xlabel('Naeherungen');
		ylabel('y');
		title('Taylorpolynom vs. LGS-Gauss');
		# der eigentliche Plot
		plot (xval, ref, "g")
		plot (xval, polyval (solvedTrim, xval), "r")
		plot (xval, taylor, "b")
		hold off;
		print -dpdf -landscape ../doc/img/aufgabe5.pdf;
		# return (true)
		retVal = true;
	else
		printf ("Fehlerhafter Funktionsaufruf!\nSyntax: function (vector, vector, vector, vector, xmin, xmax, ymin, ymax)\n")
	endif
endfunction
