function viewTable
%parameter definition
R1 = 1200;
R2 = 500;
length = 70.92;
width = 70;
cutRatio = 0.33;
theta = 70;
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
%%end point cal
beta2 = 2 * asin((length * cutRatio / 2) / R2) + 2 * (pi / 2 - (beta1 - theta)) + beta1 - (pi / 2);

x3 = x2 + R2 * sin(beta2 - pi/2);
y3 = y2 + R2 * cos(beta2 - pi/2);
z3 = 0;

[x,y,z]=sphere(2000);
datax1 = R1.*x+x1;
datax1(datax1>x3) = nan;
datax1(datax1<0) = nan;
datay1 = R1.*y+y1;
datay1(datay1>y3) = nan;
datay1(datay1<0) = nan;
dataz1 = R1.*z+z1;
dataz1(dataz1 > 35) = nan;
dataz1(dataz1 < -35) = nan;

datax2 = R2.*x+x2;
datax2(datax2>x3) = nan;
datax2(datax2<0) = nan;
datay2 = R2.*y+y2;
datay2(datay2>y3) = nan;
datay2(datay2<0) = nan;
dataz2 = R2.*z+z2;
dataz2(dataz2 > 35) = nan;
dataz2(dataz2 < -35) = nan;

x0 = 0; y0 = 0; z0 = 0;
%x1,y1,z1,'ro', x2,y2,z2, 'ro', 
plot3(x3,y3,z3, 'ro' , x0,y0,z0,'ro');
hold on

surf(datax1,datay1,dataz1);
hold on;
surf(datax2,datay2,dataz2);
xlabel('x');
ylabel('y');
zlabel('z');

axis equal





