% Example 3.6.1
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear;

% 1. Generate and plot the 3-dimensional spiral
a=0.1;
init_theta=0.5;
fin_theta=2.05*pi;
step_theta=0.2;
plot_req=1; % a plot of the spiral will be generated
fig_id=1; % figure handle
% Generate the 3D spiral
[X,color_tot,patt_id]=spiral_3D(a,init_theta,...
    fin_theta,step_theta,plot_req,fig_id);
[l,N]=size(X);

% 2. Perform the Laplacian eigenmap
e=0.35;
sigma2=sqrt(0.5);
m=2;
y=lapl_eig(X,e,sigma2,m);

% Plot the results
figure(2), hold on
for i=1:N
    figure(2), plot(y(1,i),y(2,i),patt_id(i),'Color',color_tot(:,i)')
end

% 3. Perform linear PCA
[eigenval,eigenvec,explain,Y]=pca_fun(X,m);

% Plot the results
figure(3), hold on
for i=1:N
    figure(3), plot(Y(1,i),Y(2,i),patt_id(i),'Color',color_tot(:,i)')
end
