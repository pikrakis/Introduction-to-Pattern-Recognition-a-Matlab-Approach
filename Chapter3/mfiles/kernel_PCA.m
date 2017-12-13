function [s,V,Y]=kernel_PCA(X,m,choice,para)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [s,V,Y]=kernel_PCA(X,m,choice,para)
% Performs kernel PCA based on a given set of data vectors.
%
% INPUT ARGUMENTS:
%   X:      lxN dimensional matrix whose columns are the vectors on
%           which kernel PCA is applied.
%   m:      the number of the most significant principal components (columns
%           of V)  that are taken into account.
%   choice: the type of kernel function to be used: (a) polynomial ('pol')
%           or (b) exponential ('exp')
%   para:   a two-dimensional vector containing the parameters for the
%           kernel function: (a) for polynomials it is
%           (x'*y+para(1))^para(2) and (b) for exponentials it is
%           exp(-(x-y)'*(x-y)/(2*para(1)^2))
%
% OUTPUT ARGUMENTS:
%   s:      N-dimensional vector, which contains the eigenvalues
%           produced after applying kernel PCA on the data vectors of X.
%   V:      NxN matrix whose columns are the eigenvectors
%           corresponding to the principal components obtained after
%           performing kernel PCA on X.
%   Y:      mxN matrix, which contains the images of the data vectors
%           of X to the space spanned from the m most significant
%           principal components obtained after performing kernel PCA on X.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[l,N]=size(X);
% Computation of the Gram matrix
K=zeros(N,N);
for i=1:N
    for j=1:N
        K(i,j)=K_fun(X(:,i),X(:,j),choice,para);
    end
end

K_norm=K;
K_norm=K-(ones(N,N)/N)*K-K*(ones(N,N)/N)+(ones(N,N)/N)*K*(ones(N,N)/N);

% Eigendecomposition of the Gram matrix
[V,D]=eig(K_norm);
s=diag(D);
% Sorting from the largest to the smallest eigenvalues
[s,ind]=sort(s,1,'descend');
s=s.*(1-(abs(s)<10^(-12)));
V=V(:,ind);
ic=sum(s>0);
% Only nonzero eigenvalues are considered
if m>ic
    fprintf('\n WARNING: the m-dimensional subspace invlolves dimensions corresponding to zero eigenvalues. \n Re-run the program with m<%d \n',ic);
    s=[];V=[];Y=[];
    return;
end
% Normalization of the eigenvectors
for i=1:ic
    V(:,i)= (1/sqrt(N*s(i)))*V(:,i);
end

% Projection of the points
Y=zeros(m,N);
for q=1:N
    for k=1:m
        Y(k,q)=V(:,k)'*K(:,q);
    end
end
