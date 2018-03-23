clear;
I = imread('q4-base.png');
tresh = graythresh(I);
II = im2bw(I,tresh);
imshow(II);
Ir = imresize(II(:,1:802),0.319);
Ir = ~Ir;
%Ir = awgn(double(Ir),1000); 
A = zeros(512,512);
A(101:356,151:406)=Ir;
A1 = A;

[N,N]=size(A1);
z=2*ceil(norm(size(A1)-floor((size(A1)-1)/2)-1))+3;%?radon

theta=1:Nt;
theta=1:1:Nt;
a=zeros(N);
Nt = 360;%角度采样点数
Nd = N;%平移数
d = N/Nd;%平移步长
x=pi/180;%步长
[R,xp]=radon(A1,theta);
e=floor((z-Nd)/2)+2;
R=R(e:(Nd+e-1),:);
R1=reshape(R,512,360);
R2 = R1(:,1:180);
%figure
%image(R1);