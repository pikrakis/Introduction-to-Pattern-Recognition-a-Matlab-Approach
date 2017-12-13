function [z]=distan(x,y)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION (auxiliary)
%  [z]=distan(x,y)
% This function computes the squared Euclidean distance between two
% column vectors.
%
% INPUT ARGUMENTS:
%  x:       l-dimensional column vector.
%  y:       l-dimensional column vector.
%
% OUTPUT ARGUMENTS:
%  z:       squared Euclidean distance between x and y.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

z=(x-y)'*(x-y);