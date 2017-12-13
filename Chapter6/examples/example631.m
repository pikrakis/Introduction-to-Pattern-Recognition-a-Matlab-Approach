% Example 6.3.1
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear;

% Create the two HMMs.
% First HMM
A1 = [0.7 0.3;0.7 0.3];
B1 = [0.8 0.3;0.2 0.7];
pi1 = [0.7 0.3]';

% Second HMM
A2 = [0.6 0.4;0 1];
B2 = B1;
pi2 = pi1;

% Rewrite the sequence of heads and tails as a sequence of 1s and 2s, where 1 stands for heads and 2 for
% tails. 
O = [1 1 1 2 1 1 1 1 2 1 1 1 1 2 2 1 1];

% To compute the nonscaled recognition probabilities, say Pr1 and Pr2, use function BWDoHMMst, which
% implements the standard Baum-Welch (any-path) algorithm for discrete-observation HMMs.
[Pr1]=BWDoHMMst(pi1,A1,B1,O);
[Pr2]=BWDoHMMst(pi2,A2,B2,O);

Pr1, Pr2

% To compute the scaled recognition probabilities, use BWDoHMMsc instead of
% BWDoHMMst.

[Pr1]=BWDoHMMsc(pi1,A1,B1,O);
[Pr2]=BWDoHMMsc(pi2,A2,B2,O);

Pr1, Pr2





