% Example 1.7.1
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear;

% 1. The pdf is actually a Gaussian mixture model. 
% To this end, utilize the function generate_gauss_classes
%  to generate the required dataset
m=[0; 2]';
S(:,:,1)=[0.2];
S(:,:,2)=[0.2];
P=[1/3 2/3];
N=1000;
randn('seed',0);
[X]=generate_gauss_classes(m,S,P,N);

% Plot the pdf
x=-5:0.1:5;
pdfx=(1/3)*(1/sqrt(2*pi*0.2))*exp(-.5*(x.^2)/0.2)+(2/3)*(1/sqrt(2*pi*0.2))*exp(-.5*((x-2).^2)/0.2);
plot(x,pdfx); hold;

% 2. Compute and plot the approximation of the pdf for h = 0.1 and x in [-5, 5]
h=0.1;
pdfx_approx=Parzen_gauss_kernel(X,h,-5,5);
plot(-5:h:5,pdfx_approx,'r');
