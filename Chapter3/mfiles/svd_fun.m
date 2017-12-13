function [U,s,V,Y]=svd_fun(X,m)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [U,s,V,Y]=svd_fun(X,m)
% Performs singular value decomposition (SVD) on an lxN dimensional data 
% matrix X of rank r (<=min(l,N)) and returns:
% (a) the lxl dimensional unitary matrix U, the NxN dimensional 
% unitary matrix V and the r dimensional vector s containing the singular 
% values ordered in descending order, for which X=U*S*V, where S equals to 
% zero except its upper left rxr matrix which has in its main diagonal the 
% elements of s and (b) the projections of the column vectors of X to the 
% space spanned by the first m columns of U.
%
% INPUT ARGUMENTS:
%   X:      lxN matrix whose columns are the data vectors.
%   m:      the number of the columns of U corresponding to largest
%           singular values that are taken into account.
%
% OUTPUT ARGUMENTS:
%   U:      lxl matrix containing the eigenvectors of X*X'
%           ordered according to the ordering of the singular values.
%   s:      r-dimensional vector containing the singular values in
%           descending order.
%   V:      NxN matrix containing the eigenvectors of X'*X
%           ordered according to the ordering of the singular values.
%   Y:      mxN matrix whose i-th column is the projection
%           of the i-th column vector of X on the space spanned by the
%           eigenvectors contained in U (U(:,i)=(1/sqrt(s(i)))*X*V(:,i))
%           that correspond to the m largest singular values of X.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[l,N]=size(X);

[V,D]=eig(X'*X);
s=diag(D);

[s,ind]=sort(s,1,'descend');
V=V(:,ind);

U=[];
for i=1:N
    U=[U (1/sqrt(s(i)))*X*V(:,i)];
end

A=U(:,1:m)';
Y=A*X;