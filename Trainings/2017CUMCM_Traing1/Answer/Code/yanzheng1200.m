%1200mm 验证  奇瑞QQ
% viewTable1
%function [g1,g2,rrr]=mymethod1_jibianzuo(cutRatio,R2)
dis=10000;

R1 = 1200;
R2 = 100;
length = 70.92*2.78;
width = 70*1.625;
cutRatio = 0.35;
theta = 90-15.8;
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

%rr = length * cutRatio/2 ;


x0 = x1;
y0 = y1;  %球心位置
z0 = z1; 
R = R1;   %球的半径

syms x
syms z
f = sqrt(R^2-(x-x0)^2-(z-z0)^2)+y0;  %圆球正半边
%f1 = sqrt(rr^2-(x-x2)^2-(z-z2)^2)+y2;  
%ff = R^2-(x-x0)^2-(y-y0)^2;
%plot3(f)

fx = diff(f,x);
fz = diff(f,z);
fy = -1;
n0 = [fx/sqrt(fx^2+fy^2+fz^2),fy/sqrt(fx^2+fy^2+fz^2),fz/sqrt(fx^2+fy^2+fz^2)];

%添加1
%fx1 = diff(f1,x);
%fz1 = diff(f1,z);
%fy1 = -1;
%n01 = [fx1/sqrt(fx1^2+fy1^2+fz1^2),fy1/sqrt(fx1^2+fy1^2+fz1^2),fz1/sqrt(fx1^2+fy1^2+fz1^2)];

xx1 = -450;  %人眼位置
yy1 = 730;
zz1 = 0;
a = [x-xx1,f-yy1,z-zz1];  %入射光线
d = sqrt(a(1)^2+a(2)^2+a(3)^2);
a = a/d;
b = a - 2.*(a.*n0).*n0; %反射光线


%添加2
%a1 = [x-xx1,f1-yy1,z-zz1];  %入射光线
%d1 = sqrt(a1(1)^2+a1(2)^2+a1(3)^2);
%a1 = a1/d1;
%bb = a1 - 2.*(a1.*n01).*n01; %反射光线

[X,Z] = meshgrid(linspace(0,length,50),linspace(0,width/2,50));  %在球上均匀取点

%面上面积
S1 = length*width/2;
X=X(:);
Z=Z(:);
X =X*cos(pi/2-theta);
%A = find(((X-x2).^2.+(Z-z2).^2)<rr^2);  %从y方向看过去小球半径18

Xa = X;
Za = Z;
Ya = subs(f,{x,z},{[Xa],[Za]});   


ba= subs(b,{x,f,z},{[Xa],[Ya],[Za]});

Yy = dis; %10米外的屏
Xx = (Yy-Ya)./ba(:,2).*ba(:,1)+Xa;
Zz = (Yy-Ya)./ba(:,2).*ba(:,3)+Za;

Xx = double(Xx);
Zz = double(Zz);

%AA = find(Xx<0 |Zz<0);%删去异常值
%Xx(AA)=[];
%X(AA)=[];
%Zz(AA)=[];
%Z(AA)=[];


Xxmax = max(Xx);  %视野范围 ，10米外最大距离
Xxmin = min(Xx);
Zzmax = max(Zz);
Zzmin = min(Zz);
S2 =   max(Xxmax-Xxmin,Zzmax-Zzmin); 
%S2 = mean(Xx);
L1 = size(X,1);
s1 = 0;
for i =1:L1
    for j =(i+1):L1
    s1 = s1 +sqrt((X(j)-X(i))^2+(Z(j)-Z(i))^2);
    end
end

L2 = size(Xx,1);
s2 = 0;
for i =1:L2
    for j =(i+1):L2
    s2 = s2 +sqrt((Xx(j)-Xx(i))^2+(Zz(j)-Zz(i))^2);
    end
end

%a71 
%面上距离和
%s1 =    77161475.6875164;

%屏上距离和
%s2 =   990451013.308698;

%面上最大边长
S1 = length;
%屏上最大边长
S2 =   max(Xxmax-Xxmin,Zzmax-Zzmin); 

g1 = s1/S1;
g2 = s2/S2;
rrr=abs(g2-g1)/g1;
%g1 = ss1/S1;
%Xxmax-Xxmin




plot(X,Z,'o')
plot(Xx,Zz,'o')
    




