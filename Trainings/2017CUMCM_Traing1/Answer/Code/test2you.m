%第二种方法的测试(右外后视镜)

R2 =500;
cutRatio = 0.2;  %注意与第一种方法初值不同
DD2Y = [];
ii=0;
for i = 1:16
    for j =1:8
    
rrr=mymethod2_jibianyou(cutRatio,R2);
Xxmax = mymethod2_shiyeyou(cutRatio,R2);
DD2Y=[DD2Y;cutRatio R2  rrr Xxmax];
R2=R2+100;
ii=ii+1
    end
        R2=500;
cutRatio = cutRatio+0.02;
end