function [z]=euclidean_classifier(m,X)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [z]=euclidean_classifier(m,X)
% Euclidean classifier for the case of c classes.
%
% INPUT ARGUMENTS:
%   m:  lxc matrix, whose i-th column corresponds to the mean of the i-th
%       class.
%   X:  lxN matrix whose columns are the data vectors to be classified.
%
% OUTPUT ARGUMENTS:
%   z:  N-dimensional vector whose i-th element contains the label
%       of the class where the i-th data vector has been assigned.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[l,c]=size(m);
[l,N]=size(X);

for i=1:N
    for j=1:c
        de(j)=sqrt((X(:,i)-m(:,j))'*(X(:,i)-m(:,j)));
    end
    [num,z(i)]=min(de);
end
