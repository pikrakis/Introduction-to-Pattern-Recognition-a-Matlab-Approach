function [z]=gauss(x,m,s)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION (auxiliary)
%   [z]=gauss(x,m,s)
% Takes as input the mean values and the variances of a number of Gaussian 
% distributions and a vector x and computes the value of each 
% Gaussian at x.
%
% NOTE: It is assumed that the covariance matrices of the gaussian
% distributions are diagonal with equal diagonal elements, i.e. it has the
% form sigma^2*I, where I is the identity matrix.
%
% INPUT ARGUMENTS:
%   x:  l-dimensional row vector, on which the values of the J
%       gaussian distributions will be calculated
%   m:  Jxl matrix, whose j-th row corresponds to the
%       mean of the j-th gaussian distribution
%   s:  J-dimensional row vector whose j-th component corresponds to
%       the variance for the j-th gaussian distribution (it is assumed
%       that the covariance matrices of the distributions are of the
%       form sigma^2*I, where I is the lxl identity matrix)
%
% OUTPUT ARGUMENTS:
%   z:  J-dimensional vector whose j-th component is the value of the
%       j-th gaussian distribution at x.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[J,l]=size(m);
[p,l]=size(x);
z=[];
for j=1:J
    t=(x-m(j,:))*(x-m(j,:))';
    c=1/(2*pi*s(j))^(l/2);
    z=[z c*exp(-t/(2*s(j)))];
end