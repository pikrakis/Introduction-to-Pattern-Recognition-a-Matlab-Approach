% Example 2.7.1
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear

% Generate the subset X1 of X, which contains the data points from the first class
m11=[1.25 1.25]'; m12=[2.75 4.5]';m13=[2 11]';
m1=[m11 m12 m13];
S1(:,:,1)=0.1*eye(2);
S1(:,:,2)=0.2*eye(2);
S1(:,:,3)=0.3*eye(2);
P1=[0.4 0.4 0.2];
N1=50;
sed=0;
[X1,y1]=mixt_model(m1,S1,P1,N1,sed);

% The subset X2 of X, with the points from the second class is generated similarly (use again sed = 0)
m21=[2.75 0]'; m22=[1.25 2.75]';m23=[4 8]';
m2=[m21 m22 m23];
S2(:,:,1)=0.1*eye(2);
S2(:,:,2)=0.2*eye(2);
S2(:,:,3)=0.3*eye(2);
P2=[0.2 0.3 0.5];
N2=50;
sed=0;
[X2,y2]=mixt_model(m2,S2,P2,N2,sed);
X=[X1 X2];
y=[ones(1,N1) -ones(1,N2)];
% Plot X
figure(1), hold on
figure(1), plot(X(1,y==1),X(2,y==1),'r.',X(1,y==-1),X(2,y==-1),'bx')


% 1.
T_max=3000; % max number of base classifiers
[pos_tot, thres_tot, sleft_tot, a_tot, P_tot,K] = boost_clas_coord(X, y, T_max);

% 2.
[y_out, P_error] =boost_clas_coord_out(pos_tot, thres_tot, sleft_tot, a_tot, P_tot,K,X, y);
figure(2), plot(P_error)

% 3.
% Dataset Z is also generated in two steps,i.e., 50 points are first generated from 
% the first class (dataset Z1)
mZ11=[1.25 1.25]'; mZ12=[2.75 4.5]';mZ13=[2 11]';
mZ1=[mZ11 mZ12 mZ13];
SZ1(:,:,1)=0.1*eye(2);
SZ1(:,:,2)=0.2*eye(2);
SZ1(:,:,3)=0.3*eye(2);
wZ1=[0.4 0.4 0.2];
NZ1=50;
sed=100;
[Z1,yz1]=mixt_model(mZ1,SZ1,wZ1,NZ1,sed);

% The remaining 50 points from the second class (dataset Z2) are generated similarly (use
% again sed = 100).
mZ21=[2.75 0]'; mZ22=[1.25 2.75 ]';mZ23=[4 8]';
mZ2=[mZ21 mZ22 mZ23];
SZ2(:,:,1)=0.1*eye(2);
SZ2(:,:,2)=0.2*eye(2);
SZ2(:,:,3)=0.3*eye(2);
wZ2=[0.2 0.3 0.5];
NZ2=50;
sed=100;
[Z2,yz2]=mixt_model(mZ2,SZ2,wZ2,NZ2,sed);
% Form Z and respective labels
Z=[Z1 Z2];
y=[ones(1,NZ1) -ones(1,NZ2)];

% Classify the vectors of Z
[y_out_Z, P_error_Z] =boost_clas_coord_out(pos_tot, thres_tot, sleft_tot, a_tot, P_tot,K,Z, y);
figure(3), plot(P_error_Z)

