%第一种方法的测试(左外后视镜)

R2 =500;
cutRatio = 0.2;
DD1Z = [];
ii=0;
for i = 1:16
    for j =1:8
    
rrr=mymethod1_jibianzuo(cutRatio,R2);
Xxmax = mymethod1_shiyezuo(cutRatio,R2);
DD1Z=[DD1Z; cutRatio R2 rrr Xxmax]
R2=R2+100;
ii=ii+1
    end
    R2=500;
cutRatio = cutRatio+0.02;
end