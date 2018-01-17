function [beta_z, xishu, sol] = pzRegress(pz,n,m)
% pz 每一列为一个指标，每一行为一个样本
% n 是自变量的个数 前n列
% m 是因变量的个数 后m列

% sol 回归方程的系数，每一列是一个方程，每一列的第一个数是常数项,每一列为一个因变量与自变量们的回归
% beta_z 回归系数
% xishu 系数矩阵,即未还原原始变量的系数,每一列为一个因变量与自变量的回归方程

format short

mu = mean(pz); %求均值
sig = std(pz); %求标准差
rr = corrcoef(pz); %求相关系数矩阵
data = zscore(pz); %数据标准化
%定义自变量为前n列，因变量为n+1到m列
x0 = pz(:,1:n);
y0 = pz(:,n+1:end);
%e0为自变量归一化值，f0为因变量归一化值
e0 = data(:,1:n);
f0 = data(:,n+1:end);

num = size(e0,1);%求样本点的个数
chg = eye(n); % w 到 w* 变换矩阵的初始化
for i = 1:n
    %计算 w，w* 和t 的得分向量，
    matrix = e0'*f0*f0'*e0;
    [vec,val] = eig(matrix); %求特征值和特征向量
    val = diag(val); %提出对角线元素，即特征值
    [~,ind] = sort(val,'descend');%降序排列，ind为排序后原下标序号
    w(:,i) = vec(:,ind(1)); %提出最大特征值对应的特征向量
    w_star(:,i) = chg*w(:,i); %计算w*的取值
    t(:,i) = e0*w(:,i); %计算成分ti 的得分
    alpha = e0'*t(:,i)/(t(:,i)'*t(:,i)); %计算alpha_i
    chg = chg*(eye(n)-w(:,i)*alpha'); %计算w 到w*的变换矩阵
    e = e0-t(:,i)*alpha'; %计算残差矩阵
    e0 = e;%将残差矩阵带进下次循环
    %计算ss(i)的值
    beta = [t(:,1:i),ones(num,1)]\f0; %求回归方程的系数
    beta(end,:) = []; %删除回归分析的常数项
    cancha = f0-t(:,1:i)*beta; %求残差矩阵
    ss(i) = sum(sum(cancha.^2)); %求误差平方和
    %计算p(i)
    for j = 1:num
        t1 = t(:,1:i);f1=f0;
        she_t = t1(j,:);she_f=f1(j,:); %把舍去的第j 个样本点保存起来
        t1(j,:) = [];f1(j,:)=[]; %删除第j 个观测值
        beta1 = [t1,ones(num-1,1)]\f1; %求回归分析的系数
        beta1(end,:) = []; %删除回归分析的常数项
        cancha = she_f-she_t*beta1; %求残差向量
        p_i(j) = sum(cancha.^2);
    end
    p(i) = sum(p_i);
    if i > 1
        Q_h2(i) = 1-p(i)/ss(i-1);
    else
        Q_h2(1) = 1;
    end
    if Q_h2(i)<0.0975
        fprintf('提出的成分个数r=%d',i);
        fprintf('   ');
        fprintf('交叉的有效性=%f',Q_h2(i));
        r=i;
        break
    end
end
beta_z = [t(:,1:r),ones(num,1)]\f0; %求Y 关于t 的回归系数
beta_z(end,:) = []; %删除常数项
xishu = w_star(:,1:r)*beta_z; %求Y 关于X 的回归系数，且是针对标准数据的回归系数，每一列是一个回归方程
mu_x = mu(1:n);
mu_y = mu(n+1:end);
sig_x = sig(1:n);
sig_y = sig(n+1:end);
for i = 1:m
    ch0(i) = mu_y(i)-mu_x./sig_x*sig_y(i)*xishu(:,i); %计算原始数据的回归方程的常数项
end
for i=1:m
    xish(:,i) = xishu(:,i)./sig_x'*sig_y(i); %计算原始数据的回归方程的系数，每一列是一个回归方程
end

sol = [ch0;xish]; %显示回归方程的系数，每一列是一个方程，每一列的第一个数是常数项,每一列为一个因变量与自变量们的回归

end

