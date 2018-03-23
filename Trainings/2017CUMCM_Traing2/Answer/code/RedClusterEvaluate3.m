

%% 导入数据
[~, ~, raw] = xlsread('C:\Users\Qinyu\Desktop\第二阶段\酿酒葡萄提取过的数据.xls','酿酒红葡萄','B2:AE28');

%% 创建输出变量
S1 = reshape([raw{:}],size(raw));

%% 清除临时变量
clearvars raw;
%% 导入数据
[~, ~, raw] = xlsread('C:\Users\Qinyu\Desktop\第二阶段\酿酒红葡萄聚类.xlsx','工作表1','A3:D29');

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

E=S1(A,:);
F=S1(B,:);
G=S1(C,:);
   L1= size(E,1);
   L2= size(F,1);
   L3= size(G,1);

O1=mean(E); %聚类中心
O2=mean(F);
O3=mean(G);

EE = sum((O1-O2).^2)+sum((O1-O3).^2)+sum((O2-O3).^2);
   DD1 = 0;
   DD2 = 0;
   DD3 = 0;
for i =1:L1
    DD1 =DD1+sum( E(i,:)-O1).^2;
end
for i =1:L2
    DD2 =DD2+sum( F(i,:)-O2).^2;
end
for i =1:L3
    DD3 =DD3+sum( G(i,:)-O3).^2;
end
DD = DD1+DD2+DD3;
SS = EE/DD





