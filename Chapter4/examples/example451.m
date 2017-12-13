% Example 4.5.1
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear;

% 1. Generate the two classes
randn('seed',0);
N=200;
m1=2;m2=0;var1=1;var2=1;
class1=m1+var1*randn(1,N);
class2=m2+var2*randn(1,N);

% 2. Plot the histograms of the two classes
figure(1);
plotHist(class1,class2);

% 3. Create the array of class labels
classlabels = [1*ones(N,1); -1*ones(N,1)];

% Use the ROC function to calculate and plot the results
figure(2);
[AUC_Value] = ROC([class1 class2]',classlabels,1); % The last argument has been set to 1, because a plot
% will be generated.