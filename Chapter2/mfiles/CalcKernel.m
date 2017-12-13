function k = CalcKernel(u, v, ker, kpar1, kpar2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%  k = CalcKernel(u, v, ker, kpar1, kpar2)
% Calculates the Kernel function between two points (x1, x2).
%
% INPUTS ARGUMENTS:
%  ker:     Type of Kernel mapping to be used
%             'linear' : Linear 
%             'poly' : Polynomial
%             'rbf' : Gaussian  
%             'sigmoid' : tanh   
%  u:       row vector representing 1st point, or column of row-vectors
%           representing array of 1st points.
%  v:       row vector representing 2nd point.
%  kpar1:   1st parameter for kernel function (optional, default=0).
%  kpar2:   1st parameter for kernel function (optional, default=0).
%
% OUTPUT ARGUMENTS:
%  k:       the value of kernel function for these two points. If u is a
%           matrix (column of row-vectors), k is a column of values, with
%           same rows as u (one value for each row of u).
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if (nargin < 3)
    error('CalcKernel needs at least 3 arguments')
end
if (nargin < 5)
    kpar2 = 0;
end
if (nargin < 4)
    kpar1 = 0;
end

[r1 c1] = size(u);
[r2 c2] = size(v);
if (r1 < 1 || r2 ~= 1)
    error('CalcKernel expect u=column of row-vectors and v a row-vector')
end
if (c1 ~= c2)
    error('CalcKernel needs both x1 and x2 to have same num of columns')
end

switch lower(ker)
    case 'linear'
        k = u*v';
    case 'poly'
        k = (u*v' + kpar1).^kpar2;
    case 'rbf'
        k = zeros(r1,1);
        for i = 1 : r1
            k(i) = exp(-(u(i,:)-v)*(u(i,:)-v)'/(2*kpar1^2));
        end
    case 'erbf'
        k = zeros(r1,1);
        for i = 1 : r1
            k(i) = exp(-sqrt((u(i,:)-v)*(u(i,:)-v)')/(2*kpar1^2));
        end
    case 'sigmoid'
        k = zeros(r1,1);
        for i = 1 : r1
            k(i) = tanh(kpar1*u(i,:)*v'/length(u(i,:)) + kpar2);
        end
    case 'fourier'
        k = zeros(r1,1);
        for i = 1 : r1
            z = sin(kpar1 + 1/2)*2*ones(length(u(i,:)),1);
            j = find(u(i,:)-v);
            z(j) = sin(kpar1 + 1/2)*(u(i,j)-v(j))./sin((u(i,j)-v(j))/2);
            k(i) = prod(z);
        end
    case 'spline'
        k = zeros(r1,1);
        for i = 1 : r1
            z = 1 + u(i,:).*v + u(i,:).*v.*min(u(i,:),v) - ((u(i,:)+v)/2).*(min(u(i,:),v)).^2 + (1/3)*(min(u(i,:),v)).^3;
            k(i) = prod(z);
        end
    case {'curvspline','anova'}
        k = zeros(r1,1);
        for i = 1 : r1
            z = 1 + u(i,:).*v + (1/2)*u(i,:).*v.*min(u(i,:),v) - (1/6)*(min(u(i,:),v)).^3;
            k(i) = prod(z);
        end
        
        % - sum(u.*v) - 1; 
        %        z = 1 + u.*v + (1/2)*u.*v.*min(u,v) - (1/6)*(min(u,v)).^3;
        %        k = prod(z); 
        %        z = (1/2)*u.*v.*min(u,v) - (1/6)*(min(u,v)).^3;
        %        k = prod(z); 
        
    case 'bspline'
        k = zeros(r1,1);
        for i = 1 : r1
            z = 0;
            for r = 0: 2*(kpar1+1)
                z = z + (-1)^r*binomial(2*(kpar1+1),r)*(max(0,u(i,:)-v + kpar1+1 - r)).^(2*kpar1 + 1);
            end
            k(i) = prod(z);
        end
    case 'anovaspline1'
        k = zeros(r1,1);
        for i = 1 : r1
            z = 1 + u(i,:).*v + u(i,:).*v.*min(u(i,:),v) - ((u(i,:)+v)/2).*(min(u(i,:),v)).^2 + (1/3)*(min(u(i,:),v)).^3;
            k(i) = prod(z); 
        end
    case 'anovaspline2'
        k = zeros(r1,1);
        for i = 1 : r1
            z = 1 + u(i,:).*v + (u(i,:).*v).^2 + (u(i,:).*v).^2.*min(u(i,:),v) - u(i,:).*v.*(u(i,:)+v).*(min(u(i,:),v)).^2 + (1/3)*(u(i,:).^2 + 4*u(i,:).*v + v.^2).*(min(u(i,:),v)).^3 - (1/2)*(u(i,:)+v).*(min(u(i,:),v)).^4 + (1/5)*(min(u(i,:),v)).^5;
            k(i) = prod(z);
        end
    case 'anovaspline3'
        k = zeros(r1,1);
        for i = 1 : r1
            z = 1 + u(i,:).*v + (u(i,:).*v).^2 + (u(i,:).*v).^3 + (u(i,:).*v).^3.*min(u(i,:),v) - (3/2)*(u(i,:).*v).^2.*(u(i,:)+v).*(min(u(i,:),v)).^2 + u(i,:).*v.*(u(i,:).^2 + 3*u(i,:).*v + v.^2).*(min(u(i,:),v)).^3 - (1/4)*(u(i,:).^3 + 9*u(i,:).^2.*v + 9*u(i,:).*v.^2 + v.^3).*(min(u(i,:),v)).^4 + (3/5)*(u(i,:).^2 + 3*u(i,:).*v + v.^2).*(min(u(i,:),v)).^5 - (1/2)*(u(i,:)+v).*(min(u(i,:),v)).^6 + (1/7)*(min(u(i,:),v)).^7;
            k(i) = prod(z);
        end
    case 'anovabspline'
        k = zeros(r1,1);
        for i = 1 : r1
            z = 0;
            for r = 0: 2*(kpar1+1)
                z = z + (-1)^r*binomial(2*(kpar1+1),r)*(max(0,u(i,:)-v + kpar1+1 - r)).^(2*kpar1 + 1);
            end
            k(i) = prod(1 + z);
        end
    otherwise
        %k = u*v'; %linear (identity kernel)
        fprintf('CalcKernel: wrong kernel ''%s''\n',ker);
end




