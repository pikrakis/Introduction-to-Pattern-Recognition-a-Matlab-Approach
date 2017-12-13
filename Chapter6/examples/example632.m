% Example 6.3.2
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear;

% First HMM
pi1 = [0.7 0.3]';
A1 = [0.7 0.3;0.7 0.3];
B1 = [0.8 0.3;0.2 0.7];

% Second HMM
pi2 = pi1;
A2 = [0.6 0.4;0 1];
B2 = B1;

O = [1 1 1 2 1 1 1 1 2 1 1 1 1 2 2 1 1];

[Score1, BestPath1] = VitDoHMMst(pi1,A1,B1,O);
[Score2, BestPath2] = VitDoHMMst(pi2,A2,B2,O);
BestStateSeq1 = real(BestPath1);
BestStateSeq2 = real(BestPath2);

Score1, Score2, BestStateSeq1, BestStateSeq2

[Score1, BestPath1] = VitDoHMMsc(pi1,A1,B1,O);
[Score2, BestPath2] = VitDoHMMsc(pi2,A2,B2,O);
BestStateSeq1 = real(BestPath1);
BestStateSeq2 = real(BestPath2);

Score1, Score2, BestStateSeq1, BestStateSeq2
