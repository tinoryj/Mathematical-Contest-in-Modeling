% ?????? X,Y
% ????X??????L
% ????????????
% [y,L] = lagrange(X,Y,x)
% [y] = lagrange(X,Y,x)
% [L] = lagrange(X,Y)
function [varargout] = lagrange(varargin)
if nargin == 3
    y = lagrange1(varargin{1:nargin});
    varargout{1} = y;
    if nargout == 2
    L = lagrange2(varargin{1:nargin-1});
    varargout{2} = L;
    end
else
    L = lagrange2(varargin{1:nargin});
    varargout{1} = L;
end
end



function [y] = lagrange1(X,Y,x)
n=length(X);m=length(x);
for i=1:m
  z=x(i);
  s=0.0;
  for k=1:n
     p=1.0;
     for j=1:n          
       if j~=k
          p=p*(z-X(j))/(X(k)-X(j));
       end
     end
     s=p*Y(k)+s;
  end
y(i)=s;
end
end


function [L] = lagrange2(X,Y)  
m = length(X); 
for k = 1 : m  
    V = 1;
    S=0;
    for i = 1 : m  
        if k ~= i  
            V = conv(V,poly(X(i))) / (X(k) - X(i));  
            %conv(a,b) a,b??
            %poly(a)????a??????
        end  
    end  
    l(k, :) = poly2sym(V); 
end  
L = Y * l;
end


