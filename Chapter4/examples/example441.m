% Example 4.4.1
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear;

% 1. Generate vectors x1 and x2
randn('seed',0)
m1=8.75;
m2=9;
stdevi=sqrt(4);
N=1000;
x1=m1+stdevi*randn(1,N);
x2=m2+stdevi*randn(1,N);

% 2. Apply the t-test. Use MATLAB ttest2 function
rho=0.05
[h] = ttest2(x1,x2,rho)

% 3. Repeat with rho=0.001
rho=0.001
[h] = ttest2(x1,x2,rho)


