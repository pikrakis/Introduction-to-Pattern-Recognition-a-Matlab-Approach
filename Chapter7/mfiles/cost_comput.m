function [bel,cost]=cost_comput(X,w)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION (auxiliary)
%  [bel,cost]=cost_comput(X,w)
% This function is called by the "k_medoids" function. Its aim is twofold:
%   (a) it computes the value of the cost function employed by the
%       k-medoids algorithm, i.e. the summation of the distances of each
%       data vector from each closest representative and
%   (b) it assigns each vector x to the cluster whose repersentative lies
%       closest to x.
%
% INPUT ARGUMENTS:
%  X:       lxN dimensional matrix, each column of which corresponds to
%           an l-dimensional data vector.
%  w:       lxm dimensional matrix, each column of which corresponds to
%           a cluster representative.
%
% OUTPUT ARGUMENTS:
%  bel:     N-dimensional vector, whose i-th element contains the
%           cluster label for the i-th data vector.
%  cost:    a scalar which is the summation of the distances of each data
%           vector from each closest representative.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[l,N]=size(X);
[l,m]=size(w);

bel=zeros(1,N);
cost=0;

for i=1:N
    t=zeros(1,m);
    for j=1:m
        t(j)=distan(X(:,i),w(:,j));
    end
    [q1,q2]=min(t);
    bel(i)=q2;
    cost=cost+q1;
end
