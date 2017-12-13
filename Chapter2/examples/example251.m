% Example 2.5.1
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear

format compact
global figt4

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

% Plot the training set X1
figure(1), plot(X1(1,y1==1),X1(2,y1==1),'r.',X1(1,y1==-1),X1(2,y1==-1),'bo')
figure(1), axis equal

%%%%%%%%%%%%%%%%%%%%% Linear SVM %%%%%%%%%%%%%%%%%%%%% 
fprintf('\n\n');
figt4=2;

kernel='linear'
kpar1=0; 
kpar2=0; 
C=2;
tol=0.001;
steps=100000;
eps=10^(-10);
method=1;
[alpha, b, w, evals, stp, glob] = SMO2(X1', y1', kernel, kpar1, kpar2, C, tol, steps, eps, method);

mag=0.1;
xaxis=1;
yaxis=2;
input = zeros(1,size(X1',2));
bias=-b; 
aspect=0;
svcplot_book(X1',y1',kernel,kpar1,kpar2,alpha,bias,aspect,mag,xaxis,yaxis,input);

figure(figt4), axis equal

X_sup=X1(:,alpha'~=0);
alpha_sup=alpha(alpha~=0)';
y_sup=y1(alpha~=0);

% Classification of the training set
for i=1:N
    t=sum((alpha_sup.*y_sup).*CalcKernel(X_sup',X1(:,i)',kernel,kpar1,kpar2)')-b;
    if(t>0)
        out_train(i)=1;
    else
        out_train(i)=-1;
    end
end

% Classification of the test set
for i=1:N
    t=sum((alpha_sup.*y_sup).*CalcKernel(X_sup',X2(:,i)',kernel,kpar1,kpar2)')-b;
    if(t>0)
        out_test(i)=1;
    else
        out_test(i)=-1;
    end
end

% Margin
marg=2/sum(w.^2)

% Computing the training error
Pe_train=sum(out_train.*y1<0)/length(y1)

% Computing the test error
Pe_test=sum(out_test.*y2<0)/length(y2)

%Counting the number of support vectors
sup_vec=sum(alpha>0)


% %%%%%%%%%%%%%%%%%%% RBF kernel%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figt4=3;
fprintf('\n\n');

kernel='rbf'
kpar1=0.1; 
kpar2=0; 
C=2;
tol=0.001;
steps=100000;
eps=10^(-10);
method=1;
[alpha, b, w, evals, stp, glob] = SMO2(X1', y1', kernel, kpar1, kpar2, C, tol, steps, eps, method);

mag=0.1;
xaxis=1;
yaxis=2;
input = zeros(1,size(X1',2));
bias=-b;  
aspect=0;
svcplot_book(X1',y1',kernel,kpar1,kpar2,alpha,bias,aspect,mag,xaxis,yaxis,input);

figure(figt4), axis equal

X_sup=X1(:,alpha'~=0);
alpha_sup=alpha(alpha~=0)';
y_sup=y1(alpha~=0);

% Classification of the training set
for i=1:N
    t=sum((alpha_sup.*y_sup).*CalcKernel(X_sup',X1(:,i)',kernel,kpar1,kpar2)')-b;
    if(t>0)
        out_train(i)=1;
    else
        out_train(i)=-1;
    end
end

% Classification of the test set
for i=1:N
    t=sum((alpha_sup.*y_sup).*CalcKernel(X_sup',X2(:,i)',kernel,kpar1,kpar2)')-b;
    if(t>0)
        out_test(i)=1;
    else
        out_test(i)=-1;
    end
end

% Computing the training error
Pe_train=sum(out_train.*y1<0)/length(y1)

% Computing the test error
Pe_test=sum(out_test.*y2<0)/length(y2)

%Counting the number of support vectors
sup_vec=sum(alpha>0)

% %%%%%%%%%%%%%%% POLYNOMIAL KERNEL %%%%%%%%%%%%%%%%%%%%%%%
figt4=4;
fprintf('\n\n');

kernel='poly'
kpar1=0; 
kpar2=5; 
C=2;
tol=0.001;
steps=100000;
eps=10^(-10);
method=1;
[alpha, b, w, evals, stp, glob] = SMO2(X1', y1', kernel, kpar1, kpar2, C, tol, steps, eps, method);

mag=0.1;
xaxis=1;
yaxis=2;
input = zeros(1,size(X1',2));
bias=-b;  
aspect=0;
svcplot_book(X1',y1',kernel,kpar1,kpar2,alpha,bias,aspect,mag,xaxis,yaxis,input);

figure(figt4), axis equal

X_sup=X1(:,alpha'~=0);
alpha_sup=alpha(alpha~=0)';
y_sup=y1(alpha~=0);

% Classification of the training set
for i=1:N
    t=sum((alpha_sup.*y_sup).*CalcKernel(X_sup',X1(:,i)',kernel,kpar1,kpar2)')-b;
    if(t>0)
        out_train(i)=1;
    else
        out_train(i)=-1;
    end
end

% Classification of the test set
for i=1:N
    t=sum((alpha_sup.*y_sup).*CalcKernel(X_sup',X2(:,i)',kernel,kpar1,kpar2)')-b;
    if(t>0)
        out_test(i)=1;
    else
        out_test(i)=-1;
    end
end

% Computing the training error
Pe_train=sum(out_train.*y1<0)/length(y1)

% Computing the test error
Pe_test=sum(out_test.*y2<0)/length(y2)

%Counting the number of support vectors
sup_vec=sum(alpha>0)

