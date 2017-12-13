% Example 7.5.3
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear

% 1. Generate the data set X5
randn('seed',0)
m=[0 0; 5 5];
S(:,:,1)=1.5*eye(2);
S(:,:,2)=eye(2);
n_points=[500 15];
X5=[];
for i=1:2
    X5=[X5; mvnrnd(m(i,:),S(:,:,i),n_points(i))];
end
X5=X5';

% Plot the dataset
figure(1), plot(X5(1,:),X5(2,:),'.b')
figure(1), axis equal

% 2. Apply the k-means algorithm and plot the results
m=2;
[l,N]=size(X5);
rand('seed',0)
theta_ini=rand(l,m);
[theta,bel,J]=k_means(X5,theta_ini);

% Plot X5, using different colors for points from different clusters
figure(2), hold on
figure(2), plot(X5(1,bel==1),X5(2,bel==1),'r.',...
X5(1,bel==2),X5(2,bel==2),'g*',X5(1,bel==3),X5(2,bel==3),'bo',...
X5(1,bel==4),X5(2,bel==4),'cx',X5(1,bel==5),X5(2,bel==5),'md',...
X5(1,bel==6),X5(2,bel==6),'yp',X5(1,bel==7),X5(2,bel==7),'ks')
figure(2), plot(theta(1,:),theta(2,:),'k+')
figure(2), axis equal
