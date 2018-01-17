function [yhat, xishu] = indexSmooth3(data, alpha)
% 三次指数平滑
% data 为输入数据列向量
% yhat 为预测数据列向量
% xishu 返回a，b，c参数的值
% alpha 的大小规定了在新预测值中新数据和原预测值所占的比重。alpha 值越大，新数据所占的比重就愈大，原预测值所占的比重就愈小，反之亦然。

yt = data; 
n = length(yt);

st1_0 = mean(yt(1:3)); 
st2_0 = st1_0;
st3_0 = st1_0; 

st1(1) = alpha * yt(1) + (1-alpha)*st1_0; 
st2(1) = alpha * st1(1) + (1-alpha)*st2_0; 
st3(1) = alpha * st2(1) + (1-alpha)*st3_0;
for i = 2:n
    st1(i) = alpha * yt(i) + (1-alpha)*st1(i-1); 
    st2(i) = alpha * st1(i) + (1-alpha)*st2(i-1); 
    st3(i) = alpha * st2(i) + (1-alpha)*st3(i-1);
end

st1 = [st1_0,st1];
st2 = [st2_0,st2];
st3 = [st3_0,st3];

a = 3*st1 - 3*st2 + st3; 
b = 0.5*alpha/(1-alpha)^2*((6-5*alpha)*st1-2*(5-4*alpha)*st2+(4-3*alpha)*st3); 
c = 0.5*alpha^2/(1-alpha)^2*(st1-2*st2+st3);
yhat = a+b+c;
xishu=[c(n+1),b(n+1),a(n+1)];

end

