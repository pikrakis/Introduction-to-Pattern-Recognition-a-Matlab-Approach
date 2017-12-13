% Example 2.4.2
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear;

m=[1 1 1; 5 3 2; 3 3 4]';
[l,c]=size(m);
S1=[0.8 0.2 0.1; 0.2 0.8 0.2; 0.1 0.2 0.8];
S(:,:,1)=S1;
S(:,:,2)=S1;
S(:,:,3)=S1;
P=[1/3 1/3 1/3];

% 1. Generate X1
N1=120;
randn('seed',0)
[X1,y1]=generate_gauss_classes(m,S,P,N1);
[l,N1]=size(X1);
X1=[X1; ones(1,N1)];

% Generate X2
N2=120;
randn('seed',100)
[X2,y2]=generate_gauss_classes(m,S,P,N2);
[l,N2]=size(X2);
X2=[X2; ones(1,N2)];

% Generate z1
z1=-ones(c,N1);
for i=1:N1
    z1(y1(i),i)=1;
end

% Generate z2
z2=-ones(c,N2);
for i=1:N2
    z2(y2(i),i)=1;
end

% Plot X1
figure(1), plot3(X1(1,z1(1,:)==1),X1(2,z1(1,:)==1),...
    X1(3,z1(1,:)==1),'r.',X1(1,z1(2,:)==1),X1(2,z1(2,:)==1),...
    X1(3,z1(2,:)==1),'gx',X1(1,z1(3,:)==1),X1(2,z1(3,:)==1),...
    X1(3,z1(3,:)==1),'bo')

% 2. Compute the SVM classifiers
kernel='linear';
kpar1=0;
kpar2=0;
C=20;
tol=0.001;
steps=100000;
eps=10^(-10);
method=1;
for i=1:c
    [alpha(:,i), w0(i), w(i,:), evals, stp, glob] = SMO2(X1', z1(i,:)', kernel, kpar1, kpar2, C,...
        tol, steps, eps, method);
    marg(i)=2/sqrt(sum(w(i,:).^2));
    sup_vec(i)=sum(alpha(:,i)>0);
end
marg,sup_vec

% Estimate the classification error based on X2
[vali,class_est]=max(w*X2-w0'*ones(1,N2));
err_svm=sum(class_est~=y2)/N2

