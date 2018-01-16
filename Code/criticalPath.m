function [earliestST, latestET, route, freetime, worktime] = criticalPath(G)
% calaulate Critical Path in graph G
% earliestST -> earliest start time for each node
% latestET -> latest end time for each node
% route -> the Critical Path
% freetime -> the free time for each node
% worktime -> total work time

n = length(G);  
earliestST = zeros(1,n);   
latestET = zeros(1,n) + inf;   
for i = 2:n       
    new1 = 0;
    for j = 1:i-1          
        if(G(j,i)>0)      
            new1 = [new1,G(j,i)+earliestST(j)];             
        end
    end
    earliestST(i) = max(new1);
end

latestET(n) = earliestST(length(earliestST));

for i = n-1:-1:1     
    new2 = inf;
    for j = n:-1:i+1         
        if(G(i,j)>0)              
            new2 = [new2 latestET(j)-G(i,j)];        
        end
    end
    latestET(i) = min(new2);
end
route = 0;
for i = 1:n     
    if(earliestST(i) == latestET(i))       
        route = [route i];    
    end
end
for i = 1:1:n   
    freetime(i) = latestET(i) - earliestST(i);
end

route = route(2:length(route));
worktime = earliestST(n);

end


