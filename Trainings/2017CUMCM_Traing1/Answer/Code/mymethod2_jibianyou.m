%第二种方案的畸变率计算
% viewTable2
%function rrr=mymethod2_jibianyou(cutRatio,R2)

dis = 20000;
R1 = 1260;
R2 = 500;
length = 70.92*2.78;%2.72
width = 70*1.625;
cutRatio = 0.2;  
theta = 90-28.36;

rr = length * cutRatio ;

%calculate
theta = theta / 180 * pi;
%%R1 cal
lengthR1 = (length * (1 - cutRatio)) / 2;
beta1 = acos(lengthR1 / R1) + theta;
x1 =  sin(pi - beta1) * R1;
y1 = - cos(pi - beta1) * R1;
z1 = 0;
%%R2 cal

tempLehgth  = sqrt((R2 ^ 2) - (((length * cutRatio)/2)^2));


x2 = (length - (length * cutRatio)/2) * sin(theta) + cos(pi / 2 - (beta1 - theta) + beta1 - (pi / 2)) * tempLehgth;
y2 = (length - (length * cutRatio)/2) * cos(theta) - sin(pi / 2 - (beta1 - theta) + beta1 - (pi / 2)) * tempLehgth;
z2 = 0;
%%end point cal

%rr = length * cutRatio/2 ;


x0 = x1;
y0 = y1;  %球心位置
z0 = z1; 
R = R1;   %球的半径

syms x
syms z
f = sqrt(R^2-(x-x0)^2-(z-z0)^2)+y0;  %圆球正半边
f1 = sqrt(R2^2-(x-x2)^2-(z-z2)^2)+y2; 
%ff = R^2-(x-x0)^2-(y-y0)^2;
%plot3(f)

fx = diff(f,x);
fz = diff(f,z);
fy = -1;
n0 = [fx/sqrt(fx^2+fy^2+fz^2),fy/sqrt(fx^2+fy^2+fz^2),fz/sqrt(fx^2+fy^2+fz^2)];

%添加1
fx1 = diff(f1,x);
fz1 = diff(f1,z);
fy1 = -1;
n01 = [fx1/sqrt(fx1^2+fy1^2+fz1^2),fy1/sqrt(fx1^2+fy1^2+fz1^2),fz1/sqrt(fx1^2+fy1^2+fz1^2)];

xx1 = -450-600;  %人眼位置
yy1 = 730;
zz1 = 0;
a = [x-xx1,f-yy1,z-zz1];  %入射光线
d = sqrt(a(1)^2+a(2)^2+a(3)^2);
a = a/d;
b = a - 2.*(a.*n0).*n0; %反射光线

%添加2
a1 = [x-xx1,f1-yy1,z-zz1];  %入射光线
d1 = sqrt(a1(1)^2+a1(2)^2+a1(3)^2);
a1 = a1/d1;
bb = a1 - 2.*(a1.*n01).*n01; %反射光线

[X,Z] = meshgrid(linspace(0,length,50),linspace(0,width/2,50));  %在球上均匀取点

%面上面积
S1 = length*width/2;
X=X(:);
Z=Z(:);
X =X*cos(pi/2-theta);
A = find(((X-x2).^2.+(Z-z2).^2)<rr^2);  %从y方向看过去小球半径18

Xa = X(A);
Za = Z(A);
Ya = subs(f1,{x,z},{[Xa],[Za]});   


ba= double(subs(bb,{x,f1,z},{[Xa],[Ya],[Za]}));

Yy = dis; %10米外的屏
Xxa = (Yy-Ya)./ba(:,2).*ba(:,1)+Xa;
Zza = (Yy-Ya)./ba(:,2).*ba(:,3)+Za;

X(A)=[];
Z(A)=[];
Y = subs(f,{x,z},{[X],[Z]});   


b1= subs(b,{x,f,z},{[X],[Y],[Z]});

Yy = dis; %10米外的屏
Xx = (Yy-Y)./b1(:,2).*b1(:,1)+X;
Zz = (Yy-Y)./b1(:,2).*b1(:,3)+Z;

Xx = [Xx ;Xxa];
%Yy = [Yy ;Yya];
Zz = [Zz ;Zza];
Xxmax = double(max(Xx));  %视野范围 ，10米外最大距离
Xxmin = double(min(Xx));
Zzmax = double(max(Zz));
Zzmin = double(min(Zz));
%S2 = (Zzmax - Zzmin)*(Xxmax -Xxmin);
%屏上最大边长
S2 =   max(Xxmax-Xxmin,Zzmax-Zzmin); 
ss1 = 507454752.327248;

Xx = double(Xx);
Zz = double(Zz);


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








    




