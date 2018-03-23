R1 = xlsread('q4-base-saomiao.xlsx');
kkk = 0; %初始角度
dataTable2 = R1(:,kkk+1:kkk+180);
N = 512;
Nt = 360;%角度采样点数
Nd = N;%平移数
d = N/Nd;%平移步长
theta=1:1:Nt;
a=zeros(N);
x = pi/180; % change to test
Q = dataTable2;
g=-(Nd/2-1):(Nd/2);
for i=1:N
    if g(i)==0
        hl(i)=1/(4*d^2);
    else
        if  mod(g(i),2)==0
           hl(i)=0;
        else
            hl(i)=(-1)/(pi^2*d^2*(g(i)^2));
        end
    end
end

k=Nd/2:(3*Nd/2-1);
Nt = 180;
a1 = -kkk;
for m=1:Nt
    pm=Q(:,m);
    u=conv(hl,pm);
    pm=u(k);
    Cm=((N-1)/2)*(1-cos((m-a1)*x)-sin((m-a1)*x));
    for i=1:N
        for j=1:N
            Xrm=Cm+(j-1)*cos((m-a1)*x)+(i-1)*sin((m-a1)*x);
            if Xrm<1
                n=1;
                t=abs(Xrm)-floor(abs(Xrm));
            else
                n=floor(Xrm);
                t=Xrm-floor(Xrm);
            end
            if n>(Nd-1)
                n=Nd-1;
            end
            p=(1-t)*pm(n)+t*pm(n+1);
            a(N+1-i,j)=a(N+1-i,j)+p;
        end
    end
end
image(a);
aa = (a) >= 10;
ratio = 20/22; % main
E = imresize(aa, ratio);
TL(1) = floor(106 * ratio);
TL(2) = floor(155 * ratio);
baseP = floor(255 * ratio);
EE = E((TL(1)):(TL(1)+baseP),(TL(2)):(TL(2)+baseP));
EE = imresize(EE, 1/ratio);
figure,imshow(EE);
Ir = xlsread('q4-base');
ANS = EE - Ir;
diffNum = length(find(ANS ~= 0));
diffPer = diffNum/65536