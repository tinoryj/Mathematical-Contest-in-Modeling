function [yhat, xishu] = indexSmooth2(data, alpha)
% 二次指数平滑
% data 为输入数据列向量
% yhat 为预测数据列向量
% xishu 返回a，b参数的值
% alpha 的大小规定了在新预测值中新数据和原预测值所占的比重。alpha 值越大，新数据所占的比重就愈大，原预测值所占的比重就愈小，反之亦然。

yt = data; 
n = length(yt);
st1(1) = yt(1);
st2(1) = yt(1);
for i = 2:n
    st1(i) = alpha * yt(i) + (1 - alpha) * st1(i-1);
    st2(i) = alpha * st1(i) + (1 - alpha) * st2(i-1); 
end
a = 2 * st1 - st2;
b = alpha / (1 - alpha) * (st1 - st2);
yhat = a + b; 
xishu = [b(n+1),a(n+1)];

end

