%% 导入数据
[~, ~, raw] = xlsread('C:\Users\Qinyu\Desktop\第二阶段\工作簿1.xlsx','工作表1','B4:I33');

%% 创建输出变量
data = reshape([raw{:}],size(raw));

%% 将导入的数组分配给列变量名称
VarName2 = data(:,1);
VarName3 = data(:,2);
VarName4 = data(:,3);
VarName5 = data(:,4);
VarName6 = data(:,5);
VarName7 = data(:,6);
VarName8 = data(:,7);
VarName9 = data(:,8);

%% 清除临时变量
clearvars data raw;

%% 导入数据
[~, ~, raw] = xlsread('C:\Users\Qinyu\Desktop\第二阶段\酿酒葡萄提取过的数据.xls','酿酒红葡萄','B2:AE28');

%% 创建输出变量
S1 = reshape([raw{:}],size(raw));

%% 清除临时变量
clearvars raw;
% 标准化
for i =1:30
S1(:,i) = (S1(:,i)-mean(S1(:,i)))/sqrt(var(S1(:,i)));
end



XX = zeros(27,8);
XX(:,1)= S1*VarName2;
XX(:,2)= S1*VarName3;
XX(:,3)= S1*VarName4;
XX(:,4)= S1*VarName5;
XX(:,5)= S1*VarName6;
XX(:,6)= S1*VarName7;
XX(:,7)= S1*VarName8;
XX(:,8)= S1*VarName9;


%% 导入数据
[~, ~, raw] = xlsread('C:\Users\Qinyu\Desktop\第二阶段\葡萄酒.xls','葡萄酒','C3:K29');

%% 创建输出变量
data = reshape([raw{:}],size(raw));

%% 将导入的数组分配给列变量名称
V1 = data(:,1);
V2 = data(:,2);
V3 = data(:,3);
V4 = data(:,4);
V5 = data(:,5);
V6 = data(:,6);
V7 = data(:,7);
V8 = data(:,8);
V9 = data(:,9);

%% 清除临时变量
clearvars data raw;

%[b,bint,r,rint,stats]= regress(Y,X)

b1=regress(V1,XX);
b2=regress(V2,XX);
b3=regress(V3,XX);
b4=regress(V4,XX);
b5=regress(V5,XX);
b6=regress(V6,XX);
b7=regress(V7,XX);
b8=regress(V8,XX);
b9=regress(V9,XX);

B = [b1 b2 b3 b4 b5 b6 b7 b8 b9];
ZZ = zeros(9,30);
for i =1:9
    bi = B(:,i);
ZZ(i,:) = bi(1)*VarName2'+bi(2)*VarName3'+bi(3)*VarName4'+bi(4)*VarName5'+bi(5)*VarName6'+bi(6)*VarName7'+bi(7)*VarName8'+bi(8)*VarName9';
end


F=B';
