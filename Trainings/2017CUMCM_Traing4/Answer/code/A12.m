%质量(kg)
mA = 105*1e-3*7;
mB = 1200;
mP = 10;
mD = 100;
mf = 1000;
%重力加速度
g = 9.8;
%重力
GB = mB*g;
GP = mP*g;
GD = mD*g;
Gf = mf*g;
GA = mA*g;
%锚链的密度 钢：7.85g/cm3?
pA = 7.85*10^3; 
%体积
Vf = 2*pi;
VA = mA/pA;
VP = pi*(1/2*50*1e-3)^2;
VD = pi*(1/2*30*1e-2)^2;
%海水密度
pw = 1.025*10^3;
%浮力
%ff = pw*g*Vf;
fA = pw*g*VA;
fP = pw*g*VP;
fD = pw*g*VD;
%直径
df = 2;
Lf = 2;
%长度
lA = 105*1e-3;
lP = 1;
lD = 1;
% for h = 0:0.1:2;
%Swind = df*(Lf-h);
%Swater = df*h;
v = 12;%风速
%u = 1 %水速
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
  h= 0.73072;
 %h= 0.7
 %h = 0.74432
     Swind = df*(Lf-h);
      ff = pw*g*h*pi;
     Pf = ff - Gf;
     Fwind = 0.625*Swind*(v^2);
     n= 147;
     %n = 210;
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
     RE = A1+D1+P1+1  %+6.51;
     
 xx = [lA*sin(atan(www1)) lD*sin(atan(www2)) lP*sin(atan(www3))];
 x =zeros(1,152);
 y = zeros(1,152);
 for i  =1:152
     x(153-i)=sum(xx((1:153-i)));
 end
     
     
 x = [0:0.105:(6.615-0.105) x+6.615];
 yy = [lA*cos(atan(www1)) lD*cos(atan(www2)) lP*cos(atan(www3))];
  for i  =1:152
     y(153-i)=sum(yy((1:153-i)));
 end
 y = [zeros(1,63) y];
 
 plot(x,y)
 %hold on 
 %plot()
 xx = [lA*sin(atan(www1))];
 yy = [lA*cos(atan(www1))];
  x =zeros(1,147);
 y = zeros(1,147);
 for i  =1:147
     x(148-i)=sum(xx((1:148-i)));
 end
   for i  =1:147
     y(148-i)=sum(yy((1:148-i)));
 end
 X =   [x+6.615];
 Y = [ y];
 [P,S] = polyfit(X,Y,5);
 [Y,DELTA] = polyval(P,X,S) ;
  X =   [0:0.105:(6.615-0.105) X];
 Y = [zeros(1,63) Y];
 figure
 plot(X,Y)
 
 
 
     








 
 
 
 

