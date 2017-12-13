% Example 1.10.1
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear;

% Generate datasets X1 and X2
m=[0 0; 1 2]';
S=[0.8 0.2;0.2 0.8];
S(:,:,1)=S;S(:,:,2)=S;
P=[1/2 1/2 ]'; N_1=1000;
randn('seed',0);
[X1,y1]=generate_gauss_classes(m,S,P,N_1);
N_2=5000;
randn('seed',100);
[X2,y2]=generate_gauss_classes(m,S,P,N_2);

% For the classification task, use function k_nn_classifier (k=3)
k=3;
z=k_nn_classifier(X1,y1,k,X2);

% Compute the classification error
pr_err=sum(z~=y2)/length(y2)
