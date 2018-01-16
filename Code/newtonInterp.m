function[y,R,A,C,L] = newtonInterp(X,Y,x,M)  
% X: n+1个节点(x_i,y_i)(i = 1,2, ... , n+1)横坐标向量
% Y: 纵坐标向量  
% x: 以向量形式输入的m个插值点，M在[a,b]上满足｜f~(n+1)(x)｜≤M  
%   注：f~(n+1)(x)表示f(x)的n+1阶导数  
% y: 向量x处的插值，误差限R，n次牛顿插值多项式L及其系数向量C，  
% 差商的矩阵A  

n = length(X);  
m = length(x);  

for t = 1 : m  
    z = x(t);  
    A = zeros(n,n);  
    A(:,1) = Y';  
    s = 0.0; 
    p = 1.0; 
    q1 = 1.0; 
    c1 = 1.0;  
    for j = 2 : n  
        for i = j : n  
            A(i,j) = (A(i,j-1) - A(i-1,j-1))/(X(i)-X(i-j+1));  
        end  
        q1 = abs(q1*(z-X(j-1)));  
        c1 = c1 * j;  
    end  
    C = A(n, n); q1 = abs(q1*(z-X(n)));  
    for k = (n-1):-1:1  
        C = conv(C, poly(X(k)));  
        d = length(C);  
        C(d) = C(d) + A(k,k);%在最后一维，也就是常数项加上新的差商  
    end  
    y(t) = polyval(C,z);  
    R(t) = M * q1 / c1;  
end  
L = poly2sym(C);  
end