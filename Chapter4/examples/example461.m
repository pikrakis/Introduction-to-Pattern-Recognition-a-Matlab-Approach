% Example 4.6.1
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear;

% 1. Generate the data vectors from the first class
N=200;

randn('seed',0)
m1=[1 1 0 6 3];
S1=diag([.06 .5 3 .001 3]);
class1=mvnrnd(m1,S1,fix(N/2))';

% The data vectors of the second class are generated similarly.

m2 = [11.5, 11, 10, 6.5, 4];
S2=diag([.06 .6 4 .001 4]);
class2=mvnrnd(m2,S2,fix(N/2))';

% 2. Compute the FDR for each feature
l=length(m1);
for i=1:l
    FDR(i)= Fisher(class1(i,:)',class2(i,:)');
end
FDR