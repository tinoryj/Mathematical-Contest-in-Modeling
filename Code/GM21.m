function [yuce, epsilon, delta] = GM21( data )
% yuce -> predict ans
% epsilon -> abs err
% delta -> err
x0 = data;
n = length(x0);
x1 = cumsum(x0)
a_x0 = diff(x0);
a_x0 = [0,a_x0]
for i=2:n
   z(i)=0.5*(x1(i)+x1(i-1));
end
B = [-x0(2:end)',-z(2:end)',ones(n-1,1)];
Y = a_x0(2:end)';
u = B\Y;
x = dsolve('D2x+a1*Dx+a2*x=b','x(0)=c1,x(n-1)=c2'); 
x = subs(x,{'a1','a2','b','c1','c2'},{u(1),u(2),u(3),x1(1),x1(n)}); 
yuce = subs(x,'t',0:n-1);
digits(n);
x = vpa(x);
x0_hat = [yuce(1),diff(yuce)];
epsilon = x0-x0_hat;
delta = abs(epsilon./x0);

end