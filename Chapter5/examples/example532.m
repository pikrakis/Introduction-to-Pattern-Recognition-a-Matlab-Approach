% Example 5.3.2
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear;

%To compute the matching cost for the two unknown patterns using the standard
% Itakura local constraints, use function DTWItakura and type
P=[1,0,1]; % reference sequence
T1=[1,1,0,0,0,1,1,1]; % first test sequence
T2=[1,1,0,0,1]; % second test sequence
figure(1);
[MatchCost1,BestPath1,D1,Pred1]=DTWItakura(P,T1,1);
MatchCost1

figure(2);
[MatchCost2,BestPath2,D2,Pred2]=DTWItakura(P,T2,1);
MatchCost2