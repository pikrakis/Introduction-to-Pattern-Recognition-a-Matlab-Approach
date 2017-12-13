function [a,iter,count_misclas]=kernel_perce(X,y,kernel,kpar1,kpar2,max_iter)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%  [a,iter,count_misclas]=kernel_perce(X,y,kernel,kpar1,kpar2,max_iter)
% Implements the kernel perceptron algorithm.
%
% INPUT ARGUMENTS:
%  X:       lxN matrix whose columns are the data vectors.
%  y:       N-dimensional row vector whose i-th element equals to the
%           class label of the i-th data vector (+1 or -1).
%  kernel:  adopted kernel function: (a) 'linear' for linear kernel
%           function, (b) 'rbf' for radial basis function, (c) 'poly' for
%           polynomial function, etc.
%  kpar1,kpar2: parameters for the kernel functions. Specifically (a) for
%           the 'linear' kernel both are set equal to 0, (b) for the 'rbf'
%           kernel kpar1 corresponds to sigma parameter, while kpar2 is set
%           equal to 0, (c) for the 'poly' kernel it is (x'y+kpar1)^kpar2.
%  max_iter: the maximum number of iterations allowed (it is necessary
%           since the classes is likely but it is not guaranteed to be
%           linearly separable in the transformed space).
%
% OUTPUT ARGUMENTS:
%  a:       N-dimensional row vector whose i-th element contains the
%           number of algorithm iterations for which the i-th data vector
%           was misclassified.
%  iter:    the number of iterations performed by the algorithm.
%  count_misclas: the number of misclassified vectors after the
%           termination of the algorithm.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[l,N]=size(X);

% Computation of the Kernel values K(xi,xj)
K=zeros(N,N);
for i=1:N
    K(:,i)=CalcKernel(X',X(:,i)',kernel,kpar1,kpar2);
end

%Parameter initialization
a=zeros(1,N); %Total  no of misclas./vector
count_misclas=N; %No of misclass./iteration
iter=0;  %Number of iterations

%Main phase
while (count_misclas>0)&&(iter<max_iter)
    iter=iter+1;
    count_misclas=0;
    for i=1:N
        t=sum((a.*y).*K(i,:))+sum(a.*y);
        if(y(i)*t<=0)
            a(i)=a(i)+1;
            count_misclas=count_misclas+1;
        end
    end
end