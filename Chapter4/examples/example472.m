% Example 4.7.2
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear;

% 1. Generate data for the two classes
m1=[3 3]';S1=0.2*eye(2);
m2=[2.2 2.2]';S2=1.9*eye(2);
randn('seed',0);
class1=mvnrnd(m1,S1,100)';
randn('seed',100);
class2=mvnrnd(m2,S2,100)';

% 2. Compute the Bhattacharyya distance and the Chernoff bound
BhattaDistance=divergenceBhata (class1,class2)
ChernoffBound=0.5*exp(-BhattaDistance)