% Example 2.3.1
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear;

% 1.
m(:,1)=[0 0 0 0 0]';
m(:,2)=[1 1 1 1 1]';
S=[.9 .3 .2 .05 .02; 
     .3 .8 .1 .2 .05;
     .2 .1 .7 .015 .07; 
     .05 .2 .015 .8 .01; 
     .02 .05 .07 .01 .75];
P=[1/2 1/2];

% Generate X1 and the required class labels
N1=200;
randn('seed',0)
X1=[mvnrnd(m(:,1),S,fix(N1/2)); mvnrnd(m(:,2),S,N1-fix(N1/2))]';
z1=[ones(1,fix(N1/2)) 2*ones(1,N1-fix(N1/2))];

% Generate X2 and the required class labels
N2=200;
% N2=10000 % for X3
% N2=100000 % for X4
randn('seed',100)
X2=[mvnrnd(m(:,1),S,fix(N2/2)); mvnrnd(m(:,2),S,N2-fix(N2/2))]';
z2=[ones(1,fix(N2/2)) 2*ones(1,N2-fix(N2/2))];

% Compute the Bayesian classification error based on X2
S_true(:,:,1)=S;
S_true(:,:,2)=S;
[z]=bayes_classifier(m,S_true,P,X2);
err_Bayes_true=sum(z~=z2)/sum(N2)


% 2. Augment the data vectors of X1 
X1=[X1; ones(1,sum(N1))];
y1=2*z1-3;

% Augment the data vectors of X2
X2=[X2; ones(1,sum(N2))];
y2=2*z2-3;

% Compute the classification error of the LS classifier based on X2
[w]=SSErr(X1,y1,0);
SSE_out=2*(w'*X2>0)-1;
err_SSE=sum(SSE_out.*y2<0)/sum(N2)


