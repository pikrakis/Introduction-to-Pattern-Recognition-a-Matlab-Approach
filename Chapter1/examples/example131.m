% Example 1.3.1
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear;

% Use function comp_gauss_dens_val to compute the value of the Gaussian pdf.
m=[0 1]'; S=eye(2);
x1=[0.2 1.3]'; x2=[2.2 -1.3]';
pg1=comp_gauss_dens_val(m,S,x1)
pg2=comp_gauss_dens_val(m,S,x2)