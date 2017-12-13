function plot_kernel_perce_reg(X,y,a,kernel,kpar1,kpar2,bou_x,bou_y, resolu,fig_num)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%  plot_kernel_perce_reg(X,y,a,kernel,kpar1,kpar2,bou_x,bou_y, resolu,fig_num)
% This function plots in the original space the decision boundary
% determined by the kernel perceptron algorithm, based on a data set X.
%
% INPUT ARGUMENTS:
%  X:       lxN dimensional matrix whose columns are the data vectors.
%  y:       N-dimensional row vector whose i-th element equals to the
%           class label of the i-th data vector (+1 or -1).
%  kernel:  the kernel function adopted: (a) 'linear' for linear kernel
%           function, (b) 'rbf' for radial basis function, (c) 'poly' for
%           polynomial function etc.
%  kpar1,kpar2: parameters for the kernel functions. Specifically (a) for
%           the 'linear' kernel both are set equal to 0, (b) for the 'rbf'
%           kernel kpar1 corresponds to sigma parameter, while kpar2 is set
%           equal to 0, (c) for the 'poly' kernel it is (x'y+kpar1)^kpar2.
%  bou_x:   a two-dimensional vector whose elements are the minimum and
%           maximum values along the x-axis of the data space.
%  bou_y:   the same as above for the y-axis.
%  resolu:  the resolution with which the decision boundary is determined
%           (the smaller its value the higher the resolution). A typical
%           value is (bou_x(2)-bou_x(1))/100.
%  fig_num: the number of the figure on which the plot will be performed.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[l,N]=size(X);
ix=0;
for i=bou_x(1):resolu:bou_x(2)
    ix=ix+1;
    iy=0;
    for j=bou_y(1):resolu:bou_y(2)
        iy=iy+1;
        K=CalcKernel(X',[i j],kernel,kpar1,kpar2)';
        out(ix,iy)=2*(sum((a.*y).*K)+sum(a.*y)>0)-1;
    end
end

figure(fig_num), contour(bou_x(1):resolu:bou_x(2), bou_y(1):resolu:bou_y(2),out')
figure(fig_num), axis equal
