% 计算子因素x对母因素y的关联度( 默认取 ρ(rho) = 0.5 )
function [ r ] = GMCorrelation( data, x, y )
% data -> 输入数据（x+y）行，列数任意 - 一行代表一个因素，用列表示年份/第几个数据等
% x -> 子因素个数（在data中的前x行）
% y -> 母因素个数（在data中的后y行）
% r -> 因素关联度矩阵

n = x + y;

for i = 1:n 
    %标准化数据
    data(i,:) = data(i,:)/data(i,1);  
end

ck = data(y:n,:);
m1 = size(ck,1); 
bj = data(1:x,:);
m2 = size(bj,1); 

for i = 1:m1
    for j = 1:m2 
        t(j,:) = bj(j,:) - ck(i,:);
    end
    jc1 = min(min(abs(t')));
    jc2 = max(max(abs(t'))); 
    rho = 0.5; 
    ksi = (jc1+rho*jc2) ./ (abs(t)+rho*jc2); 
    rt = sum(ksi') / size(ksi,2);
    r(i,:)=rt;
end

end


