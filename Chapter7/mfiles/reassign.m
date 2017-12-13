function [bel,new_repre]=reassign(X,repre,order)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION (auxiliary)
%  [bel,new_repre]=reassign(X,repre,order)
% This function performs a single pass on the data set and re-assigns the 
% data vectors to their closest clusters taking into account their distance
% from the cluster representatives. It may be applied on the clustering 
% produced by BSAS in order to obtain more compact clusters.
%
% INPUT ARGUMENTS:
%  X:       lxN dimensional matrix, each column of which corresponds to
%           an l-dimensional data vector.
%  repre:   the matrix whose columns contain the l-dimensional (mean) 
%           representatives of the clusters.
%  order:   N-dimensional vector containing a permutation of the
%           integers 1,2,...,N. The i-th element of this vector specifies
%           the order of presentation of the i-th vector to the algorithm.
%
% OUTPUT ARGUMENTS:
%  bel:     N-dimensional vector whose i-th element contains the
%           cluster label for the i-th data vector.
%  new_repre: the matrix whose columns contain the re-estimated
%           l-dimensional (mean) representatives of the clusters.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


[l,N]=size(X);
[l,n_clust]=size(repre);

for i=1:N
    [q1,q2]=min(sum((X(:,i)*ones(1,n_clust)-repre).^2));
    bel(i)=q2;
end


new_repre=zeros(l,n_clust);
for j=1:n_clust
    new_repre(:,j)=sum(X(:,bel==j)')'/sum(bel==j);
end
