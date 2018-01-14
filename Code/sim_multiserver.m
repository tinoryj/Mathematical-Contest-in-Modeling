function sim_multiserver
%  随机服务台 - 无优先级 （以商场购物为例）
global timeclock server custlist waitlist eventlist custno
global EVENT_COME EVENT_DEPART listlen  NumServer
TOver = 9.*60; %单位:分钟

NumServer = 4; %服务台个数
server = zeros(NumServer, 3);
%server(1,1)= 0; % 服务台状态: 0 闲; 1  忙
%server(1,2)= 0; % 服务台总服务时间
server(:,3) = (1:NumServer)'; %服务台编号为1到4

% custlist 各列数据含义（8列）
%  1     2       3         4 
% 编号|到达时刻|等待队长|接受服务时刻|
%      5        6     7        8        9
% 接受服务时间|离开时刻|商品件品|付款类型|服务台编号
custno = 0; %顾客编号初始(第i个顾客编号为i)
custlist = []; %初始化

% 等待队列长度:  length(waitlist)
waitlist = [];  % 每行存储一个顾客编号
listlen = 0;  %队长, length(waitlist);
eventlist = [];  %eventlist(:,1) 类型，eventlist(:,2) 本事件的发生时刻，%eventlist(:,3) 顾客编号

timeclock = 0; %初始化时钟
EVENT_COME = 1;
EVENT_DEPART= 2;

%产生第1个顾客
makecust;  %产生第1个顾客的到达事件

while timeclock < TOver,  %模拟时间限制
    event = pickevent;     %提取事件队列中最先发生的事件
    timeclock = event(2);   % 事件发生时刻
    switch event(1),
        case EVENT_COME,   % 1
            handle_come(event)  %传入当前处理到达类的事件
        case EVENT_DEPART, % 2
            handle_depart(event) %传入当前处理离开类的事件
    end
     disp([sprintf('%6.2f', timeclock), formatevent(event), formatcust(custlist(event(3),:))])
end %while

%%添加统计处理:
% 最大等待队长、平均队长
% 最大等待时间、平均等待时间
% 忙率（=服务员总服务时间/总模拟时间）

ids = find(custlist(:,4) > 0);
custlist = custlist(ids,:);

t= custlist(:,3);
max_dc = max(t);
mean_dc= mean(t);
disp(sprintf('最大队长=%6d, 平均队长=%6.2f', max_dc, mean_dc))

t =custlist(:,4) - custlist(:,2);
max_dc = max(t);
mean_dc= mean(t);
disp(sprintf('最大等待时间=%6.2f, 平均等待时间=%6.2f', max_dc,mean_dc))

t = sum(custlist(:,5));  %服务时间求和
disp(sprintf('检查:%8.2f == %8.2f', t,sum(server(:,2))))

for i=1:NumServer, %所有服务台忙率计算
    serverbusy(i) = server(i, 2)/TOver;
end
disp(sprintf('忙率= %8.4f', serverbusy))


%提取最早发生的事件
% custlist为全局变量
function event = pickevent 
global eventlist
if isempty(eventlist),
    error('找不到事件: 事件队列为空!')
end
t = eventlist(:,2);         %提取每个事件的发生时刻
[discard,index] = min(t);    %找出哪个事件最先发生
event = eventlist(index,:); %返回该事件信息
eventlist(index,:) = [];    %删除将要处理的事件


function handle_come(event)
% disp('arrive')
%顾客到达事件处理
global timeclock server custlist waitlist eventlist
global EVENT_COME EVENT_DEPART listlen

if server(:,1) == 1, % 如果所有的服务员都在忙  
%则加入等待队列
    custlist(event(3), 3)= listlen ; %等待队列长度
    waitlist = [waitlist; event(3)];
    listlen = listlen + 1;   %= length(waitlist)
else %如果有服务员闲  
    
    id = event(3); %当前顾客编号
    
    idserver = getidserver(server); %得到当前的空闲服务员
    
    timeserve = custlist(id, 7)./60+0.5+1.*custlist(id, 8);  %接受服务时间
    custlist(id, 4)= timeclock; %接受服务时刻
    custlist(id, 5)= timeserve; %产生服务时间
    custlist(id, 6)= timeclock + timeserve; %离开时刻
    custlist(id, 9) = idserver;
    server(idserver,1)=1; %服务台开始服务，设为繁忙
    server(idserver,2) = server(idserver,2) + timeserve; %服务时间累加
   
    %随即产生该顾客离开事件:
    event(1)  = EVENT_DEPART;
    event(2)  = custlist(id, 6);  %离开时刻
    event(3)  = id;  %顾客编号
    eventlist = [eventlist; event]; %追加到事件列表
end
[cust,event]= makecust; %产生新顾客

function handle_depart(event)
disp('deprt')
%顾客离开事件处理
global timeclock server custlist waitlist eventlist
global EVENT_COME EVENT_DEPART custno listlen
    
idserver = custlist(event(3),9);
server(idserver,1) = 0; %服务完成，置服务台为空闲
    
if listlen==0,
    %说明没有等待的顾客，转到后面，产生新到达的顾客

else
    %否则让队首顾客接受服务
    id = waitlist(1);
    waitlist(1) = [];   % 去掉队首顾客
    %找一个空闲的服务台
    idserver = getidserver(server);
    listlen = listlen - 1;
  
    if timeclock > custlist(id,2),
        custlist(id, 4) = timeclock;%上顾客离开时刻
    else %timeclock <= custlist(id,2)
        custlist(id, 4) = custlist(id,2);
    end

    custlist(id, 5) = custlist(id, 7)./60+0.5+1.*custlist(id, 8) %接受服务时间
    custlist(id, 6) = custlist(id,4) + custlist(id, 5);
    custlist(id, 9) = idserver;
    server(idserver,1)=1; %该服务台设为繁忙
    server(idserver,2) = server(idserver,2) + custlist(id, 5); 
    %随即产生顾客离开事件
    event(1)= EVENT_DEPART;
    event(2)= custlist(id,6); %离开事件的时刻
    event(3)= id;
    eventlist = [eventlist; event];%追加到事件列表   
end

function [cust,event] = makecust 
%产生顾客到达数据
global timeclock custlist eventlist custno 
global EVENT_COME EVENT_DEPART

custno = custno  + 1; %顾客编号累加
cust   = zeros(1,9);  %初始化为行向量
cust(1) = custno; %顾客编号
if custno > 1, % = 上一个顾客到达时刻 + 到达间隔时间
    cust(2) = custlist(custno-1, 2) + exprnd(.5); %下一个顾客到达时刻
else
    cust(2) = timeclock + exprnd(.5);%第1个顾客到达时刻
end
cust(7) = makegoods; %产生该顾客购买的商品件数
cust(8) = binornd(1,0.2);  %付款类型,1表示信用卡,0表示现金

custlist  = [ custlist; cust]; % 加到(全部)顾客列表
%随机产生顾客到达事件
event(1,1)= EVENT_COME;
event(1,2)= cust(2);%到达时刻
event(1,3)= custno; %顾客编号
eventlist = [eventlist; event];

function r = formatevent(event)
%  事件类型 事件时刻 顾客信息
global EVENT_COME
if event(1)==EVENT_COME,
    r =[sprintf('  COME%8.2f', event(2))];
else
    r =[sprintf('  DEPT%8.2f', event(2))];    
end

function r = formatcust(cust)
%  事件类型 事件时刻 顾客信息
r = [sprintf('%4d%8.2f%4d%8.2f%8.2f%8.2f%4d%4d%4d',cust(1), cust(2), cust(3), cust(4), cust(5), cust(6),cust(7),cust(8),cust(9))];

function idserver = getidserver(server)
t1 = find(server(:,1) == 0); %空闲服务台编号

% 这是另一个策略，总是取服务时间最少的服务台来服务
% [discard, id] = min(server(t1,2)); %在空闲服务台中的序号（不是服务台编号）
% idserver = t1(id); %空闲最多的服务台编号

% 选择服务台模块% 策略: 随机选择服务台为顾客服务
id = unidrnd(length(t1));
idserver = t1(id);

%产生顾客购买的商品件数
function expt = makegoods
fe = [0.12	0.10	0.18	0.28	0.20	0.12]; %不同数量级商品数的分布律
cumfe = cumsum(fe);  %分布律的累积序列
zz = rand;  %[0，1]区间上的均匀分布的随机数
sw_id = length(find(zz-cumfe>0)); %分支判定指标变量
switch sw_id
    case 0
        expt = unidrnd(8);   
    case 1
        expt = 9+unidrnd(10);    
    case 2
        expt = 20+unidrnd(9);   
    case 3
        expt = 30+unidrnd(9); 
    case 4
        expt = 40+unidrnd(9);   
    otherwise
        expt = 50+fix(exprnd(20));          
end
