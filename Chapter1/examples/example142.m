% Example 1.4.2
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear;

% Generate dataset X
randn('seed',0);
m = [2 -2]; S = [0.9 0.2; 0.2 .3];
X = mvnrnd(m,S,50)';

% Compute the ML estimates of m and S
[m_hat, S_hat]=Gaussian_ML_estimate(X)