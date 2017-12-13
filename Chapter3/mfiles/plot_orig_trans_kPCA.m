function plot_orig_trans_kPCA(X,V,m,choice,para,w,reg_spec,fig_or,fig_tr)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   plot_orig_trans_kPCA(X,V,m,choice,para,w,reg_spec,fig_or,fig_tr)
% Visualizes the effect of a classifier in the original
% (two-dimensional) data space and the space spanned by the two most
% significant principal components produced after the application of kernel
% PCA on a given data set. More specifically, the data points under study
% stem from two classes and a linear classifier is designed (in the
% transformed space) to separate them. Then a grid of points, that covers
% the area where the data points of X lie, is considered and its points are
% classified according to the previously mentioned classifier (see also the
% classification example in the kernel PCA section).
%
% INPUT ARGUMENTS:
%   X:      lxN matrix whose columns are the vectors on
%           which kernel PCA has been performed. It contains data from two
%           two-dimensional classes.
%   V:      NxN whose columns are the eigenvectors
%           corresponding to the principal components obtained after
%           performing kernel PCA on X.
%   m:      the number of the most signifiant principal components (columns
%           of V) that will be taken into account.
%   choice: the type of kernel function to be used: (a) polynomial ('pol')
%           or (b) exponential ('exp').
%   para:   a two-dimensional vector containing the parameters for the
%           kernel function: (a) for polynomials it is
%           (x'*y+para(1))^para(2) and (b) for exponentials it is
%           exp(-(x-y)'*(x-y)/(2*para(1)^2)).
%   w:      the parameter vector of the linear classifier produced based on
%           the images of the points of X in the space spanned by the two
%           most significant principal components produced after the
%           application of the kernel PCA on X.
%   reg_spec: a 2x3 matrix containing specifications for the
%           grid to be applied on the region of the data. Specifically, its
%           first row contains (i) the leftmost point, (ii) the ``scaning''
%           step (resolution) and (iii) the rightmost point in the
%           x-direction. The 2nd row contains the same information for the
%           y-direction.
%   fig_or: the number of the MATLAB figure where X_test is plotted in the
%           original space. Also, the points of a grid applied on the
%           region where the data lie are classified and plotted in this
%           figure.
%   fig_tr: the figure handle where X_test is plotted in the
%           transformed space.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

X_orig_green=[];
X_orig_cyan=[];
X_trans_green=[];
X_trans_cyan=[];
green=0;
cyan=0;
for i=reg_spec(1,1):reg_spec(1,2):reg_spec(1,3)
    for j=reg_spec(2,1):reg_spec(2,2):reg_spec(2,3)
        X_orig=[i;j];
        X_trans=im_point(X_orig,X,V,2,choice,para);
        X_trans=[X_trans; 1];
        if(w'*X_trans>0)
            green=green+1;
            X_orig_green=[X_orig_green X_orig];
            X_trans_green=[X_trans_green X_trans];
        else
            cyan=cyan+1;
            X_orig_cyan=[X_orig_cyan X_orig];
            X_trans_cyan=[X_trans_cyan X_trans];
        end
    end
end

figure(fig_or), plot(X_orig_green(1,:),X_orig_green(2,:),'go',X_orig_cyan(1,:),X_orig_cyan(2,:),'cx')
figure(fig_tr), plot(X_trans_green(1,:),X_trans_green(2,:),'go',X_trans_cyan(1,:),X_trans_cyan(2,:),'cx')