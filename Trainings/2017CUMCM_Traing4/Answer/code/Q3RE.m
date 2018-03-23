
%每节锚链长度
L1 = 180*1e-3;
L2 = 28.12;
%RA = 105*1e-3*7;
%dA = 2*sqrt(7/ (7.85*10^3)/(105*1e-3)/pi);
mA = L1*L2;
dA = 2*sqrt(L2/ (7.85*10^3)/(L1)/pi);
%质量(kg)
%mA = 105*1e-3*7;
%mB = 2090;
mB = 8090;
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
%海水法平面面积
lP =1;
SP = lP*50*1e-3;
SD = 30*1e-2;

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
v = 36;%风速
u = 1.5; %水速
%u = 0;
%Fwind = 0.625*Swind*v^2;
%Fwater = 374*Swater*u^2;
FWP = 374*SP*u^2;
FWD = 374*SD*u^2;

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
 %for n = 150:1:250
 
   n=170;  
%      SA = 1/2*n*L1*dA;
%      Sf = df*h;
%      FWA = 374*SA*u^2;
%      FWf = 374*SP*u^2;
     %for h = 0:0.00001:2
     h=0.68;
       mB = 16000;
     GB = mB*g;
     PB = -GB;
           SA = 1/2*n*L1*dA;  %%注意注意！！
     Sf = df*h;
     FWA = 374*SA*u^2;
     FWf = 374*SP*u^2;
         %h = 0.76545
     Swind = df*(Lf-h);
      ff = pw*g*h*pi;
     Pf = ff - Gf;
     Fwind = 0.625*Swind*(v^2);
     %n= 147;
     %n = 210;
     i = 1:n;
     AA=(n-i+1/2)*FWA+FWD+4*FWP+FWf+Fwind;
     BB=(n-i+1/2)*PA+PB+PD+4*PP+Pf;
     www1 = abs(AA./BB);
     A = sum(lA*cos(atan(www1)));
     A1 = sum(lA*sin(atan(www1)));
     AA = (1/2*FWD+4*FWP+FWf)+Fwind;
     BB = (1/2*PD+4*PP+Pf);
     www2 = abs(AA./BB);
     D = lD*cos(atan(www2));
     D1 = lD*sin(atan(www2));
     i = 1:4;
     AA = (FWP*(4.5-i)+FWf)+Fwind;
     BB = (PP*(4.5-i)+Pf);
     www3 = abs(AA./BB);
     P = sum(lP*cos(atan(www3)));
     P1 = sum(lP*sin(atan(www3)));
     Result = A+D+P+1/2*Lf;
     RE = A1+D1+P1+1;  %+6.51;





 
 
 
 

