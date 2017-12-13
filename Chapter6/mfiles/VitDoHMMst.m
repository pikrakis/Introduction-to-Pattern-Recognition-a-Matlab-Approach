function [MatchingProb,BestPath]=VitDoHMMst(pi_init,A,B,O)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [MatchingProb,BestPath]=VitDoHMMst(pi_init,A,B,O)
% Implements the standard (nonscaled)  Viterbi algorithm for
% discrete-observation HMMs. Returns the Viterbi score and respective
% best-state sequence.
%
% INPUT ARGUMENTS:
%   pi_init:        vector of initial state probalities.
%   A:              state transition matrix. The sum of each row equals 1.
%   B:              observation probability matrix. The sum of each columns equals 1.
%   O:              observation sequence, i.e., sequence of symbol ids.
%
% OUTPUT ARGUMENTS:
%   MatchingProb:   Viterbi score (nonscaled).
%   BestPath:       best-state sequence as a vector of complex numbers. 
%                   For implementation purposes, we have made the assumption 
%                   that the real part of each complex number stands for the 
%                   y-coordinate of the node (state number); the imaginary part, for the
%                   x-coordinate (observation (time) index). Therefore, the real part 
%                   of this output variable is the best-state sequence
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Initialization
T=length(O);
[M,N]=size(B);

% First observation
alpha(:,1)=pi_init .* B(O(1),:)';
Pred(:,1)=zeros(N,1);

% Construct the trellis diagram
for t=2:T
    for i=1:N
        temp=(alpha(:,t-1).*A(:,i))*B(O(t),i);
        [alpha(i,t),ind]=max(temp);
        Pred(i,t)=ind+sqrt(-1)*(t-1);
    end
end

[MatchingProb,WinnerInd]=max(alpha(:,T));
BestPath=BackTracking(Pred,WinnerInd,T,0)';
