function [w]=distant_init(X,m,sed)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION (auxiliary)
%  [w]=distant_init(X,m,sed)
% This function chooses the m "most distant" from each other vectors among the
% N vectors contained in a data set X. Specifically, the mean vector of
% the N data vectors of a set X is computed and the vector of X that lies
% furthest from the mean is assigned first to the set W containing the "most
% distant" points. The i-th element of W is selected via the following
% steps:
% (a) the minimum distance of each of the N-i+1 points of X-W from
% the i-1 vectors in W is computed.
% (b) the point with the maximum of the above N-i+1 computed minimum
% distances joins W as its i-th element.
%
% INPUT ARGUMENTS:
%   X:      lxN matrix, whose columns are the data vectors.
%   m:      the number of vectors to be selected.
%   sed:    the seed for the random number generator (in this case it does
%           not affect the results of the algorihm).
%
% OUTPUT ARGUMENTS:
%   w:      lxm matrix, whose columns are the selected "most
%           distant" vectors.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[l,N]=size(X);

mea=(mean(X'))';  %The mean of the data set
[q1,q2]=max(sum(((X'-ones(N,1)*mea')').^2)); %The most distant vector of X from its mean

indi=[q2];  % List of the indices of the most distant vectors
w=X(:,q2);
[r1,r2]=size(w);

for i=1:m-1
    dista=[];  %Determination of each vector from the most distant vectors found so far
    for j=1:r2
        temp=(sum(((X'-ones(N,1)*w(:,j)')').^2));
        dista=[dista; temp];
    end
    dista=min(dista); %Determination of the most distant vector from the rest "most distant" vectors found so far
    [q1,q2]=max(dista);
    indi=[indi q2];
    w=[w X(:,q2)];
    [r1,r2]=size(w);
end