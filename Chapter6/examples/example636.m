% Example 6.3.6
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear;

% We first create the two HMMs
pi1=[1 0]'; pi2=pi1;
A1=[0.55 0.45; 0.55 0.45]; A2=A1;
B1=[1 1; 3 1]';
B2=[-1 1; 3 2]';

% Observation sequence as follows
O = [1.1 1.0 1.15 0.97 0.98 1.2 1.11 3.01 2.99 2.97 3.1 3.12 2.96];

% We then compute the scaled Viterbi scores, say Pr1 and Pr2, and print the
% results.
[Pr1,bp1] = VitCoHMMsc(pi1,A1,B1,O);
[Pr2,bp2] = VitCoHMMsc(pi2,A2,B2,O);
bs1=real(bp1);
bs2=real(bp2);

Pr1, Pr2
bs1, bs2

