function [MatchingProb]=BWDoHMMst(pi_init,A,B,O)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [MatchingProb]=BWDoHMMst(pi_init,A,B,O)
% Implements the (nonscaled) standard Baum-Welch (any-path) algorithm for
% discrete-observation HMMs.
%
% INPUT ARGUMENTS:
%   pi_init:        vector of initial state probalities.
%   A:              state transition matrix. The sum of each row equals 1.
%   B:              observation probability matrix. The sum of each columns equals 1.
%   O:              observation sequence, i.e., sequence of symbol ids.
%
% OUTPUT ARGUMENTS:
%   MatchingProb:   recognition probability of the given observation
%                   sequence (nonscaled).
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initialization
T=length(O);
[M,N]=size(B);

alpha(:,1)=pi_init .* B(O(1),:)';

for t=2:T
    for i=1:N
        alpha(i,t)=sum((alpha(:,t-1).* A(:,i)) * B(O(t),i));        
    end
end

[MatchingProb]=sum(alpha(:,T));
