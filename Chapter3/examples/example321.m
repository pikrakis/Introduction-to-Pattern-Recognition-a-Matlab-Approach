% Example 3.2.1
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear;

% 1. Generate the data set X1
randn('seed',0) ;
S1=[.3 .2; .2 1];
[l,l]=size(S1);
mv=zeros(1,l);
N=500;
m=2;
X1=mvnrnd(mv,S1,N)';

% Apply PCA on X1 and compute the percentage of the total variance explained by each component
[eigenval,eigenvec,explained,Y,mean_vec]=pca_fun(X1,m);

% Plot the data points and the normalized eigenvectors
figure(1), hold on
figure(1), plot(X1(1,:),X1(2,:),'r.')
figure(1), axis equal
figure(1), line([0; eigenvec(1,1)],[0; eigenvec(2,1)])
figure(1), line([0; eigenvec(1,2)],[0; eigenvec(2,2)])

% 2. Generate the data set X2
randn('seed',0) ;
S2=[.3 .2; .2 9];
[l,l]=size(S2);
mv=zeros(1,l);
N=500;
m=2;
X2=mvnrnd(mv,S2,N)';

% Apply PCA on X2 and compute the percentage of the total variance explained by each component
[eigenval,eigenvec,explained,Y,mean_vec]=pca_fun(X2,m);

% Plot the data points and the normalized eigenvectors
figure(2), hold on
figure(2), plot(X2(1,:),X2(2,:),'r.')
figure(2), axis equal
figure(2), line([0; eigenvec(1,1)],[0; eigenvec(2,1)])
figure(2), line([0; eigenvec(1,2)],[0; eigenvec(2,2)])
