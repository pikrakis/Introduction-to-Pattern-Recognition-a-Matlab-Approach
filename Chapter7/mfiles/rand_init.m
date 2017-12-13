function [w]=rand_init(X,m,sed)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION (auxiliary)
%  [w]=rand_init(X,m,sed)
% This function chooses randomly m vectors from the smallest hyperrectangular
% whose edges are parallel to the axes and contains all the vectors of
% a given data set X.
%
% INPUT ARGUMENTS:
%  X:       lxN matrix, whose columns are the data vectors.
%  m:       the number of vectors to be selected.
%  sed:     the seed for the random number generator.
%
% OUTPUT ARGUMENTS:
%  w:       lxm matrix, whose columns are the randomly selected vectors.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rand('seed',sed)
[l,N]=size(X);
mini=min(X')';
maxi=max(X')';
w = ((maxi-mini)*ones(1,m)).*rand(l,m) + mini*ones(1,m);

