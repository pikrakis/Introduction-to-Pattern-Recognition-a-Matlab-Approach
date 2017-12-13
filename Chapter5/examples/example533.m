% Example 5.3.3
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear;

% 1. Compute the matching cost by adopting the Sakoe-Chiba local constraints
P=[-8,-4,0,4,0,-4];
T=[0,-8,-4,0,4,0,-4,0,0];
figure(1)
[MatchingCost,BestPath,D,Pred]=DTWSakoe(P,T,1);
MatchingCost

% 2. Repeat step 1 by allowing for endpoint constraints. More specifically, at
% most two symbols can be omitted from each endpoint of T. Use function DTWSakoeEndp
P=[-8,-4,0,4,0,-4];
T=[0,-8,-4,0,4,0,-4,0,0];
figure(2)
[MatchingCost,BestPath,D,Pred]=DTWSakoeEndp(P,T,2,2,1);
MatchingCost

