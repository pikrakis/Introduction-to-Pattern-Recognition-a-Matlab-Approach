function [bel, thres]=agglom(prox_mat,code)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%  [bel, thres]=agglom(prox_mat,code)
% Implements the generalized agglomerative scheme (GAS).
%
% INPUT ARGUMENTS:
%   prox_mat:   NxN dissimilarity matrix for the N vectors of
%               the data set at hand (prox_mat(i,j) is the distance between
%               vectors xi and xj).
%
%   code:       integer indicating the specific clustering algorithm that
%               will be used: "1" stands for single link and "2" for complete
%               link.
%
% OUTPUT ARGUMENTS:
%   bel:        NxN dimensional matrix whose i-th row corresponds to the
%               i-th clustering. The bel(i,j) element of the matrix contains
%               the cluster label for the j-th vector in the i-th clustering.
%               The first row of bel corresponds to the N-cluster clustering,
%               the 2nd row corresponds to the clustering where (N-1)-cluster
%               clustering and, finally, the N-th row corresponds to the
%               single-cluster clustering.
%   thres:      N-dimensional vector containing the dissimilarity levels
%               where each new clustering is formed.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[N,N]=size(prox_mat);
thres=[];
bel=zeros(N,N);
bel(1,:)=1:1:N;

for i=2:N
    [q1,q2]=min(prox_mat+10^10*(prox_mat==0));
    [r1,r2]=min(q1);
    merge_pair=[min(q2(r2),r2) max(q2(r2),r2)];
    thres=[thres r1];
    temp=bel(i-1,:);
    temp(temp==merge_pair(2))=merge_pair(1);
    temp=temp.*(temp<=merge_pair(2))+(temp-1).*(temp>merge_pair(2));
    bel(i,:)=temp;
    if(code==1)
        prox_mat=SL_step(prox_mat,merge_pair);
    elseif(code==2)
        prox_mat=CL_step(prox_mat,merge_pair);
    end
    %pause
end

%Making the dendrogram
for i=1:N
    for j=1:N
        cluster{i,j}=find(bel(i,:)==j);
    end
end