function [Sw,Sb,Sm]=scatter_mat(X,y)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [Sw,Sb,Sm]=scatter_mat(X,y)
% Computes the within scatter matrix, the between scatter
% matrix and the mixture scatter matrix for a c-class classification
% problem, based on a given data set.
%
% INPUT ARGUMENTS:
%   X:      lxN matrix whose columns are the data vectors of the data set.
%   y:      N-dimensional vector whose i-th component is the label of
%           the class where the i-th data vector belongs (allowable values
%           are 1,2,...,c).
%
% OUTPUT ARGUMENTS:
%   Sw:     lxl within scatter matrix.
%   Sb:     lxl dimensional between scatter matrix.
%   Sm:     lxl mixture scatter matrix.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


[l,N]=size(X);
c=max(y);

%Computation of class mean vectors, a priori prob. and Sw
m=[];
Sw=zeros(l);
for i=1:c
    y_temp=(y==i);
    X_temp=X(:,y_temp);
    P(i)=sum(y_temp)/N;
    m(:,i)=(mean(X_temp'))';
    Sw=Sw+P(i)*cov(X_temp');
end

%Computation of Sb
m0=(sum(((ones(l,1)*P).*m)'))';
Sb=zeros(l);
for i=1:c
    Sb=Sb+P(i)*((m(:,i)-m0)*(m(:,i)-m0)');
end

%Computation of Sm
Sm=Sw+Sb;
