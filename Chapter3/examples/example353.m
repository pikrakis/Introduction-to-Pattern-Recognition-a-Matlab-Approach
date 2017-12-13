% Example 3.5.3
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear;

% 1. Generate the dataset X1
rand('seed',0)
noise_level=0.1;
n_points=[100 100 100];
l=2;
% 1st class
X1=rand(l,n_points(1))- [2.5 0.5]'*ones(1,n_points(1));
% 2nd class
X1=[X1 rand(l,n_points(2))- [-0.5 2.5]'*ones(1,n_points(2))];
% 3rd class
c1=[0 0];
r1=4;
b1=c1(1)-r1;
b2=c1(1)+r1;
step=(b2-b1)/(n_points(2)/2-1);
for t=b1:step:b2
    temp=[t c1(2)+sqrt(r1^2-(t-c1(1))^2)+noise_level*(rand-0.5);t c1(2)-sqrt(r1^2-(t-c1(1))^2)+noise_level*(rand-0.5)]';
    X1=[X1 temp];
end

% Generate labels 
y1=[ones(1,n_points(1)) 2*ones(1,n_points(2)) 3*ones(1,n_points(3))];

% Plot X1
figure(1), plot(X1(1,y1==1),X1(2,y1==1),'r.',X1(1,y1==2),X1(2,y1==2),'bx',X1(1,y1==3),X1(2,y1==3),'go')

% 2. Perform kernel PCA on X1 with exponential kernel function (sigma = 1)
m=2;
[s,V,Y1]=kernel_PCA(X1,m,'exp',[1 0]);

% Plot Y1
figure(2), plot(Y1(1,y1==1),Y1(2,y1==1),'r.',Y1(1,y1==2),Y1(2,y1==2),'bx',Y1(1,y1==3),Y1(2,y1==3),'go')

% Work similarly for X2.
rand('seed',0)
X2=[];
noise_level=0.1;
n_points=[100 100 100];

% 1st class
c1=[0 0];
r1=2;
b1=c1(1)-r1;
b2=c1(1)+r1;
step=(b2-b1)/(n_points(2)/2-1);
for t=b1:step:b2
    temp=[t c1(2)+sqrt(r1^2-(t-c1(1))^2)+noise_level*(rand-0.5);t c1(2)-sqrt(r1^2-(t-c1(1))^2)+noise_level*(rand-0.5)]';
    X2=[X2 temp];
end

% 2nd class
c1=[0 0];
r1=4;
b1=c1(1)-r1;
b2=c1(1)+r1;
step=(b2-b1)/(n_points(2)/2-1);
for t=b1:step:b2
    temp=[t c1(2)+sqrt(r1^2-(t-c1(1))^2)+noise_level*(rand-0.5);t c1(2)-sqrt(r1^2-(t-c1(1))^2)+noise_level*(rand-0.5)]';
    X2=[X2 temp];
end

% 3d class
c1=[0 0];
r1=6;
b1=c1(1)-r1;
b2=c1(1)+r1;
step=(b2-b1)/(n_points(2)/2-1);
for t=b1:step:b2
    temp=[t c1(2)+sqrt(r1^2-(t-c1(1))^2)+noise_level*(rand-0.5);t c1(2)-sqrt(r1^2-(t-c1(1))^2)+noise_level*(rand-0.5)]';
    X2=[X2 temp];
end

% Generate labels 
y2=[ones(1,n_points(1)) 2*ones(1,n_points(2)) 3*ones(1,n_points(3))];

% Plot X2
figure(3), plot(X2(1,y2==1),X2(2,y2==1),'r.',X2(1,y2==2),X2(2,y2==2),'bx',X2(1,y2==3),X2(2,y2==3),'go')

% 2. Perform kernel PCA on X1 with exponential kernel function (sigma = 1)
m=2;
[s,V,Y2]=kernel_PCA(X2,m,'exp',[1 0]);

% Plot Y2
figure(4), plot(Y2(1,y2==1),Y2(2,y2==1),'r.',Y2(1,y2==2),Y2(2,y2==2),'bx',Y2(1,y2==3),Y2(2,y2==3),'go')

