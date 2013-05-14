# Konstannten
N = 5;
#
# Zähler und Nenner der gegebenen Funktion
numerator = [1];
denominator = [1, 1];
#
# Erzeugen der Matrix
for i = 0:N
  for j = 0:N
    H(i+1, j+1) = 1/(1 + i + j);
  endfor
endfor
#
# Anlegen des Lösungsvektors
R(1) = log(2);
# r0 ist gleich ln2
for i = 1:N
  sum = 0;
  for j = 1:i
    sum = sum + ((-1)^j)/j;
  endfor
   R(i+1) = (-1)^i * (log(2) + sum);
endfor
#
# Ausgabe
printf ("Matrix 'H':\n")
disp (H)
printf ("zugehöriger Lösungsvektor 'r':\n")
disp (R)
printf ("Eigenwerte:\n")
lambda = eig (H);
disp (lambda)
printf ("Kondition:\n")
cond = cond (H);
disp (cond)
