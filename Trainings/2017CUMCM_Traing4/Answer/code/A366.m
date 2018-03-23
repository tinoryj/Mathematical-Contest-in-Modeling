

%����(kg)
mA = 105*1e-3*7;
mB = 1200;
mP = 10;
mD = 100;
mf = 1000;
%�������ٶ�
g = 9.8;
%����
GB = mB*g;
GP = mP*g;
GD = mD*g;
Gf = mf*g;
GA = mA*g;
%ê�����ܶ� �֣�7.85g/cm3?
pA = 7.85*10^3; 
%���
Vf = 2*pi;
VA = mA/pA;
VP = pi*(1/2*50*1e-3)^2;
VD = pi*(1/2*30*1e-2)^2;
%��ˮ�ܶ�
pw = 1.025*10^3;
%����
%ff = pw*g*Vf;
fA = pw*g*VA;
fP = pw*g*VP;
fD = pw*g*VD;
%ֱ��
df = 2;
Lf = 2;
%����
lA = 105*1e-3;
lP = 1;
lD = 1;
% for h = 0:0.1:2;
%Swind = df*(Lf-h);
%Swater = df*h;
v = 36;%����
%u = 1 %ˮ��
%Fwind = 0.625*Swind*v^2;
%Fwater = 374*Swater*u^2;
PA = fA - GA;
PP = fP - GP;
PD = fD - GD;
%Pf = ff - Gf;
PB = -GB;
Result = [];
A = [];
D = [];
P = [];
  %h = 0.743596;
  %h=0.743253;
  %h= 0.6765
 %h= 0.7
 flag = 0;
 FF = 0;
 for mB = 2090:1:2110
     GB = mB*g;
     PB = -GB;
     for h = 1.02:0.001:1.04
         %h = 0.76545
     Swind = df*(Lf-h);
      ff = pw*g*h*pi;
     Pf = ff - Gf;
     Fwind = 0.625*Swind*(v^2);
     %n= 147;
     n = 210;
     i = 1:n;
     AA=Fwind;
     BB=(n-i+1/2)*PA+PB+PD+4*PP+Pf;
     www1 = AA./BB;
     A =[A sum(lA*cos(atan(www1)))];
     A1 = sum(lA*sin(atan(www1)));
     BB = (1/2*PD+4*PP+Pf);
     www2 = AA./BB;
     D = [D lD*cos(atan(www2))];
     D1 = lD*sin(atan(www2));
     i = 1:4;
     BB = (PP*(4.5-i)+Pf);
     www3 = AA./BB;
     P = [P sum(lP*cos(atan(www3)))];
     P1 = sum(lP*sin(atan(www3)));
     Result = A+D+P+1/2*Lf;
     RE = A1+D1+P1+1;  %+6.51;
     if (((atan(www2))/pi*180<5) & ((atan(www1(1)))/pi*180>74))
         flag = 1;
         FF = [mB h (atan(www2))/pi*180 (atan(www1(1)))/pi*180 RE];
     end
     
     end
     if flag
         break
     end
 end
     
%  xx = [lA*sin(atan(www1)) lD*sin(atan(www2)) lP*sin(atan(www3))];
%  x =zeros(1,n+5);
%  y = zeros(1,n+5);
%  for i  =1:n+5
%      x(n+6-i)=sum(xx((1:n+6-i)));
%  end
%      
%      
% 
%  yy = [lA*cos(atan(www1)) lD*cos(atan(www2)) lP*cos(atan(www3))];
%   for i  =1:n+5
%      y(n+6-i)=sum(yy((1:n+6-i)));
%  end
% 
%  
%  plot(x,y)
% 
%  xx = [lA*sin(atan(www1))];
%  yy = [lA*cos(atan(www1))];
%   x =zeros(1,n);
%  y = zeros(1,n);
%  for i  =1:n
%      x(n+1-i)=sum(xx((1:n+1-i)));
%  end
%    for i  =1:n
%      y(n+1-i)=sum(yy((1:n+1-i)));
%  end
%  X =  x;
%  Y = y;
%  [P,S] = polyfit(X,Y,4);
%  [Y,DELTA] = polyval(P,X,S) ;
% 
%  %figure
%  plot(X,Y)
%  
%  
%  
%      








 
 
 
 
