function [eigenval,eigenvec,explain,Y,mean_vec]=pca_fun(X,m)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [eigenval,eigenvec,explain,Y,mean_vec]=pca_fun(X,m)
% Performs principal component analysis on a data set X and
% returns: (a) the eigenvalues, eigenvectors of the first m principal
% components, (b) the percentage of the total variance explained by each
% principal component, (c) the projections of the data points to the
% space spanned by the first m principal components and (d) the mean of X.
%
% INPUT ARGUMENTS:
%   X:      lxN matrix whose columns are the data vectors.
%   m:      the number of the most significant principal components that
%           are taken into account.
%
% OUTPUT ARGUMENTS:
%   eigenval:   m-dimensional column vector containing the m largest
%               eigenvalues of the covariance matrix of X, in descending order.
%   eigenvec:   lxm matrix whose i-th column corresponds to
%               the i-th largest eigenvalue of the covariance matrix of X.
%   explain:    l-dimensional column vector, whose i-th element is the
%               percentage of the total variance explained by the i-th
%               principal component.
%   Y:          mxN matrix whose i-th column is the projection
%               of the i-th column vector of X on the space spanned by the
%               first m principal components.
%   mean_vec:   the mean vector of X (l-dimensional column vector).
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[l,N]=size(X);

% Subtracting the mean
mean_vec=mean(X')';
X_zero=X-mean_vec*ones(1,N);

% Computing the covariance matrix and its eigenvalues/eigenvectors
R=cov(X_zero');
[V,D]=eig(R);

eigenval=diag(D);
[eigenval,ind]=sort(eigenval,1,'descend');
eigenvec=V(:,ind);

explain=eigenval/sum(eigenval);
% Keeping the first m eigenvaules/eigenvectors
eigenval=eigenval(1:m);
eigenvec=eigenvec(:,1:m);

% Computing the transformation matrix
A=eigenvec(:,1:m)';

% Computing the transformed data set
Y=A*X;
