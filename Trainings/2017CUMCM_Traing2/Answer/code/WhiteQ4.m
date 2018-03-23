
%% 导入数据
[~, ~, raw] = xlsread('C:\Users\Qinyu\Desktop\第二阶段\白红／全部主成分分析.xlsx','白','B52:M91');
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
raw = raw(:,[1,2,3,4,5,6,7,8,9,10,11,12]);

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
VarName10 = data(:,9);
%VarName11 = double(cellVectors(:,1));
%VarName12 = double(cellVectors(:,2));
%VarName13 = double(cellVectors(:,3));
VarName11 = data(:,10);
VarName12 = data(:,11);
VarName13 = data(:,12);

%% 清除临时变量
clearvars data raw;

%% 导入数据
[~, ~, raw] = xlsread('C:\Users\Qinyu\Desktop\第二阶段\整理.xlsx','白','A2:AN29');
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};

%% 将非数值元胞替换为 NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % 查找非数值元胞
raw(R) = {NaN}; % 替换非数值元胞

%% 创建输出变量
S1 = reshape([raw{:}],size(raw));

%% 清除临时变量
clearvars raw R;

% 标准化
for i =1:28
S1(:,i) = (S1(:,i)-mean(S1(:,i)))/sqrt(var(S1(:,i)));
end

XX = zeros(28,12);
XX(:,1)= S1*VarName2;
XX(:,2)= S1*VarName3;
XX(:,3)= S1*VarName4;
XX(:,4)= S1*VarName5;
XX(:,5)= S1*VarName6;
XX(:,6)= S1*VarName7;
XX(:,7)= S1*VarName8;
XX(:,8)= S1*VarName9;
XX(:,9)= S1*VarName10;
XX(:,10)= S1*VarName11;
XX(:,11)= S1*VarName12;
XX(:,12)= S1*VarName13;

%% 导入数据
[~, ~, raw] = xlsread('C:\Users\Qinyu\Desktop\第二阶段\2017-2-1-B-1.xls','白2','N3:N30');

%% 创建输出变量
YY = reshape([raw{:}],size(raw));

%% 清除临时变量
clearvars raw;

[b,bint,r,rint,stats]= regress(YY,XX);
%stepwise(XX,YY)
YY = [YY(1:19) ;YY(21:28)];
XX = [XX(1:19,:) ;XX(21:28,:)];

%YY = [YY(1:5) ;YY(7:27)];
%XX = [XX(1:5,:) ;XX(7:27,:)];
%stepwise(XX,YY)
%XX = [XX(:,2:12)];
[b,bint,r,rint,stats]= regress(YY,XX);

rcoplot(r,rint)
ttest(r)
jbtest(r)

