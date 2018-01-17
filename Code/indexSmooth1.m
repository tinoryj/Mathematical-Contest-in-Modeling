function [yhat,err] = indexSmooth1(data, alpha)
% 一次指数平滑
% data 为输入数据列向量
% yhat 为预测数据列向量
% err 为预测误差
% alpha 的大小规定了在新预测值中新数据和原预测值所占的比重。alpha 值越大，新数据所占的比重就愈大，原预测值所占的比重就愈小，反之亦然。
% alpha 为行向量，便于同时计算多个alpha值下的结果

yt = data; 
n = length(yt);
m = length(alpha);
yhat(1,1:m) = (yt(1)+yt(2))/2;
for i = 2:n 
    yhat(i,:) = alpha * yt(i-1) + (1-alpha) .* yhat(i-1,:);
end

err = sqrt(mean((repmat(yt,1,m)-yhat).^2));

end

