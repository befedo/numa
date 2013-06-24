clear all;
clc;
N = 7;
xmin = 0;
xmax =  1;
xRange = [xmin:0.01:xmax];
# berechne die ursprüngliche Funktion
reference = zeros (1, N);
for n = 1:size(xRange, 2)
	reference(n) = 1/(1+xRange(n));
end;
# Hilbert Matrix
for i = 0:N-1
	for j = 0:N-1
		A(i+1, j+1) = 1/(1 + i + j);
	end;
end;
# Lösungsvektor
b(1) = 0.69315;
for i = 1:N-1
	sum = 0;
	for j = 1:i
		sum = sum + ((-1)^j)/j;
	end;
	 b(i+1) = (-1)^i * (0.69315 + sum);
end;
# Singulärwertzerlegung
m = rows (A); n = columns (A);
[U, S, V] = svd (A);
# Berechnung des Regularisierungsparameters alpha
alpha = 1/100;
delta = log(2)-0.69315;
p = 1.01;
do
	F = 0;
	alpha = alpha/p;
	for index = 1:N
		F = F + alpha^2/((alpha+(S(index,index))^2)^2)*(abs(dot(b,V(:,index))))^2;
	end;
	F = F -delta^2;
until F < 0
F
alpha
# Thikonov decomposition mit neu gewähltem alpha
sum=0;
alpha=1e-10; # Parameter angepaßt, um Oszillationen zu reduzieren
for j=1:N
  sum= sum.+S(j,j)/(alpha+S(j,j)^2)*dot(b,V(:,j))*U(:,j);
end;
x=flipud(sum)
# Plot
figure;
hold on;
grid;
plot (xRange, polyval (x, xRange), "r")
plot (xRange, reference', "g")
hold off;