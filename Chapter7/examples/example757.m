% Example 7.5.7
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear;

% 1. Generate and plot the data set X7
randn('seed',0)
m=[0 0; 13 13; 0 -40; -30 -30]'; %means
[l,n_cl]=size(m);
S=eye(2); %covariance matrix
n_points=[100 100 8 8]; %points per distribution
X7=[];
for i=1:n_cl
    X7=[X7; mvnrnd(m(:,i)',S,n_points(i))];
end
X7=X7';
figure(1), plot(X7(1,:),X7(2,:),'.b')

% 2. Apply the k-means algorithm on X7
m=2;
[l,N]=size(X7);
rand('seed',0)
theta_ini=rand(l,m);
[l,m]=size(theta_ini);
[theta,bel,J]=k_means(X7,theta_ini);

% Plot X7, using different colors for points from different clusters
figure(2), hold on
figure(2), plot(X7(1,bel==1),X7(2,bel==1),'r.',...
    X7(1,bel==2),X7(2,bel==2),'g*',X7(1,bel==3),X7(2,bel==3),'bo',...
    X7(1,bel==4),X7(2,bel==4),'cx',X7(1,bel==5),X7(2,bel==5),'md',...
    X7(1,bel==6),X7(2,bel==6),'yp',X7(1,bel==7),X7(2,bel==7),'ks')
figure(2), plot(theta(1,:),theta(2,:),'k+')
figure(2), axis equal


% Apply the FCM algorithm on X7
q=2;
[theta,U,obj_fun] = fuzzy_c_means(X7,m,q)
% Obtain a hard clustering using U
[qw,bel]=max(U');

% Plot X7, using different colors for points from different clusters
figure(3), hold on
figure(3), plot(X7(1,bel==1),X7(2,bel==1),'r.',...
    X7(1,bel==2),X7(2,bel==2),'g*',X7(1,bel==3),X7(2,bel==3),'bo',...
    X7(1,bel==4),X7(2,bel==4),'cx',X7(1,bel==5),X7(2,bel==5),'md',...
    X7(1,bel==6),X7(2,bel==6),'yp',X7(1,bel==7),X7(2,bel==7),'ks')
figure(3), plot(theta(1,:),theta(2,:),'k+')
figure(3), axis equal
