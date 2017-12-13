% Example 3.4.1
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear;

randn('seed',0) 
S=[.3 1.5; 1.5 9];
[l,l]=size(S);
mv=[-1 1; 0 0]';
N=200;
X=[mvnrnd(mv(:,1),S,N); mvnrnd(mv(:,2),S,N)]';
y=[ones(1,N), 2*ones(1,N)];

% 1. Estimate the mean vectors of each class using the available samples
mv_est(:,1)=mean(X(:,y==1)')';
mv_est(:,2)=mean(X(:,y==2)')';

% Compute the within scatter matrix
[Sw,Sb,Sm]=scatter_mat(X,y);
w=inv(Sw)*(mv_est(:,1)-mv_est(:,2));

% Plot the dataset
figure(1), plot(X(1,y==1),X(2,y==1),'r.',X(1,y==2),X(2,y==2),'bo')
figure(1), axis equal

% Compute the projections
t1=w'*X(:,y==1);
t2=w'*X(:,y==2);
X_proj1=[t1;t1].*((w/(w'*w))*ones(1,length(t1)));
X_proj2=[t2;t2].*((w/(w'*w))*ones(1,length(t2)));
X_proj=[X_proj1 X_proj2];

%Plot the projections
figure(1), hold on
figure(1), plot(X_proj(1,y==1),X_proj(2,y==1),'y.',X_proj(1,y==2),X_proj(2,y==2),'co')
