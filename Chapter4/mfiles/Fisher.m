function [t]=Fisher(x,y)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [t]=Fisher(x,y)
% Computes Fisher's Discrimination Ratio (FDR) for a single feature in a
% two-class problem.
%
% INPUT ARGUMENTS:
%   x:      data vector of the first class.
%   y:      data vector of the second class.
%
% OUTPUT ARGUMENTS:
%   t:      Fisher's Discrimination Ratio.
%
% (c) 2010 S. Theodoridis, S. Theodoridis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mx=mean(x);
my=mean(y);
varx=var(x);
vary=var(y);
t=(mx-my)^2/(varx+vary);
