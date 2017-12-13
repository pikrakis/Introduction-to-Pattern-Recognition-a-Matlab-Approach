% Example 1.6.1
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear;

% Generate and plot dataset X
randn('seed',0);
m1=[1, 1]'; m2=[3, 3]';m3=[2, 6]';
m=[m1 m2 m3];

S(:,:,1)=0.1*eye(2);
S(:,:,2)=0.2*eye(2);
S(:,:,3)=0.3*eye(2);
P=[0.4 0.4 0.2];
N=500;
sed=0;
[X,y]=mixt_model(m,S,P,N,sed);
plot_data(X,y,m,1)

% 1. Use function em_alg_function to estimate the mixture model parameters
m1_ini=[0; 2];m2_ini=[5; 2];m3_ini=[5; 5];
m_ini=[m1_ini m2_ini m3_ini];
s_ini=[.15 .27 .4];
Pa_ini=[1/3 1/3 1/3];
e_min=10^(-5);
[m_hat,s_hat,Pa,iter,Q_tot,e_tot]=em_alg_function(X,m_ini,s_ini,Pa_ini,e_min);

% 2. Work as in step 1
m1_ini=[1.6; 1.4];
m2_ini=[1.4; 1.6];
m3_ini=[1.3; 1.5];
m_ini=[m1_ini m2_ini m3_ini];

s_ini=[.2 .4 .3];
Pa_ini=[.2 .4 .4];
e_min=10^(-5);
[m_hat,s_hat,Pa,iter,Q_tot,e_tot]=em_alg_function(X,m_ini,s_ini,Pa_ini,e_min);

% 3. Work as in step 1
m1_ini=[1.6; 1.4];
m2_ini=[1.4; 1.6];
m_ini=[m1_ini m2_ini];

s_ini=[.2 .4 ];
Pa_ini=[.5 .5 ];
e_min=10^(-5);
[m_hat,s_hat,Pa,iter,Q_tot,e_tot]=em_alg_function(X,m_ini,s_ini,Pa_ini,e_min);

