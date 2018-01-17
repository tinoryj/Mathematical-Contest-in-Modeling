function [dataPre, epsilon, delta] = GM0N(x10, x20)
% GM(0,N) model -> example by GM(0,2)
% dataPre -> predict ans
% epsilon -> abs err
% delta -> err

n = length(x10);
x11 = cumsum(x10);
x21 = cumsum(x20);
for i = 2:n
    z11(i) = 0.5*(x11(i)+x11(i-1));
end

B = [-z11(2:n)',x21(2:n)'];
Y = x10(2:n)';
u = B\Y;
x = dsolve('Dx+a*x=b*x2','x(0)=x0');
x = subs(x,{'a','b','x0','x2'},{u(1),u(2),x10(1),'x21'});
digits(n),x = vpa(x);
x = simple(x);
x = subs(x,{'t','x21'},{[0:n-1],x21(1:n)});
xhat = [x(1),diff(x)];
dataPre = xhat;
epsilon = x10-xhat;
delta = abs(epsilon./x10);
end

