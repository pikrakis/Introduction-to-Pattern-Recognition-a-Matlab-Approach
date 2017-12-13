% Example 1.3.2
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear;

% Utilize function comp_gauss_dens_val
P1=0.5;
P2=0.5;
m1=[1 1]'; 
m2=[3 3]'; 
S=eye(2); 
x=[1.8 1.8]';
p1=P1*comp_gauss_dens_val(m1,S,x)
p2=P2*comp_gauss_dens_val(m2,S,x)