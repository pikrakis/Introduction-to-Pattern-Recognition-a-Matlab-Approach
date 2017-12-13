function [X,y]=generate_gauss_classes(m,S,P,N)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [X,y]=generate_gauss_classes(m,S,P,N)
% Generates a set of points that stem from c classes, given 
% the corresponding a pricori class probabilities and assuming that each 
% class is modeled by a Gaussian distribution (also used in Chapter 2).
% 
% INPUT ARGUMENTS:
%   m:  lxc matrix, whose j-th column corresponds to the mean of 
%       the j-th class.
%   S:  lxlxc matrix. S(:,:,j) is the covariance matrix of the j-th normal 
%       distribution.
%   P:  c-dimensional vector whose j-th component is the a priori
%       probability of the j-th class.
%   N:  total number of data vectors to be generated.
%
% OUTPUT ARGUMENTS:
%   X:  lxN matrix, whose columns are the produced data vectors.
%   y:  N-dimensional vector whose i-th component contains the label
%       of the class where the i-th data vector belongs.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[l,c]=size(m);
X=[];
y=[];
for j=1:c
% Generating the [p(j)*N] vectors from each distribution
   t=mvnrnd(m(:,j),S(:,:,j),fix(P(j)*N))';
   % The total number of data vectors may be slightly less than N due to
   % the fix operator
   X=[X t];
   y=[y ones(1,fix(P(j)*N))*j];
end
