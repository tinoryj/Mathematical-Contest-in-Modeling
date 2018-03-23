

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