function [range, dataPre, epsilon] = GM11(dataValue, preNum)
% range -> 检验预测正确性，正常值在（exp(-2/(n+1))，exp(2/(n+1))）之间（n为提供的数据量）- 一般没用 
% dataPre -> 预测结果
% epsilon -> 与原数据的误差

% 级比检验
dataNum = length(dataValue);
lambda = dataValue(1:end-1) ./ dataValue(2:end);
range = minmax(lambda);

% 参数a，b
x1 = cumsum(dataValue);
z = 0.5 * (x1(2:end) + x1(1:end-1));
Y = dataValue(2:end)';
B = [-z(1:end)' ones(dataNum-1,1)];
u=B\Y; %u=inv(B'*B)*B'*Y
a=u(1);
b=u(2);

% data predict
dataPre = [dataValue(1) ones(1,dataNum+preNum-1)];
for k = 1 : (dataNum - 1 + preNum)
    dataPre(k+1) = (dataValue(1)-b/a) * (exp(-a*k)-exp(-a*(k-1)));
end

% MRE
err = [dataValue - dataPre(1:dataNum)];
epsilon = abs(err)./dataValue(1:dataNum).*100;

end
