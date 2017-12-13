function [y]=mixture_Bayes(m,S,P,P_cl,X)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [y]=mixture_Bayes(m,S,P,P_cl,X)
% Bayesian classification rule for c classes, whose pdfs are mixtures of
% normal distributions.
%
% INPUT ARGUMENTS:
%   m:  cl-dimensional cell array, whose i-th element is an lxci
%       array. The j-th column of the later corresponds to the mean of
%       the j-th normal distribution involved in the mixture for the
%       pdf of the i-th class.
%   S:  cl-dimensional cell array, whose i-th element is an lxlxci
%       array. The j-th "slice" of the later corresponds to the
%       covariance matrix of the j-th normal distribution involved in
%       mixture for the pdf of the i-th class.
%   P:  cl-dimensional cell array, whose i-th element is a ci
%       dimensional array containing the mixing probabilities of the
%       normal distributions for the pdf of the i-th class.
%   P_cl: cl-dimensional array whose i-th component is the a priori
%         probability of the i-th class.
%   X:    lxN matrix X, whose i-th column corresponds to
%         an l-dimensional data vector.
%
% OUTPUT ARGUMENTS:
%   y:    N-dimensional array, whose i-th component is the label of
%         the class where the i-th data vector of X has been assigned.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cl=length(m);
[l,N]=size(X);

y=[];
for i=1:N
    temp=[];
    for j=1:cl
        t=mixt_value(m{j},S{j},P{j},X(:,i));
        temp=[temp t];
    end
    temp=P_cl.*temp;
    [q1,q2]=max(temp);
    y=[y q2];
end

