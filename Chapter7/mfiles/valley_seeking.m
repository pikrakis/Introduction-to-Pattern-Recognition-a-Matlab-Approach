function [bel,iter]=valley_seeking(X,a,bel_ini,max_iter)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%  [bel,iter]=valley_seeking(X,a,bel_ini,max_iter)
% This function implements the valley seeking algorithm. This algorithm
% starts with an initial clustering of the data vectors and iteratively
% adjusts it in order to identify the regions that are "dense" in data
% (these correspond to the physically formed clusters). Specifically, at
% each iteration and for each data vector, x, its closest neighbors are
% considered and x is assigned to the cluster that has more vectors
% among the neighbors of x. The algorithm terminates when no point is
% reassigned to a different cluster between two successive iterations.
%
% INPUT ARGUMENTS:
%  X:       lxN matrix whose rows correspond to the data vectors.
%  a:       a parameter that specifies the size of the neighborhood.
%  bel_ini: N-dimensional vector whose i-th coordinate contains the
%           index of the cluster where the i-th vector is initially
%           assigned.
%  max_iter: a parameter that specifies the maximum allowable number of
%            iterations.
%
% OUTPUT ARGUMENTS:
%  bel:     N-dimensional vector which has the same structure with
%           "bel_ini" described above.
%  iter:    the number of iterations performed until convergence is
%           achieved.
%
% NOTES:
% - The function adopts the squared Euclidean distance between two vectors.
% - It is assumed that the cluster indices are in the set {1,2,...,m}
% - The algorithm is extremely sensitive to parameter settings ("a" and
%   "bel_ini"). It can be used after e.g. a sequential algorithm which
%   identifies more that the actual clusters. Then, the valley seeking
%   algorithm can proceed with this as initial condition in order to
%   identify the true number of clusters.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[l,N]=size(X);
m=max(bel_ini);

bel=bel_ini;

e=1;
iter=0;
while (e>0)&(iter<max_iter)
    iter=iter+1;
    bel_old=bel; % This is kept for checking convergence of the algorithm
    
    bel_temp=zeros(1,N); % This is used to keep temporarily the clustering in an iteration
    for i=1:N
        temp=sum((X(:,i)*ones(1,N)-X).^2);
        t=(temp<a);
        t(i)=0;
        count_cat=zeros(1,m);
        for j=1:m
            count_cat(j)=(sum(bel(t==1)==j));
        end
        [q1,q2]=max(count_cat);
        bel_temp(i)=q2;
    end
    
    bel=bel_temp;
    e=sum(abs(bel_old-bel));
end

%Relabeling in order to eliminate possible empty clusters
max_clust=max(bel);
for j=max_clust:-1:1
    if(sum(bel==j)==0)
        bel=bel.*(bel<j)+(bel-1).*(bel>j);
    end
end