% Example 1.8.1
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear;

% 1. The pdf is actually a Gaussian mixture model. 
% To this end, utilize the function generate_gauss_classes to generate the required dataset
m=[0; 1]';
S(:,:,1)=[1];
S(:,:,2)=[1];
P=[1/3 2/3];
N=100;
randn('seed',0);
[X]=generate_gauss_classes(m,S,P,N);

% Plot the pdf
x=-5:0.1:5;
pdfx=(1/3)*(1/sqrt(2*pi))*exp(-(x.^2)/2)+(2/3)*(1/sqrt(2*pi))*exp(-((x-1).^2)/2);
plot(x,pdfx); hold;

% Use function knn_density_estimate to estimate the pdf (k=21)
pdfx_approx=knn_density_estimate(X,21,-5,5,0.1);
plot(-5:0.1:5,pdfx_approx,'r');


