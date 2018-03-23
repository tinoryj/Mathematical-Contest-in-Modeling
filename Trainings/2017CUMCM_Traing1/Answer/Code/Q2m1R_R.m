%第一种方案的占镜比例与距离(右外后视镜,分割线以右)
%第一种方案的畸变率计算
% viewTable1
%function [g1,g2,rrr]=mymethod1_jibianzuo(cutRatio,R2)
dis=8000;

R1 = 1260;
R2 = 500;
length = 70.92*2.78;
width = 70*1.625;
cutRatio = 0.2;
%占右边比例
rate = 1/2;
rrate = rate*(1-cutRatio)*length;
theta = 90-28.36;
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
f = sqrt(R^2-(x-x0)^2-(z-z0)^2)+y0;  %圆球正半边
%ff = R^2-(x-x0)^2-(y-y0)^2;
%plot3(f)

fx = diff(f,x);
fz = diff(f,z);
fy = -1;
n0 = [fx/sqrt(fx^2+fy^2+fz^2),fy/sqrt(fx^2+fy^2+fz^2),fz/sqrt(fx^2+fy^2+fz^2)];

xx1 = -450-600;  %人眼位置
yy1 = 730;
zz1 = 0;
a = [x-xx1,f-yy1,z-zz1];  %入射光线
d = sqrt(a(1)^2+a(2)^2+a(3)^2);
a = a/d;
b = a - 2.*(a.*n0).*n0; %反射光线

%[X,Z] = meshgrid(linspace(0,length,50),linspace(0,width/2,50));  %在球上均匀取点
[X,Z] = meshgrid([0 rrate],0 );  %在水平线上取两个点均匀取点
%面上面积
S1 = length*width/2;
X=X(:);
Z=Z(:);
%A = find(((X-x2).^2.+(Z-z2).^2)<rr^2);  %从y方向看过去小球半径18

%Xa = X(A);
%Za = Z(A);
%Ya = subs(f,{x,z},{[Xa],[Za]});   


%ba= subs(b,{x,f,z},{[Xa],[Ya],[Za]});

%Yy = dis; %10米外的屏
%Xxa = (Yy-Ya)./ba(:,2).*ba(:,1)+Xa;
%Zza = (Yy-Ya)./ba(:,2).*ba(:,3)+Za;

%X(A)=[];
%Z(A)=[];
Y = subs(f,{x,z},{[X],[Z]});   


b1= subs(b,{x,f,z},{[X],[Y],[Z]});

Yy = dis; %10米外的屏
Xx = (Yy-Y)./b1(:,2).*b1(:,1)+X;
Zz = (Yy-Y)./b1(:,2).*b1(:,3)+Z;

%Xx = [Xx ;Xxa];
%Yy = [Yy ;Yya];
%Zz = [Zz ;Zza];
%Xxmax = double(max(Xx));  %视野范围 ，10米外最大距离
%Xxmin = double(min(Xx));
%Zzmax = double(max(Zz));
%Zzmin = double(min(Zz));
%S2 = (Zzmax - Zzmin)*(Xxmax -Xxmin);
%屏上最大边长
%S2 =   max(Xxmax-Xxmin,Zzmax-Zzmin); 
%ss1 = 507454752.327248;

Xx = double(Xx);
Zz = double(Zz);

LL = abs(Xx(2)-Xx(1))





    




