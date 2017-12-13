function prox_new=CL_step(prox_mat, merge_pair)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%  prox_new=CL_step(prox_mat, merge_pair)
% This function performs a step of the complete link algorithm.
% Specifically, given (a) the distances between clusters of the t-th
% level clustering and (b) the pair of clusters that has been selected
% for merging, the function computes the distances of the newly formed
% cluster from the remaining ones, when the complete link algorithm is
% adopted.
%
% INPUT ARGUMENTS:
%   prox_mat:   NxN dimensional dissimilarity matrix for the N vectors of
%               the data set at hand (prox_mat(i,j) is the distance between
%               vectors xi and xj).
%
%   merge_pair: a 2-dimensional vector containing the labels of the
%               clusters that are to be merged.
%
% OUTPUT ARGUMENTS:
%   prox_new:   a matrix containing the distances between the clusters of the
%               (t+1)th level clustering.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[p1,p2]=size(prox_mat);
prox_new=[prox_mat(:,1:merge_pair(2)-1) prox_mat(:,merge_pair(2)+1:p2)];
t=max([prox_new(merge_pair(1),:); prox_new(merge_pair(2),:)]);
prox_new(merge_pair(1),:)=t;
prox_new=[prox_new(1:merge_pair(2)-1,:); prox_new(merge_pair(2)+1:p1,:)];
prox_new(:,merge_pair(1))=t';
prox_new(merge_pair(1),merge_pair(1))=0;