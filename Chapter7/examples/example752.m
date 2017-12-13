% Example 7.5.2
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear

% 1. To generate the first 400 points of X4, work as in Example 7.5.1.
randn('seed',0)
m=[0 0; 10 0; 0 9; 9 8];
S(:,:,1)=eye(2);
S(:,:,2)=[1.0 .2; .2 1.5];
S(:,:,3)=[1.0 .4; .4 1.1];
S(:,:,4)=[.3 .2; .2 .5];
n_points=100*ones(1,4); 
X4=[];
for i=1:4
    X4=[X4; mvnrnd(m(i,:),S(:,:,i),n_points(i))];
end
X4=X4';

% Generate the remaining 100 points
noise=rand(2,100)*14-2;
X4=[X4 noise];

% Plot the data set
figure(1), plot(X4(1,:),X4(2,:),'.b')
figure(1), axis equal

% To apply the k-means algorithm for m = 4, work as in step 2 of Example 7.5.1.
m=4;
[l,N]=size(X4);
rand('seed',0)
theta_ini=rand(l,m);
[theta,bel,J]=k_means(X4,theta_ini);

% Plot the clusters
figure(2), hold on
figure(2), plot(X4(1,bel==1),X4(2,bel==1),'r.',...
X4(1,bel==2),X4(2,bel==2),'g*',X4(1,bel==3),X4(2,bel==3),'bo',...
X4(1,bel==4),X4(2,bel==4),'cx',X4(1,bel==5),X4(2,bel==5),'md',...
X4(1,bel==6),X4(2,bel==6),'yp',X4(1,bel==7),X4(2,bel==7),'ks')
figure(2), plot(theta(1,:),theta(2,:),'k+')
figure(2), axis equal
