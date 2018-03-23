function [ distance path] = Dijk( W,st,e )  
%DIJK Summary of this function goes here  

n=length(W);
D = W(st,:);  
visit= ones(1,n); visit(st)=0;  
parent = zeros(1,n);
path =[];  
for i=1:n-1  
    temp = [];
    for j=1:n  
       if visit(j)  
           temp =[temp D(j)];  
       else  
           temp =[temp inf];  
       end
    end  
      
    [value,index] = min(temp);
    visit(index) = 0;  

    for k=1:n  
        if D(k)>D(index)+W(index,k)  
           D(k) = D(index)+W(index,k);  
           parent(k) = index;  
        end  
    end
end  
  
distance = D(e);
t = e;  
while t~=st && t>0  
    path =[t,path];  
    p=parent(t);t=p;  
end  
path =[st,path];
end  
