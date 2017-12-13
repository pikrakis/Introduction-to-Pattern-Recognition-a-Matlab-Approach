% Example 3.3.1
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

% Note: this example takes a long time to execute.
close('all');
clear;

% To generate matrix X, containing the vectors of the data set, type
N=100;
l=2000;
mv=zeros(1,l);
S=0.1*eye(l);
S(1,1)=10000;
S(2,2)=10000;
randn('seed',0)
X=mvnrnd(mv,S,N)';

% To run PCA and SVD on X and to measure the execution time of each method type
% PCA
t0=clock;
m=5;
[eigenval,eigenvec,explain,Y]=pca_fun(X,m);
time_PCA=etime(clock,t0)
% SVD
t0=clock;
m=min(N,l);
[U,S,V,Y]=svd_fun(X,m);
time_SVD=etime(clock,t0)

% Uncomment the last line of code to compare the first two columns of eigenvec, produced by PCA,
% with the first two columns of U, produced by SVD, by typing

% [eigenvec(:,1:2) U(:,1:2)]'
