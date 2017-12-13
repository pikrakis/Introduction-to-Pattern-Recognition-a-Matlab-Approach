% Example 3.2.2
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear;

% 1(a). To generate the data set X1 and a vector y1, whose i-th coordinate
% contains the class label of the i-th vector of X1, type
randn('seed',0)  
S=[.3 1.5; 1.5 9];
[l,l]=size(S);
mv=[-8 8; 8 8]';
N=200;
X1=[mvnrnd(mv(:,1),S,N); mvnrnd(mv(:,2),S,N)]';
y1=[ones(1,N), 2*ones(1,N)];


% 1(b). To compute the eigenvalues/eigenvectors and variance percentages required in this step type
m=2;
[eigenval,eigenvec,explained,Y,mean_vec]=pca_fun(X1,m);

% 1(c). The projections of the data points of X1 along the direction of the first
% principal component are contained in the first row of Y , returned by the
% function pca_fun above. 

% Plot X1
figure(1), hold on
figure(1), plot(X1(1,y1==1),X1(2,y1==1),'r.',X1(1,y1==2),X1(2,y1==2),'bo')

% Compute the projections of X1
w=eigenvec(:,1);
t1=w'*X1(:,y1==1);
t2=w'*X1(:,y1==2);
X_proj1=[t1;t1].*((w/(w'*w))*ones(1,length(t1)));
X_proj2=[t2;t2].*((w/(w'*w))*ones(1,length(t2)));

% Plot the projections
figure(1), plot(X_proj1(1,:),X_proj1(2,:),'k.',X_proj2(1,:),X_proj2(2,:),'ko')
figure(1), axis equal

% Plot the eigenvectors
figure(1), line([0; eigenvec(1,1)], [0; eigenvec(2,1)])
figure(1), line([0; eigenvec(1,2)], [0; eigenvec(2,2)])


% 2(a). To generate X2, the code for X1 is executed again where now m1 = [-1, 0]' and m2 = [1, 0]'
randn('seed',0)  
S=[.3 1.5; 1.5 9];
[l,l]=size(S);
mv=[-1 0; 1 0]';
N=200;
X1=[mvnrnd(mv(:,1),S,N); mvnrnd(mv(:,2),S,N)]';
y1=[ones(1,N), 2*ones(1,N)];

% 2(b). Compute the eigenvalues/eigenvectors and variance percentages required in this step
m=2;
[eigenval,eigenvec,explained,Y,mean_vec]=pca_fun(X1,m);

% 2(c).
% Plot X1
figure(2), hold on
figure(2), plot(X1(1,y1==1),X1(2,y1==1),'r.',X1(1,y1==2),X1(2,y1==2),'bo')

% Compute the projections of X1
w=eigenvec(:,1);
t1=w'*X1(:,y1==1);
t2=w'*X1(:,y1==2);
X_proj1=[t1;t1].*((w/(w'*w))*ones(1,length(t1)));
X_proj2=[t2;t2].*((w/(w'*w))*ones(1,length(t2)));

% Plot the projections
figure(2), plot(X_proj1(1,:),X_proj1(2,:),'k.',X_proj2(1,:),X_proj2(2,:),'ko')
figure(2), axis equal

% Plot the eigenvectors
figure(2), line([0; eigenvec(1,1)], [0; eigenvec(2,1)])
figure(2), line([0; eigenvec(1,2)], [0; eigenvec(2,2)])
