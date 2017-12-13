% Example 5.3.1
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear;

%To compute the matching cost for the two unknown patterns using the standard
% Sakoe-Chiba local constraints, use function DTWSakoe and type
P=[-1,-2,0,2]; % reference sequence
T=[-1,-2,-2,0,2]; % test sequence
figure(1);
[MatchingCost,BestPath,D,Pred]=DTWSakoe(P,T,1);

% Repeat the experiment with T = {-1,-2,-2,-2,-2,0,2} 
P=[-1,-2,0,2];
T=[-1,-2,-2,-2,-2,0,2];
figure(2);
[MatchingCost,BestPath,D,Pred]=DTWSakoe(P,T,1);


