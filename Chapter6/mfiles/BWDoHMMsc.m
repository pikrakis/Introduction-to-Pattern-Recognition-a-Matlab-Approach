function [MatchingProb,c]=BWDoHMMsc(pi_init,A,B,O)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [MatchingProb,c]=BWDoHMMsc(pi_init,A,B,O)
% Implements the scaled Baum-Welch (any-path) algorithm for
% discrete-observation HMMs.
%
% INPUT ARGUMENTS:
%   pi_init:        vector of initial state probalities.
%   A:              state transition matrix. The sum of each row equals 1.
%   B:              observation probability matrix (one state per column). The sum of each column equals 1.
%   O:              observation sequence, i.e., sequence of symbol ids.
%
% OUTPUT ARGUMENTS:
%   MatchingProb:   scaled recognition probability of the observation sequence.
%   c:              sequence of scaling coefficients (auxiliary output).
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Initialization
T=length(O);
[M,N]=size(B);

alpha(:,1)=pi_init .* B(O(1),:)';
c(1)=1/(sum(alpha(:,1)));
alpha(:,1)=c(1)*alpha(:,1);

for t=2:T
    for i=1:N
        alpha(i,t)=sum((alpha(:,t-1).* A(:,i)) * B(O(t),i));        
    end
    c(t)=1/(sum(alpha(:,t)));
    alpha(:,t)=c(t)*alpha(:,t);
end

[MatchingProb]=-sum(log10(c));

