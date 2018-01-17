function y = movAverage(numSample,n,f)
% movAverage是多点移动平滑函数
% numSample为采用精度
% n为用于平滑的窗口大小，其值应大于零且小于numSample
% f为需要进行移动平滑处理的函数

m = 0; %m代表正在处理的点
while m < numSample-n+1 %采样点终止位置
    m=m+1;
    temp=0; %temp用于求n点函数值之和，此处将其清零
    for p=0:1:n-1 %p为窗口内变量的增量
        temp=temp+f(m+p) %n个点的数值总和
    end
    f(m)=temp/n; %求均值
end
y=f; %回代