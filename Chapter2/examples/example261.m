% Example 2.6.1
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear

l=2;   % Dimensionality
N=150; % Number of vectors

% Generate the training set X1
rand('seed',0)
X1=10*rand(l,N)-5;
for i=1:N
    t=0.05*(X1(1,i)^3+X1(1,i)^2+X1(1,i)+1);
    if(t>X1(2,i))
        y1(i)=1;
    else
        y1(i)=-1;
    end
end

% Generate the test set X2
rand('seed',100)
X2=10*rand(l,N)-5;
for i=1:N
    t=0.05*(X2(1,i)^3+X2(1,i)^2+X2(1,i)+1);
    if(t>X2(2,i))
        y2(i)=1;
    else
        y2(i)=-1;
    end
end

% 1.

%  --- add/remove comments as appropriate
% Run the kernel perceptron algorithm for the linear kernel
% kernel='linear';
% kpar1=0;
% kpar2=0;
% max_iter=30000;
% [a,iter,count_misclas]=kernel_perce(X1,y1,kernel,kpar1,kpar2,max_iter);

%  --- add/remove comments as appropriate
% Run the algorithm using the radial basis kernel function
kernel='rbf';
kpar1=0.1;
kpar2=0;
max_iter=30000;
[a,iter,count_misclas]=kernel_perce(X1,y1,kernel,kpar1,kpar2,max_iter);

% --- add/remove comments as appropriate
% Run the algorithm using the polynomial kernel function
% kernel='poly';
% kpar1=1;
% kpar2=3;
% max_iter=30000;
% [a,iter,count_misclas]=kernel_perce(X1,y1,kernel,kpar1,kpar2,max_iter);

% Compute the training error
for i=1:N
    K=CalcKernel(X1',X1(:,i)',kernel,kpar1,kpar2)';
    out_train(i)=sum((a.*y1).*K)+sum(a.*y1);
end
err_train=sum(out_train.*y1<0)/length(y1)
% where N is the number of training vectors.

% Compute the test error
for i=1:N
    K=CalcKernel(X1',X2(:,i)',kernel,kpar1,kpar2)';
    out_test(i)=sum((a.*y1).*K)+sum(a.*y1);
end
err_test=sum(out_test.*y2<0)/length(y2)

% Count the number of training vectors 
sum_pos_a=sum(a>0)

% 2. Plot the training set (see book Figures 2.7 and 2.8)
figure(1), hold on
figure(1), plot(X1(1,y1==1),X1(2,y1==1),'ro',...
    X1(1,y1==-1),X1(2,y1==-1),'b+')
figure(1), axis equal
% Note that the vectors of the training set from class 1 (?1) are marked by
% "o” (“+”). 

% Plot the decision boundary in the same figure
bou_x=[-5 5];
bou_y=[-5 5];
resolu=.05;
fig_num=1;
plot_kernel_perce_reg(X1,y1,a,kernel,kpar1,kpar2,bou_x,bou_y, resolu,fig_num)
