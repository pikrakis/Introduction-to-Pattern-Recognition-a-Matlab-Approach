% Example 7.4.1
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear

% 1. Generate the data set X 
X=[2 5; 6 4; 5 3; 2 2; 1 4; 5 4; 3 3; 2 3;...
2 4; 8 2; 9 2; 10 2; 11 2; 10 3; 9 1]';
[l,N]=size(X);
% Plot the data set
figure (1), plot(X(1,:),X(2,:),'.')
figure(1), axis equal

% 2. Apply the BSAS algorithm on X
q=15; % maximum number of clusters
theta=2.5; % dissimilarity threshold
order=[8 6 11 1 5 2 3 4 7 10 9 12 13 14 15];
[bel_2, repre_2]=BSAS(X,theta,q,order)
pause;
fprintf('Press any key to continue');

% 3. Repeat the code given in step 2 for the new order of presentation of the data 
q=15; % maximum number of clusters
theta=2.5; % dissimilarity threshold
order=[7, 3, 1, 5, 9, 6, 8, 4, 2, 10, 15, 13, 14, 11, 12];
[bel_3, repre_3]=BSAS(X,theta,q,order)
pause;
fprintf('Press any key to continue');


% 4. Repeat step 2, where now theta = 1.4
q=15;
theta=1.4; % dissimilarity threshold
order=[8 6 11 1 5 2 3 4 7 10 9 12 13 14 15];
[bel_4, repre_4]=BSAS(X,theta,q,order)
pause;
fprintf('Press any key to continue');

% 5. Repeat step 2, where now the maximum allowable number of clusters, q, equals to 2.
q=2; % maximum number of clusters
theta=2.5; % dissimilarity threshold
order=[8 6 11 1 5 2 3 4 7 10 9 12 13 14 15];
[bel_5, repre_5]=BSAS(X,theta,q,order)
pause;
fprintf('Press any key to continue');

