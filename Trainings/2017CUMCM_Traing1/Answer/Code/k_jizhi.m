function M= myfun(D)

D(:,5)=(1-D(:,3)).*D(:,4);
B=D(:,5);
[y,A ]= max(B);
M=D(A,:);

