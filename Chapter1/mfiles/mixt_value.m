function [y]=mixt_value(m,S,P,X)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION (auxiliary)
%   [y]=mixt_value(m,S,P,X)
% Computes the value of a pdf that is given as a mixture of normal
% distributions, at a given point.
%
% INPUT ARGUMENTS:
%   m:  lxc matrix, whose columns contain the means of
%       the normal distributions involved in the mixture.
%   S:  lxlxc matrix. S(:,:,i) is the covariance matrix of the i-th
%       normal distribution.
%   P:  c-dimensional vector containing the mixing probabilities for
%       the distributions
%   X:  lxN data matrix.
%
% OUTPUT ARGUMENTS:
%   y:  N dimensional array, whose i-th component is the value of
%       the mixture pdf at the i-th column vector of X.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[l,N]=size(X);
[l,c]=size(m);

y=[];
for i=1:N
    temp=[];
    for j=1:c
        t=mvnpdf(X(:,i)',m(:,j)',S(:,:,j));
        temp=[temp t];
    end
    y_temp=sum(P.*temp);
    y=[y y_temp];
end
