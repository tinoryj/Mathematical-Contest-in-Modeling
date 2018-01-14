% 多服务台多队列（有优先级）-模拟 （以商场购物为例）
curclock = 0;  %当前时刻，动态变化
totalcustomer = 0;%总共服务的顾客数
numsrv = 2; %服务台数量
srvstatus = zeros(numsrv, 5);%服务员有关数据
%srvstatus 第1列：服务状态（0空闲，1正在服务）；第2列：当前服务顾客编号；
%          第3列：当前服务结束时刻；第4列：服务员空闲时间；第5列：服务的顾客总数
endtime =0;%结束时间
waiting = [];%等待队列数据
%waiting  第1列：顾客编号；第2列：顾客到达时刻；第3列：顾客开始接受服务时刻；
%		  第4列：接受服务时间；第5列：顾客结束服务时刻；第6列：间隔时间

cur = zeros(1, 6);%当前产生顾客的数据，对应关系同waiting
avgwaitlen = [];%平均等待队长
avgwaittime = [];% 平均等待时间
ujiange = 5;%平均间隔时间
finished = 0;
numsimucustumer = input('输入等待模拟的顾客数：');
while finished == 0,
   
   if totalcustomer < numsimucustumer
        %产生一个顾客的到达及其有关性质的数据      
        totalcustomer = totalcustomer+1;      
        jiange= -log(rand)*ujiange;%与上一个顾客的到达的间隔时间
        curclock = curclock + jiange;
        cur(1)= totalcustomer ;% 第1列：顾客编号
        cur(2) = curclock;%第2列：顾客到达时刻
        cur(6) = jiange; %第6列：间隔时间
        %产生接受服务时间
        if rand < 0.6, %产生顾客有关性质：这里是产生接受服务时间 优先级控制
            cur(4) = 5;
        else
            cur(4) = 8;
        end
        %放入等待队列
        if isempty(waiting),
            waiting= cur;
        else
            [m,n] = size(waiting);
            waiting(m+1,:) = cur;
        end
    else
        curclock = curclock + (-log(rand)*ujiange);
    end     
   
    %分配等待队列（看是否有服务员空闲，如果有则分配；否则继续执行）

    %处理服务员的服务状态
    for i = 1:numsrv,
        if srvstatus(i,1) == 1 & srvstatus(i,3) <= curclock,
            srvstatus(i,1) = 0;%设置为空闲状态
            srvstatus(i,4) = curclock-srvstatus(i,3);%目前已经空闲的时间
        elseif srvstatus(i,1) == 1 & srvstatus(i,3) > curclock,
            srvstatus(i,4) = 0;%没有休息（正在忙）
        else
            srvstatus(i,4) = curclock - srvstatus(i,3);%目前已经空闲的时间
        end      
   end
   %处理服务员服务的先后顺序（依据空闲时间）（精细处理）
   tmp = srvstatus(:,4);
   for i = 1:numsrv,
        [value,id]=max(tmp);
        b(i)=id;
        tmp(id)=0;%已经排序了      
   end
      
   %此时等待队列必然不为空
   for j = 1:numsrv,
        i = b(j);%确定服务员的序号
        if(srvstatus(i,1) == 0)
            %找一个顾客开始服务，同时计算该顾客什么时候接受服务，结束服务；
            [m,n] = size(waiting);
            if m == 0,
                break;
            end         
      
            if waiting(1,5) == 0,%还没有开始接受服务
                waiting(1,3) = curclock;
                waiting(1,5) = waiting(1,3)+waiting(1,4);%结束时刻
                srvstatus(i,1) = 1;%设置为忙状态
                srvstatus(i,2) = waiting(1,1);%顾客编号
                srvstatus(i,3) = waiting(1,5);%结束时刻
                srvstatus(i,5) = srvstatus(i,5)+1;%又服务了一个顾客
                %计算等待时间
                avgwaittime(end+1) = waiting(1,3)-waiting(1,2);            
                disp(sprintf('间隔时间(%8.2f) 顾客编号：%5d 接受服务员（%4d）服务(到达时刻%10.2f)',waiting(1,6),waiting(1,1),i,waiting(1,2)))
                endtime = max(endtime,waiting(1,5));
                waiting(1,:) = [];%从等待队列中离开
         end
      end
   end  
   [m,n]=size(waiting);
   %计算队长（这里的计算式子可以参考排队论有关术语进行确定）
   if totalcustomer < numsimucustumer
      avgwaitlen(end+1) = m;
   end
   if sum(srvstatus(:,5)) >= numsimucustumer,%队列为空，结束
      finished=1;
   end   
end 

disp('服务顾客数：')
disp(srvstatus(:,5)')
disp('平均队长');
disp(mean(avgwaitlen));
disp('运行时间（分钟，小时）');
disp(sprintf('%8.f%8.f',curclock,curclock/60));

disp('平均等待时间（分钟）');
disp(mean(avgwaittime ));
disp('结束时间（分钟）');
disp(endtime );

figure 
hist(avgwaitlen)   
title('平均队长')

figure 
hist(avgwaittime)
title('平均等待时间');