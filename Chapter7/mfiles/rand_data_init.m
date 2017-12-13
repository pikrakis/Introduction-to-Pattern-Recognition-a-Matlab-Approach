function [w]=rand_data_init(X,m,sed)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION (auxiliary)
%  [w]=rand_data_init(X,m,sed)
% This function chooses randomly m among the N vectors contained in a data
% set X of vectors.
%
% INPUT ARGUMENTS:
%  X:       lxN matrix, whose columns are the data vectors.
%  m:       the number of vectors to be selected.
%  sed:     the seed for the random number generator.
%
% OUTPUT ARGUMENTS:
%  w:       lxm matrix, whose columns are the randomly selected
%           vectors of X.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[l,N]=size(X);
a=randperm(N);
a=a(1:m);  %a contains the labels of the data vectors that are used as representatives
w=X(:,a);