function [z]=im_point(x,X,V,m,choice,para)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [z]=im_point(x,X,V,m,choice,para)
% Returns the image of an l-dimensional column vector x on the space
% spanned by the first m column vectors of the matrix V, which contains the
% principal components obtained after performing kernel PCA on the data
% set X.
%
% INPUT ARGUMENTS:
%   x:      l-dimensional column vector, whose image is to be computed.
%   X:      lxN matrix whose columns are the vectors on which kernel PCA 
%           has been performed.
%   V:      NxN matrix whose columns are the eigenvectors
%           corresponding to the principal components obtained after
%           performing kernel PCA on X.
%   m:      the number of the most significant principal components (columns
%           of V)  that will be taken into account.
%   choice: the type of kernel function to be used: (a) polynomial ('pol')
%           or (b) exponential ('exp').
%   para:   a two-dimensional vector containing the parameters for the
%           kernel function: (a) for polynomials it is
%           (x'*y+para(1))^para(2) and (b) for exponentials it is
%           exp(-(x-y)'*(x-y)/(2*para(1)^2)).
%
% OUTPUT ARGUMENTS:
%   z:      m-dimensional column vector which is the image of x to the
%           space spanned from the m most significant principal components
%           obtained after performing kernel PCA on X.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[l,N]=size(X);
for j=1:N
    ker(j)=K_fun(x,X(:,j),choice,para);
end
z=[];
for k=1:m
    z=[z V(:,k)'*ker'];
end
z=z';
