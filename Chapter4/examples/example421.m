% Example 4.2.1
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear;

% 1. Generate the data set.
randn('seed',0);
m=1; var=0.16;
stdevi=sqrt(var);
norm_dat=m+stdevi*randn(1,100);

%2. Generate the outliers.
outl=[6.2 -6.4 4.2 15.0 6.8];

% 3. Add outliers at the end of the data
dat=[norm_dat';outl'];

% 4. Scramble the data
rand('seed',0); % randperm() below calls rand()
y=randperm(length(dat));x=dat(y);

% 5. Identify outliers and their corresponding indices
times=1; % controls the tolerance threshold
[outliers,Index,new_dat]=simpleOutlierRemoval(x,times);
[outliers Index]
