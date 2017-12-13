% Example 1.4.2
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear;

% To generate X, utilize the function generate_gauss_classes
m=[0 0 0; 1 2 2; 3 3 4]';
S1=0.8*eye(3);
S(:,:,1)=S1;S(:,:,2)=S1;S(:,:,3)=S1;
P=[1/3 1/3 1/3]'; 
N=1000;
randn('seed',0);
[X,y]=generate_gauss_classes(m,S,P,N);

% The data set X1 is generated similarly
randn('seed',100);
[X1,y1]=generate_gauss_classes(m,S,P,N);

% 1. Compute the ML estimates of the mean values and covariance matrix (common to all three
% classes) using function Gaussian_ML_estimate
class1_data=X(:,find(y==1));
[m1_hat, S1_hat]=Gaussian_ML_estimate(class1_data);
class2_data=X(:,find(y==2));
[m2_hat, S2_hat]=Gaussian_ML_estimate(class2_data);
class3_data=X(:,find(y==3));
[m3_hat, S3_hat]=Gaussian_ML_estimate(class3_data);
S_hat=(1/3)*(S1_hat+S2_hat+S3_hat);
m_hat=[m1_hat m2_hat m3_hat];

% 2. Employ the Euclidean distance classifier, using the ML estimates of the means, in order to
% classify the data vectors of X1
z_euclidean=euclidean_classifier(m_hat,X1);

% 3. Similarly, for the Mahalanobis distance classifier, we have
z_mahalanobis=mahalanobis_classifier(m_hat,S_hat,X1);

% 4. For the Bayesian classifier, use function bayes classifier and provide as input the matrices
% m, S, P, which were used for the dataset generation.
z_bayesian=bayes_classifier(m,S,P,X1);

% 5. Compute the error probability for each classifier
err_euclidean = (1-length(find(y1==z_euclidean))/length(y1))
err_mahalanobis = (1-length(find(y1==z_mahalanobis))/length(y1))
err_bayesian = (1-length(find(y1==z_bayesian))/length(y1))
