clear all;
clc;
format long;
N = 9;
xmin = 0;
xmax =  1;
xRange = [xmin:0.01:xmax];
# berechne die ursprüngliche Funktion
reference = zeros (1, N);
for n = 1:size(xRange, 2)
	reference(n) = 1/(1+xRange(n));
endfor
# Hilbert Matrix
for i = 0:N-1
	for j = 0:N-1
		A(i+1, j+1) = 1/(1 + i + j);
	endfor
endfor
# Lösungsvektor
b(1) = 0.69315;
for i = 1:N-1
	sum = 0;
	for j = 1:i
		sum = sum + ((-1)^j)/j;
	endfor
	 b(i+1) = (-1)^i * (0.69315 + sum);
endfor
# Tikhonov 
m = rows (A); n = columns (A);
[U, S, V] = svd (A)
V*S*U'
## determine the regularization factor alpha
alpha = 1/100;
delta = log(2)-0.69315;
p = 2;
do
	F = 0;
	alpha = alpha/p;
	for index = 1:N
		F = F + alpha^2/((alpha+(S(index,index))^2)^2)*(abs(dot(b,V(index))))^2;
	endfor
	F = F -delta^2
	alpha
until F < 0
## transform to orthogonal basis
b = U'*b';
## Use the standard formula, replacing A with S.
## S is diagonal, so the following will be very fast and accurate.
x = (S'*S + alpha^2 * eye (n)) \ (S' * b);
## transform to solution basis
x = V*x;
# Plot
figure;
hold on;
grid;
plot (xRange, reference', "g")
plot (xRange, polyval (x, xRange), "r")
hold off;