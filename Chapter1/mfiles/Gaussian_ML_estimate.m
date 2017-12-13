function [m_hat,S_hat]=Gaussian_ML_estimate(X)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [m_hat,S_hat]=Gaussian_ML_estimate(X)
% Maximum Likelihood parameters estimation of a multivariate Gaussian
% distribution, based on a data set X.
%
% INPUT ARGUMENTS:
%   X:      lxN  matrix, whose columns are the data vectors.
%
% OUTPUT ARGUMENTS:
%   m_hat:  l-dimensional estimate of the mean vector of the distribution.
%   S_hat:  lxl estimate of the covariance matrix of the distribution.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[l,N]=size(X);
m_hat=(1/N)*sum(X')';
S_hat=zeros(l);
for k=1:N
    S_hat=S_hat+(X(:,k)-m_hat)*(X(:,k)-m_hat)';
end
S_hat=(1/N)*S_hat;
