
a=0.5;
for N=3:10

  b = zeros (1, 10);
  for i=1:N
    f(i)=(-1)^(i-1)*factorial(i-1)/(1+a)^i;
  end

  b=zeros(N,1);
  for i=1:N
    for k=1:i
    b(k) += nchoosek(i-1,k-1)*(-a)^(i-k)*f(i)/factorial(i-1);
    end
  end
  k=b';
  save -append taylor k
end
x=[0:0.01:1];

y=polyval(flipud(b),x);

ref = zeros (1, N);
for n = 1:size (x, 2)
  ref(n) = 1/(1+x(n));
end

%figure;
%hold on;
%plot(x,ref,'g');
%plot(x,y,'r');
%hold off;

