function [MatchingProb,BestPath]=VitCoHMMst(pi_init,A,B,O)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [MatchingProb,BestPath]=VitCoHMMst(pi_init,A,B,O)
% Implements the nonscaled  Viterbi algorithm for
% continuous-observation HMMs, for the case of l-dimensional observations
% (l-dimensional feature vectors). It is assumed that the observation pdf at each state
% is a Gaussian mixture.
%
% INPUT ARGUMENTS:
%   pi_init:        vector of initial state probalities.
%   A:              state transition matrix. The sum of each row equals 1.
%   B:              B can be:
%                   (a) a 2xN standard array, where N is the number of
%                   states. This case deals with 1-dimensional
%                   observations, i.e., 
%                   B(1,i) contains the mean value and B(2,i) the standard 
%                   deviation of the Gaussian that describes the 1-dimensional 
%                   pdf of the respective state observations.
%                   (b) a 3xN cell array, where N is the number of states.
%                   In this case, the pdf at each state is a gaussian
%                   mixture and the observations are l-dimensional feature
%                   vectors. Specifically: B{1,i} is a lxc matrix, whose columns contain the means of
%                   the normal distributions involved in the mixture,
%                   B{2,i} is a lxlxc matrix where S(:,:,k) is the covariance 
%                   matrix of the k-th normal distribution of the mixture
%                   and B{3,i} is a c-dimensional vector containing the mixing probabilities for
%                   the distributions of the mixture at the i-the state.                   
%   O:              sequence of feature vectors (one column per feature vector).
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
T=size(O,2);
[N,N]=size(A);

if ~iscell(B)
    for i=1:N
        alpha(i,1)=pi_init(i)*normpdf(O(:,1),B(1,i),B(2,i));
    end
    Pred(:,1)=zeros(N,1);
    
    % Construct the trellis diagram
    for t=2:T
        for i=1:N
            temp=(alpha(:,t-1).*A(:,i))*normpdf(O(:,t),B(1,i),B(2,i));
            [alpha(i,t),ind]=max(temp);
            Pred(i,t)=ind+sqrt(-1)*(t-1);
        end
    end        
else
    for i=1:N
        alpha(i,1)=pi_init(i)*mixt_value(B{1,i},B{2,i},B{3,i},O(:,1));
    end
    Pred(:,1)=zeros(N,1);
    % Construct the trellis diagram
    for t=2:T
        for i=1:N
            temp=alpha(:,t-1).*A(:,i)*mixt_value(B{1,i},B{2,i},B{3,i},O(:,t));
            [alpha(i,t),ind]=max(temp);
            Pred(i,t)=ind+sqrt(-1)*(t-1);
        end
    end
end

[MatchingProb,WinnerInd]=max(alpha(:,T));
BestPath=BackTracking(Pred,WinnerInd,T,0)';
