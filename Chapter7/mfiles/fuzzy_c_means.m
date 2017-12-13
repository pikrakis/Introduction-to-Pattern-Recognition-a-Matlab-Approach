function [theta,U,obj_fun]=fuzzy_c_means(X,m,q)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%  [w, U, obj_fun]=fuzzy_c_means(X,m,q)
% This function applies the FCM algorithm by calling the corresponding
% MATLAB function, called "fcm". 
%
% INPUT ARGUMENTS:
%  X:   lxN matrix, each column of which corresponds to
%       an l-dimensional data vector.
%  m:   the number of clusters.
%  q:   the fuzzifier.
% 
% OUTPUT ARGUMENTS:
%  theta:   lxm matrix, each column of which corresponds to
%           a cluster representative, after the convergence of the
%           algorithm. 
%  U:       Nxm matrix containing in its i-th row
%           the ``grade of membership'' of the data vector xi to the m
%           clusters.  
%  obj_fun: a vector, whose t-th coordinate is the value of the cost
%           function, J, for the clustering produced at the t-th teration.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


X=X';
options(1)=q;
[theta,U,obj_fun] = fcm(X,m,options);
theta=theta';
U=U';