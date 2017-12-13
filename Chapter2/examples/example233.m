% Example 2.3.3
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
N1=1000;
randn('seed',0)
[X1,y1]=generate_gauss_classes(m,S,P,N1);
[l,N1]=size(X1);
X1=[X1; ones(1,N1)];

% Plot X1 using different colors for points of different classes,
figure(1), plot3(X1(1,y1==1),X1(2,y1==1),X1(3,y1==1),'r.',...
    X1(1,y1==2),X1(2,y1==2),X1(3,y1==2),'g.',...
    X1(1,y1==3),X1(2,y1==3),X1(3,y1==3),'b.')

% Next, we define matrix z1, each column of which
% corresponds to a training point.
z1=zeros(c,N1);
for i=1:N1
    z1(y1(i),i)=1;
end

% Generate X2
N2=10000;
randn('seed',100)
[X2,y2]=generate_gauss_classes(m,S,P,N2);
[l,N2]=size(X2);
X2=[X2; ones(1,N2)];

% Define matrix z2
z2=zeros(c,N2);
for i=1:N2
    z2(y2(i),i)=1;
end

% Estimate the parameter vectors of the three discriminant functions
w_all=[];
for i=1:c
    w=SSErr(X1,z1(i,:),0);
    w_all=[w_all w];
end
% Note: in w_all, the i-th column corresponds to the parameter vector of the i-th discriminant function.

% Compute the classification error using the set X2
[vali,class_est]=max(w_all'*X2);
err=sum(class_est~=y2)/N2


% 2. Compute the estimates of the a-posteriori probabilities, as they result in the framework
% of the LS classifier
aposte_est=w_all'*X2;

% Compute the true a posteriori probabilities
aposte=[];
for i=1:N2
    t=zeros(c,1);
    for j=1:c
        t(j)=comp_gauss_dens_val(m(:,j),S(:,:,j),X2(1:l,i))*P(j);
    end
    tot_t=sum(t);
    aposte=[aposte t/tot_t];
end

% Compute the average square error of the estimation of the posterior probabilities
approx_err=sum(sum((aposte-aposte_est).^2))/(N2*c)

% 3. Compute the optimal Bayesian classification error (the true a-posteriori 
% probabilities are known)
[vali,class]=max(aposte);
err_ba=sum(class~=y2)/N2
