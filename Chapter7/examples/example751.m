% Example 7.5.1
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

% NOTE: this example generates a total of six figures.
close('all');
clear

% 1. To generate and plot X3, work as in Example 7.4.2, where now the means
% of the Gaussians are different. The plot shows that X3 contains four
% clearly separated compact clusters.

randn('seed',0)
m=[0 0; 10 0; 0 9; 9 8];
S(:,:,1)=eye(2);
S(:,:,2)=[1.0 .2; .2 1.5];
S(:,:,3)=[1.0 .4; .4 1.1];
S(:,:,4)=[.3 .2; .2 .5];
n_points=100*ones(1,4); %Number of points per group
X3=[];
for i=1:4
    X3=[X3; mvnrnd(m(i,:),S(:,:,i),n_points(i))];
end
X3=X3';

figure(1), plot(X3(1,:),X3(2,:),' b.')
figure(1), axis equal

% 2. To apply the k-means algorithm, for m = 4 and random initialization
m=4;
[l,N]=size(X3);
rand('seed',0)
theta_ini=rand(l,m);
[theta,bel,J]=k_means(X3,theta_ini);

% Plot X3, using different colors for points from different clusters
figure(2), hold on
figure(2), plot(X3(1,bel==1),X3(2,bel==1),'r.',...
X3(1,bel==2),X3(2,bel==2),'g*',X3(1,bel==3),X3(2,bel==3),'bo',...
X3(1,bel==4),X3(2,bel==4),'cx',X3(1,bel==5),X3(2,bel==5),'md',...
X3(1,bel==6),X3(2,bel==6),'yp',X3(1,bel==7),X3(2,bel==7),'ks')
figure(2), plot(theta(1,:),theta(2,:),'k+')
figure(2), axis equal

%  3. Work as in step 2, for m = 3
m=3;
[l,N]=size(X3);
rand('seed',0)
theta_ini=rand(l,m);
[theta,bel,J]=k_means(X3,theta_ini);
figure(3), hold on
figure(3), plot(X3(1,bel==1),X3(2,bel==1),'r.',...
X3(1,bel==2),X3(2,bel==2),'g*',X3(1,bel==3),X3(2,bel==3),'bo',...
X3(1,bel==4),X3(2,bel==4),'cx',X3(1,bel==5),X3(2,bel==5),'md',...
X3(1,bel==6),X3(2,bel==6),'yp',X3(1,bel==7),X3(2,bel==7),'ks')
figure(3), plot(theta(1,:),theta(2,:),'k+')
figure(3), axis equal

% 4. Work as in step 2, for m = 5
m=5;
[l,N]=size(X3);
rand('seed',0)
theta_ini=rand(l,m);
[theta,bel,J]=k_means(X3,theta_ini);
figure(4), hold on
figure(4), plot(X3(1,bel==1),X3(2,bel==1),'r.',...
X3(1,bel==2),X3(2,bel==2),'g*',X3(1,bel==3),X3(2,bel==3),'bo',...
X3(1,bel==4),X3(2,bel==4),'cx',X3(1,bel==5),X3(2,bel==5),'md',...
X3(1,bel==6),X3(2,bel==6),'yp',X3(1,bel==7),X3(2,bel==7),'ks')
figure(4), plot(theta(1,:),theta(2,:),'k+')
figure(4), axis equal
    
% 5. Work as in step 2 with different theta_ini
m=4;
[l,N]=size(X3);
theta_ini=[-2 -2; -2.1 -2.1; -2 -2.2; -2.1 -2.2]';
[theta,bel,J]=k_means(X3,theta_ini);
figure(5), hold on
figure(5), plot(X3(1,bel==1),X3(2,bel==1),'r.',...
X3(1,bel==2),X3(2,bel==2),'g*',X3(1,bel==3),X3(2,bel==3),'bo',...
X3(1,bel==4),X3(2,bel==4),'cx',X3(1,bel==5),X3(2,bel==5),'md',...
X3(1,bel==6),X3(2,bel==6),'yp',X3(1,bel==7),X3(2,bel==7),'ks')
figure(5), plot(theta(1,:),theta(2,:),'k+')
figure(5), axis equal

% 6. 
m=4;
[l,N]=size(X3);
rand('seed',0)
theta_ini=rand(l,m);
theta_ini(:,m)=[20 20];
[theta,bel,J]=k_means(X3,theta_ini);
figure(6), hold on
figure(6), plot(X3(1,bel==1),X3(2,bel==1),'r.',...
X3(1,bel==2),X3(2,bel==2),'g*',X3(1,bel==3),X3(2,bel==3),'bo',...
X3(1,bel==4),X3(2,bel==4),'cx',X3(1,bel==5),X3(2,bel==5),'md',...
X3(1,bel==6),X3(2,bel==6),'yp',X3(1,bel==7),X3(2,bel==7),'ks')
figure(6), plot(theta(1,:),theta(2,:),'k+')
figure(6), axis equal
