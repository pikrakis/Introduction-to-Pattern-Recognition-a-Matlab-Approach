function [bel,cost,w,a]=k_medoids(X,m,sed)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%  [bel,cost,w,a,cost]=k_medoids(X,m,sed)
% This function implements the k-medoids algorithm. The aim of this
% algorihm is the same with k-means, i.e. to move iteratively the cluster
% representatives to regions that are "dense" in data, so that
% a suitable cost function is minimized. However now the represenatives are
% constrained to be vectors of the data set. The algorithm terminates when
% no change in the representatives is encountered between two successive
% iterations.
%
% INPUT ARGUMENTS:
%  X:       lxN matrix, each column of which corresponds to
%           an l-dimensional data vector.
%  m:       the number of clusters.
%  sed:     a scalar integer, which is used as the seed for the random
%           generator function "rand".
%
% OUTPUT ARGUMENTS:
%  bel:     N-dimensional vector, whose i-th element contains the
%           cluster label for the i-th data vector after the convergence of
%           the algorithm.
%  cost:    a scalar which is the summation of the distances of each data
%           vector from each closest medoid, computed after the convergence
%           of the algorithm.
%  w:       lxm matrix, each column of which corresponds to a
%           cluster representative, after the convergence of the algorithm.
%  a:       m-dimensional vector containing the indices of the data
%           vectors that are used as representatives.
%
%  NOTE:    This function uses function "cost_comput" function which computes the
%           cost accosiated with a specific partition.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rand('seed',sed)
[l,N]=size(X);

%Random initialization of the representatives
a_ini=randperm(N);
a_ini=a_ini(1:m); %a contains the labels of the data vectors that are used as representatives
w_ini=X(:,a_ini);

%Computation of the cost
[bel_ini,cost_ini]=cost_comput(X,w_ini);

e=-1;
iter=0;

bel=bel_ini;
cost=cost_ini;
a=a_ini;
while (e<0)
    iter=iter+1;
    cost_old=cost;
    % Cost computation for each one of the neighboring sets of the
    % current medoid set and selection of the one with minimum cost
    for i=1:m
        for j=1:N
            a_temp=a;
            if(sum(j==a_temp)==0)
                a_temp(i)=j;
                w_temp=X(:,a_temp);
                [bel_temp,cost_temp]=cost_comput(X,w_temp);
                if(cost_temp<cost)
                    bel=bel_temp;
                    cost=cost_temp;
                    a=a_temp;
                end
            end
        end
    end
    e=cost-cost_old;
end
w=X(:,a);