function [w]=SSErr(X,y,C)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%  [w]=SSErr(X,y,lambda)
% Separates the vectors of two classes contained in a data
% set X with a hyperplane, based on the sum of error squares criterion.
%
% INPUT ARGUMENTS:
%  X:       lxN matrix whose columns are the data vectors to
%           be classified.
%  y:       N-dimensional vector whose i-th  component contains the
%           label of the class where the i-th data vector belongs (+1 or
%           -1).
%  C:       a small positive user-defined constant that guarantees the
%           inversion of X*X', when it is near singular.
%
% OUTPUT ARGUMENTS:
%  w:       the l-dimensional parameter vector that corresponds to the
%           hyperplane that separates the two classes.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[l,N]=size(X);
w=inv(X*X'+C*eye(l))*(X*y');

