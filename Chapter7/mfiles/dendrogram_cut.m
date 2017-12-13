function [lambda,cut_point_tot,hist_cut] = dendrogram_cut(bel,prox_mat,fighandle)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%  [lambda,cut_point_tot,hist_cut] = dendrogram_cut(bel,prox_mat)
% This function applies the procedure discussed in the book for
% determining the clusterings of a clustering hierarchy that best fit the
% underlying clustering structure of the data set at hand. Also, it
% provides a histogram with the frequency of selection of a clustering in
% the clustering hierarchy, as the lambda parameter varies.
%
% INPUT ARGUMENTS:
%  prox_mat:    NxN dissimilarity matrix for the N vectors
%               of the data set at hand (prox_mat(i,j) is the distance between
%               vectors xi and xj).
%
%  bel:         NxN matrix whose i-th row corresponds to the
%               i-th clustering. The bel(i,j) element of the matrix contains
%               the cluster label for the j-th vector in the i-th clustering.
%               The first row of bel corresponds to the N-cluster clustering,
%               the 2nd row corresponds to the (N-1)-cluster clustering and,
%               finally, the N-th row corresponds to the single-cluster
%               clustering.
%  fighandle:   figure handle, used to plot the results. If omitted, it is
%               set to 1.
%
% OUTPUT ARGUMENTS:
%  lambda:      a vector of the values of the lambda parameter for which a
%               clustering other than the 1-cluster and the N-cluster
%               clusterings is obtained.
%
%  cut_point_tot: the index of the clustering selected for a given value
%                 of lambda
%
%  hist_cut: a vector whose t-th component contains the number of times
%           the t-th clustering has been selected (1-cluster and N-cluster
%           clusterings are excluded).
%
%  NOTE:   The function also plots the corresponding histogram.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[N,N]=size(prox_mat);

%Put all distances to a vector form
dist_vec=[];
for i=1:N-1
    dist_vec=[dist_vec prox_mat(i,i+1:N)];
end

cut_point_tot=[];

mean_dist=mean(dist_vec);  %The mean of non-zero distances
std_dist=std(dist_vec);    %The standard deviation of non-zero distances

lambda_min=-3;
lambda_max=3;
lambda_step=.01;

for lambda=lambda_min:lambda_step:lambda_max   % The parameter involved in the definition of the threshold
    
    theta=mean_dist + lambda*std_dist;  %The external threshold theta
    
    cut_point=N;  % The level where the dendrogram will be cut
    
    clust_el_old=ones(1,N);
    
    for i=2:N
        
        for j=1:N % for each cluster determine the number of elements
            clust_el(j)=sum(bel(i,:)==j);
        end
        
        [vali,id(i)]=max((clust_el-clust_el_old).*(clust_el>0));  %Identify the newly formed cluster
        
        list=find(bel(i,:)==id(i)); %Identifying the vectors that belong to the newly formed cluster.
        
        % Determination of the h parameter of the newly formed cluster
        dist_list=[];
        for k=1:length(list)
            for q=k+1:length(list)
                dist_list=[dist_list prox_mat(list(k),list(q))];
            end
        end
        h(id(i))=max(dist_list);   %median(dist_list);
        
        if(h(id(i))>theta)
            cut_point=i-1;
            break
        end
        clust_el_old=clust_el;
    end
    
    cut_point_tot=[cut_point_tot cut_point];
end

all_clust=sum(cut_point_tot==1);
one_clust=sum(cut_point_tot==N);

le=length(cut_point_tot);
temp=cut_point_tot(all_clust+1:le-one_clust);
cut_point_tot=temp;
hist_cut=hist(temp,N-2);

lambda=lambda_min:lambda_step:lambda_max;
lambda=lambda(all_clust+1:le-one_clust);

qwe=[];
for i=2:N-1
    t=sum(cut_point_tot==i)/601;
    qwe=[qwe t];
end

te=1:1:length(qwe);
x_axis=N-te;
if nargin==2
    fighandle=1;
end
figure(fighandle), plot(x_axis, qwe,'*')
figure(fighandle), axis([1 N 0 .4])
figure(fighandle), hold on
for i=1:length(qwe)
    figure(fighandle), line([x_axis(i) x_axis(i)],[0 qwe(i)])
end
