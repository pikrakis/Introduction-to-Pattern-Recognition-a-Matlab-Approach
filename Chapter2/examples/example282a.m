% Example 2.8.2, cases 1 and 2
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear;

randn('seed',0);
% 1. Generate the training data set (X1)
l=2; %Dimensionality
m1=[-10 0; 0 -10; 10 0; 0 10]'; % centroids of the first class
m2=[-10 -10; 0 0; 10 -10; -10 10;10 10]'; % centroids of the second class 
[l,c1]=size(m1); 
[l,c2]=size(m2);

P1=ones(1,c1)/c1;
P2=ones(1,c2)/c2;

% Generate data for the first class of the training set
N1=80; % Approximately 20 for each one of the four clusters
s=4;
for i=1:c1
    S1(:,:,i)=s*eye(l);
end
sed=0; %Random generator seed
[class1_X,class1_y]=mixt_model(m1,S1,P1,N1,sed);

% Generate data for the second class of X1
N2=100; % Approximately 20 for each one of the four clusters
for i=1:c2
    S2(:,:,i)=s*eye(l);
end
sed=0; %Random generator seed
[class2_X,class2_y]=mixt_model(m2,S2,P2,N2,sed);

% Merge the data of the two classes to form the training set
X1=[class1_X  class2_X]; 
y1=[ones(1,N1) -ones(1,N2)]; 
figure(1), hold on
figure(1), plot(X1(1,y1==1),X1(2,y1==1),'r.',X1(1,y1==-1),X1(2,y1==-1),'bx')

% 1. Generate test set (X2)
% Generate data for the first class of X2
sed=100; 
[class1_X,class1_y]=mixt_model(m1,S1,P1,N1,sed);

% Generate data for the second class of X2
sed=100; 
[class2_X,class2_y]=mixt_model(m2,S2,P2,N2,sed);

% Form X2
X2=[class1_X  class2_X]; 
y2=[ones(1,N1) -ones(1,N2)]; 

% 2. 
iter=10000; %Number of iterations
code=3; %Code for the chosen training algorithm (adaptive BP)
k=3; %number of hidden layer nodes. Also use 4 and 10 nodes
lr=.01; %learning rate
par_vec=[lr 0 1.05 0.7 1.04]; %Parameter vector
[net,tr]=NN_training(X1,y1,k,code,iter,par_vec);

% Compute the training and test errors
pe_train=NN_evaluation(net,X1,y1)
pe_test=NN_evaluation(net,X2,y2)

% Plot the data points as well as the decision regions of the FNN
maxi=max(max([X1'; X2']));
mini=min(min([X1'; X2']));
bou=[mini maxi];
fig_num=2; % figure handle
resolu=(bou(2)-bou(1))/100; % figure resolution
plot_NN_reg(net,bou,resolu,fig_num); % plot decision region
figure(fig_num), hold on % plot training set
figure(fig_num), plot(X1(1,y1==1),X1(2,y1==1),'r.', X1(1,y1==-1),X1(2,y1==-1),'bx')

% Plot the training error versus the number of iterations
figure(3), plot(tr.perf)
