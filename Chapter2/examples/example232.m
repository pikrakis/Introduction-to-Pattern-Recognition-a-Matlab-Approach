% Example 2.3.2
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear;

m=[0 0 0 0 0; 2 2 0 2 2]';
S=[1 0 0 0 0; 0 1 0 0 0; 0 0 10^(-350) 0 0; 0 0 0 1 0; 0 0 0 0 1];
[l,l]=size(S);

% Generate X1
N1=1000;
randn('seed',0)
X1=[mvnrnd(m(:,1),S,fix(N1/2)); mvnrnd(m(:,2),S,N1-fix(N1/2))]';
X1=[X1; ones(1,N1)];
y1=[ones(1,fix(N1/2)) -ones(1,N1-fix(N1/2))];

% Generate X2
N2=10000;
randn('seed',100)
X2=[mvnrnd(m(:,1),S,fix(N2/2)); mvnrnd(m(:,2),S,N2-fix(N2/2))]';
X2=[X2; ones(1,N2)];
y2=[ones(1,fix(N2/2)) -ones(1,N2-fix(N2/2))];

% 1. Compute the condition number of X1*X1'and the solution vector, w, for 
% the original version of the LS classifier
cond_num=cond(X1*X1')
w=SSErr(X1,y1,0)
% Note: cond_num=1.4767e+017 and w is a vector of NaN (Not-A-Number)

% 2. Repeat step 1 for the regularized version of the LS classifier
C=0.1;
cond_num=cond(X1*X1'+C*eye(l+1))
w=SSErr(X1,y1,C)

% 4. Compute the classification error on X2 for the gicen w
SSE_out=2*(w'*X2>0)-1;
err_SSE=sum(SSE_out.*y2<0)/N2

