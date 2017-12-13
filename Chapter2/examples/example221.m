% Example 2.2.1
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear

rand('seed',0);

% Generate the dataset X1 as well as the vector containing the class labels of
% the points in X1 
N=[100 100]; % 100 vectors per class
l=2; % Dimensionality of the input space

x=[3 3]';
% x=[2 2]'; for X2
% x=[0 2]'; for X3
% x=[1 1]'; for X4

X1=[2*rand(l,N(1)) 2*rand(l,N(2))+x*ones(1,N(2))];
X1=[X1; ones(1,sum(N))];
y1=[-ones(1,N(1)) ones(1,N(2))];

% 1. Plot X1, where points of different classes are denoted by different colors,
figure(1), plot(X1(1,y1==1),X1(2,y1==1),'bo',...
X1(1,y1==-1),X1(2,y1==-1),'r.')
figure(1), axis equal

% 2. Run the perceptron algorithm for X1 with learning parameter 0.01
rho=0.01; % Learning rate
w_ini=[1 1 -0.5]';
[w,iter,mis_clas]=perce(X1,y1,w_ini,rho)

