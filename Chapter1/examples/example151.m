% Example 1.5.1
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

% Note: This example generates a total of four figures.
close('all');
clear

% 1. To generate X, utilize the function mixt_model
randn('seed',0); 
m1=[1, 1]'; m2=[3, 3]';
m=[m1 m2];
S(:,:,1)=[0.1 -0.08; -0.08 0.2];
S(:,:,2)=[0.1 0; 0 0.1];
P=[1/2 1/2];
N=500;
sed=0; 
[X,y]=mixt_model(m,S,P,N,sed);
figure(1);
plot(X(1,:),X(2,:),'.');

% 2. Repeat step 1 for P1 = 0.85, P2 = 0.15.
randn('seed',0); 
m1=[1, 1]'; m2=[3, 3]';
m=[m1 m2];
S(:,:,1)=[0.1 -0.08; -0.08 0.2];
S(:,:,2)=[0.1 0; 0 0.1];
P=[0.85 0.15];
N=500;
sed=0; 
[X,y]=mixt_model(m,S,P,N,sed);
figure(2);
plot(X(1,:),X(2,:),'.');

% 3. Play by changing the parameters of the covariance matrices and the mixing probabilities P1 and P2.
randn('seed',0); 
m1=[1, 1]'; m2=[3, 3]';
m=[m1 m2];
S(:,:,1)=[0.1 0.08; 0.08 0.2];
S(:,:,2)=[0.1 0; 0 0.1];
P=[0.5 0.5];
N=500;
sed=0; 
[X,y]=mixt_model(m,S,P,N,sed);
figure(3);
plot(X(1,:),X(2,:),'.');

randn('seed',0); 
m1=[1, 1]'; m2=[3, 3]';
m=[m1 m2];
S(:,:,1)=[0.1 0.08; 0.08 0.2];
S(:,:,2)=[0.1 0; 0 0.1];
P=[0.85 0.15];
N=500;
sed=0; 
[X,y]=mixt_model(m,S,P,N,sed);
figure(4);
plot(X(1,:),X(2,:),'.');
