% Example 1.4.1
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear;

% 1. Utilize function euclidean_classifier by typing
x=[0.1 0.5 0.1]';
m1=[0 0 0]'; 
m2=[0.5 0.5 0.5]';
m=[m1 m2];
z=euclidean_classifier(m,x)

% 2. Use function mahalanobis_classifier
x=[0.1 0.5 0.1]';
m1=[0 0 0]'; 
m2=[0.5 0.5 0.5]';
m=[m1 m2];
S=[0.8 0.01 0.01;
   0.01 0.2 0.01; 
   0.01 0.01 0.2];
z=mahalanobis_classifier(m,S,x)



