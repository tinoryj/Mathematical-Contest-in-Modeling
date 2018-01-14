function [ dataPre, epsilon ] = GM21( data )

n = length(data);
x1 = cumsum(data);
aData = diff(data);
aData = [0,aData];

for i = 2:n
    z(i) = 0.5 * (x1(i) + x1(i-1));
end

B = [-data(2:end)',-z(2:end)',ones(n-1,1)];
Y = aData(2:end)';
u = B\Y;

% data predict
%dataPre = [data(1) ones(1,n+preNum-1)];
%for k = 1 : (n - 1 + preNum)
%    dataPre(k+1) = (data(1)-b/a) * (exp(-a*k)-exp(-a*(k-1)));
%end



x = dsolve('D2x+a1*Dx+a2*x=b','x(0)=c1,x(5)=c2'); 
x = subs(x,{'a1','a2','b','c1','c2'},{u(1),u(2),u(3),x1(1),x1(6)}); 
yuce = subs(x,'t',0:n-1);
digits(6),x=vpa(x)
dataPre = [yuce(1),diff(yuce)]
epsilon = data - dataPre
delta = abs(epsilon./data)

end