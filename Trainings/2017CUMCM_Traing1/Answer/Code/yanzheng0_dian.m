%第一种方案的畸变率计算
% viewTable1
%function [g1,g2,rrr]=mymethod1_jibianzuo(cutRatio,R2)
dis=10000;

R1 = 1260;
R2 = 1000;
length = 70.92*2.78;
width = 70*1.625;
cutRatio = 0.33;
theta = 90-17.6;
%calculate
theta = theta / 180 * pi;
%%R1 cal
lengthR1 = (length * (1 - cutRatio)) / 2;
beta1 = acos(lengthR1 / R1) + theta;
x1 =  sin(pi - beta1) * R1;
y1 = - cos(pi - beta1) * R1;
z1 = 0;
%%R2 cal
x2 = x1 - cos(2 * (pi / 2 - (beta1 - theta)) + beta1 - (pi / 2)) * (R1 - R2);
y2 = y1 + sin(2 * (pi / 2 - (beta1 - theta)) + beta1 - (pi / 2)) * (R1 - R2);
z2 = 0;

rr = length * cutRatio/2 ;


x0 = x1;
y0 = y1;  %球心位置
z0 = z1; 
R = R1;   %球的半径

syms x
syms z
%f = sqrt(R^2-(x-x0)^2-(z-z0)^2)+y0;  %圆球正半边

f = sqrt(0.042855*x^2+0.060253*z^2);  %圆球正半边
f1 = sqrt(rr^2-(x-x2)^2-(z-z2)^2)+y2;  
%ff = R^2-(x-x0)^2-(y-y0)^2;
%plot3(f)

fx = diff(f,x);
fz = diff(f,z);
fy = -1;
n0 = [fx/sqrt(fx^2+fy^2+fz^2),fy/sqrt(fx^2+fy^2+fz^2),fz/sqrt(fx^2+fy^2+fz^2)];

xx1 = -450;  %450人眼位置
yy1 = 730;  %730;
zz1 = 0;
a = [x-xx1,f-yy1,z-zz1];  %入射光线
d = sqrt(a(1)^2+a(2)^2+a(3)^2);
a = a/d;
b = a - 2.*(a.*n0).*n0; %反射光线



[X,Z] = meshgrid(3,0);  %在球上均匀取点

%面上面积
S1 = length*width/2;
X=X(:);
Z=Z(:);
X =X*cos(pi/2-theta);

Xa = X;
Za = Z;
Ya = subs(f,{x,z},{[Xa],[Za]});   


ba= subs(b,{x,f,z},{[Xa],[Ya],[Za]});
ba=double(ba);
Yy = dis; %10米外的屏
Xxa = (Yy-Ya)./ba(:,2).*ba(:,1)+Xa;
Zza = (Yy-Ya)./ba(:,2).*ba(:,3)+Za;





Xx = Xxa;
Zz = Zza;


Xx = double(Xx);
Zz = double(Zz);




Xx


    




