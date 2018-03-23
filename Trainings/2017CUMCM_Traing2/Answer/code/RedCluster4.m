%% 导入电子表格中的数据
% 用于从以下电子表格导入数据的脚本:
%
%    工作簿: C:\Users\Qinyu\Desktop\第二阶段\酿酒红葡萄聚类.xlsx
%    工作表: 工作表1
%
% 要扩展代码以供其他选定数据或其他电子表格使用，请生成函数来代替脚本。

% 由 MATLAB 自动生成于 2017/08/22 10:00:18

%% 导入数据
[~, ~, raw] = xlsread('C:\Users\Qinyu\Desktop\第二阶段\酿酒红葡萄聚类.xlsx','工作表1','E3:H29');

%% 创建输出变量
data = reshape([raw{:}],size(raw));

%% 将导入的数组分配给列变量名称
VarName1 = data(:,1);
VarName2 = data(:,2);
VarName3 = data(:,3);
VarName4 = data(:,4);

%% 清除临时变量
clearvars data raw;

A= find(VarName2==1);
B= find(VarName2==2);
C= find(VarName2==3);
D= find(VarName2==4);
E=VarName4(A)
F=VarName4(B)
G=VarName4(C)
H=VarName4(D)

mean(E)
mean(F)
mean(G)
mean(H)
