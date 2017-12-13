% Example 3.5.2
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear;

% 1. Generate the points of X that belong to class +1
rand('seed',0)
noise_level=0.1;
n_points=[100 100]; %Points per class
l=3;
X=rand(l,n_points(1))- (0.5*ones(l,1))*ones(1,n_points(1));

% Generate the points of X that belong to class -1
r=2; %Radius of the sphere
for i=1:n_points(2)/2
    e=1;
    while(e==1)
        temp=(2*r)*rand(1,l-1)-r;
        if(r^2-sum(temp.^2)>0)
            e=0;
        end
    end
    t=sqrt(r^2-sum(temp.^2))+noise_level*(rand-0.5);
    qw=[temp t; temp -t]';
    X=[X qw];
end

% The data set Xtest is now generated similarly (we use the value 100 as the seed for the rand function).
% Generate the points of Xtest that belong to class +1
rand('seed',100)
noise_level=0.1;
n_points=[100 100]; %Points per class
l=3;
X_test=rand(l,n_points(1))- (0.5*ones(l,1))*ones(1,n_points(1));

% Generate the points of Xtest that belong to class -1
r=2; %Radius of the sphere
for i=1:n_points(2)/2
    e=1;
    while(e==1)
        temp=(2*r)*rand(1,l-1)-r;
        if(r^2-sum(temp.^2)>0)
            e=0;
        end
    end
    t=sqrt(r^2-sum(temp.^2))+noise_level*(rand-0.5);
    qw=[temp t; temp -t]';
    X_test=[X_test qw];
end


% Define the class labels for X and X_test
[l,N]=size(X);
y=[ones(1,n_points(1)) -ones(1,n_points(2))];
y_test=[ones(1,n_points(1)) -ones(1,n_points(2))];

% Plot dataset X
figure(1), plot3(X(1,y==1),X(2,y==1),X(3,y==1),'r.',X(1,y==-1),X(2,y==-1),X(3,y==-1),'b+')
figure(1), axis equal

% 2. To perform kernel PCA with kernel exponential and sigma = 1 type

[s,V,Y]=kernel_PCA(X,2,'exp',[1 0]);

% Note that Y contains in its columns the images of the points of X on the
% space spanned by the first two principal components, while V contains the
% respective principal components.

% Plot Y
figure(2), plot(Y(1,y==1),Y(2,y==1),'r.',Y(1,y==-1),Y(2,y==-1),'b+')

% 3. To design the LS classifier based on Y , type
w=SSErr([Y; ones(1,sum(n_points))],y,0)

% 4. In order to generate the Ytest set, containing in its columns the projections of the vectors of
% Xtest to the space spanned by the principal components, type
[l,N_test]=size(X_test);
Y_test=[];
for i=1:N_test
    [temp]=im_point(X_test(:,i),X,V,2,'exp',[1 0]);
    Y_test=[Y_test temp];
end

% To classify the vectors of Xtest (Ytest) and compute the classification error type
y_out=2*(w'*[Y_test; ones(1,sum(n_points))]>0)-1;
class_err=sum(y_out.*y_test<0)/sum(n_points);
figure(3), plot(Y_test(1,y==1),Y_test(2,y==1),'r.',Y_test(1,y==-1),Y_test(2,y==-1),'b+')
figure(3), axis equal

% Plot the linear classifier (works only if w(1)~=0)
y_lin=[min(Y_test(2,:)') max(Y_test(2,:)')];
x_lin=[(-w(3)-w(2)*y_lin(1))/w(1) (-w(3)-w(2)*y_lin(2))/w(1)];
figure(3), hold on
figure(3), line(x_lin,y_lin)

% 5. For this step, repeat the codes given in steps 2-4, where now in the call
% of the kernel PCA function (step 2), [1, 0] is replaced by [0.6, 0] (see also
% Figure 3.6(b)).

[s,V,Y]=kernel_PCA(X,2,'exp',[0.6 0]);
figure(4), plot(Y(1,y==1),Y(2,y==1),'r.',Y(1,y==-1),Y(2,y==-1),'b+')
w=SSErr([Y; ones(1,sum(n_points))],y,0)
[l,N_test]=size(X_test);
Y_test=[];
for i=1:N_test
    [temp]=im_point(X_test(:,i),X,V,2,'exp',[0.6 0]);
    Y_test=[Y_test temp];
end
y_out=2*(w'*[Y_test; ones(1,sum(n_points))]>0)-1;
class_err=sum(y_out.*y_test<0)/sum(n_points);
figure(5), plot(Y_test(1,y==1),Y_test(2,y==1),'r.',Y_test(1,y==-1),Y_test(2,y==-1),'b+')
figure(5), axis equal
y_lin=[min(Y_test(2,:)') max(Y_test(2,:)')];
x_lin=[(-w(3)-w(2)*y_lin(1))/w(1) (-w(3)-w(2)*y_lin(2))/w(1)];
figure(5), hold on
figure(5), line(x_lin,y_lin)

