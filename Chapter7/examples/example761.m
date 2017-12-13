% Example 7.6.1
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear;

% 1. Generate the first group of points in X8
rand('seed',0);
n_points=[300 200 100 50]; %No of points in the first 3 clusters
noise=.5;
X8=[];
% Construction of the 1st cluster (circle, center (-15,0), R=6)
R=6;
x_center1=-15;
mini=x_center1-R;
maxi=x_center1+R;
step=(maxi-mini)/(n_points(1)-1);
for x=mini:step:maxi
    y1=sqrt(R^2-(x-x_center1)^2)+noise*(rand-.5);
    X8=[X8; x y1];
end

% Generate the second group of data (line segment, endpoints (10,-7), (10,7))
mini=-7;
maxi=7;
step=(maxi-mini)/(n_points(2)-1);
x_coord=10;
for y=mini:step:maxi
    X8=[X8; x_coord+noise*(rand-.5) y+noise*(rand-.5)];
end

% Generate the third group of data (semicircle, center (21,0), R=3;, y<0)
R=3;
x_center=21;
mini=x_center-R;
maxi=x_center+R;
step=(maxi-mini)/(n_points(3)-1);
for x=mini:step:maxi
    y=-sqrt(R^2-(x-x_center)^2)+noise*(rand-.5);
    X8=[X8; x y];
end

% Generate the fourth group of data (archimidis spiral)
asp=0.2;
step=(5*pi)/(n_points(4)-1);
count=0;
x_tot=[];
y_tot=[];
for theta=pi:step:6*pi
    count=count+1;
    r=asp*theta;
    x_tot=[x_tot; r*cos(theta)];
    y_tot=[y_tot; r*sin(theta)];
end
X8=[X8; x_tot y_tot];

% Plot X8
X8=X8';
figure(1), plot(X8(1,:),X8(2,:),'.b')


% 2. Adopt the squared Euclidean distance and apply the VS algorithm on X8,
% for a = 1^2, 1.5^2, 2^2, . . . , 8^2. For the definition of the initial clustering, use
% the output of the BSAS algorithm with theta = 2.5.
theta=2.5;
q=size(X8,2);
order=[];
[bel_ini, m]=BSAS(X8,theta,q,order);

% Apply VS on X8 and plot the clustering results
max_iter=50;
for it=1:.5:8
    a=it^2
    [bel,iter]=valley_seeking(X8,a,bel_ini,max_iter);
    % Plotting of the points of the clusters
    figure(11), close
    figure(11), plot(X8(1,bel==1),X8(2,bel==1),'r.',...
        X8(1,bel==2),X8(2,bel==2),'g*',X8(1,bel==3),X8(2,bel==3),'bo',...
        X8(1,bel==4),X8(2,bel==4),'cx',X8(1,bel==5),X8(2,bel==5),'md',...
        X8(1,bel==6),X8(2,bel==6),'yp',X8(1,bel==7),X8(2,bel==7),'ks')
    fprintf('Press any key to continue\n');
    pause
end
