% Example 7.5.4
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear

% 1. Generate the first cluster of points of the data set X6
rand('seed',0)
n_points=[600 200 200 100]; %Points per cluster
noise=.5;
X6=[];
% Construction of the 1st cluster (circle, center (0,0), R=6)
R=6;
mini=-R;
maxi=R;
step=(maxi-mini)/(fix(n_points(1)/2)-1);
for x=mini:step:maxi
    y1=sqrt(R^2-x^2)+noise*(rand-.5);
    y2=-sqrt(R^2-x^2)+noise*(rand-.5);
    X6=[X6; x y1; x y2];
end

% Generate the second cluster of points of X6 (ellipse, centered at (0,0), a=3,b=1))
a=3;
b=1;
mini=-a;
maxi=a;
step=(maxi-mini)/(fix(n_points(2)/2)-1);
for x=mini:step:maxi
    y1=b*sqrt(1-x^2/a^2)+noise*(rand-.5);
    y2=-b*sqrt(1-x^2/a^2)+noise*(rand-.5);
    X6=[X6; x y1; x y2];
end

% Generate the third cluster of points of X6 (line segment, endpoints (8,-7), (8,7))
mini=-7;
maxi=7;
step=(maxi-mini)/(n_points(3)-1);
x_coord=8;
for y=mini:step:maxi
    X6=[X6; x_coord+noise*(rand-.5) y+noise*(rand-.5)];
end

% Finally, generate the fourth cluster of points of X6 (semicircle, center (13,0), R=3;, y<0)
R=3;
x_center=13;
mini=x_center-R;
maxi=x_center+R;
step=(maxi-mini)/(n_points(4)-1);
for x=mini:step:maxi
    y=-sqrt(R^2-(x-x_center)^2)+noise*(rand-.5);
    X6=[X6; x y];
end
X6=X6';

% Plot the data set
figure(1), plot(X6(1,:),X6(2,:),'.b')
figure(1), axis equal


% Apply the k-means algorithm
m=4;
[l,N]=size(X6);
rand('seed',0)
theta_ini=rand(l,m);
[theta,bel,J]=k_means(X6,theta_ini);

% Plot X6, using different colors for points from different clusters
figure(2), hold on
figure(2), plot(X6(1,bel==1),X6(2,bel==1),'r.',...
X6(1,bel==2),X6(2,bel==2),'g*',X6(1,bel==3),X6(2,bel==3),'bo',...
X6(1,bel==4),X6(2,bel==4),'cx',X6(1,bel==5),X6(2,bel==5),'md',...
X6(1,bel==6),X6(2,bel==6),'yp',X6(1,bel==7),X6(2,bel==7),'ks')
figure(2), plot(theta(1,:),theta(2,:),'k+')
figure(2), axis equal

