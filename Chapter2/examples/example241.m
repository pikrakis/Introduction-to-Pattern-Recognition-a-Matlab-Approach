% Example 2.4.1
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear;

% Generate and plot X1
randn('seed',50)
m=[0 0; 1.2 1.2]'; % mean vectors
S=0.2*eye(2); % covariance matrix
points_per_class=[200 200];
X1=mvnrnd(m(:,1),S,points_per_class(1))';
X1=[X1 mvnrnd(m(:,2),S,points_per_class(2))'];
y1=[ones(1,points_per_class(1)) -ones(1,points_per_class(2))];

figure(1), plot(X1(1,y1==1),X1(2,y1==1),'r.', X1(1,y1==-1),X1(2,y1==-1),'bo')

% Generate X2
randn('seed',100)
X2=mvnrnd(m(:,1),S,points_per_class(1))';
X2=[X2 mvnrnd(m(:,2),S,points_per_class(2))'];
y2=[ones(1,points_per_class(1)) -ones(1,points_per_class(2))];

% Generate the required SVM classifier
kernel='linear';
kpar1=0;
kpar2=0;
C=0.1; 
% C=0.2;
% C= 0.5;
% C=1;
% C=2;
% C=20;
tol=0.001;
steps=100000;
eps=10^(-10);
method=0;
[alpha, w0, w, evals, stp, glob] = SMO2(X1', y1',kernel, kpar1, kpar2, C, tol, steps, eps, method);

% Compute the classification error on the training set
Pe_tr=sum((2*(w*X1-w0>0)-1).*y1<0)/length(y1)

% Compute the classification error on the test set
Pe_te=sum((2*(w*X2-w0>0)-1).*y2<0)/length(y2)

% Plot the classifier hyperplane
global figt4
figt4=2;
svcplot_book(X1',y1',kernel,kpar1,kpar2,alpha,-w0)

% Count the support vectors
sup_vec=sum(alpha>0)

% Compute the margin
marg=2/sqrt(sum(w.^2))

