function [w, yhat] = AdaptiveFilter(data, N, k, errReq)
% 自适应滤波
% N为权数的个数
% k为学习常数，一般取k=0.9
% w 为计算得到的权数
% Terr 为预测误差
% errReq 为要求的精度，一般取0.00001

yt = data;
m = length(yt); 
Terr = 10000;
w = ones(1,N)/N;
while abs(Terr) > errReq
    Terr = [];
    for j = N+1:m-1
        yhat(j) = w*yt(j-1:-1:j-N)';
        err = yt(j)-yhat(j);
        Terr = [Terr,abs(err)];
        w = w+2*k*err*yt(j-1:-1:j-N);
    end
    Terr = max(Terr);
end

end

