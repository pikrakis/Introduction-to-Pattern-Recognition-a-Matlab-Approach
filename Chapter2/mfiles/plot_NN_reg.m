function plot_NN_reg(net,bou,resolu,fig_num)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%  plot_NN_reg(net,bou,resolu,fig_num)
% Plots in the original space the decision boundary defined
% by a neural network.
%
% INPUT ARGUMENTS:
%  net:     the neural network specifications (in the programming structure
%           used by MATLAB).
%  bou:     a two-dimensional vector whose elements are the minimum and
%           maximum values along both the x-axis and the y-axis of the data
%           space.
%  resolu:  the resolution with which the decision boundary is determined
%           (the smaller its value the higher the resolution). A typical
%           value is (bou(2)-bou(1))/100.
%  fig_num: the figure handle on which the plot will be performed.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t=round(((bou(2)-bou(1))/resolu)+1);
t_vec=bou(1):resolu:bou(2);
t_vec=t_vec';

X1=[];
for i=bou(1):resolu:bou(2)
    X1=[X1; i*ones(t,1) t_vec];
end

X1=X1';

out_vec=2*(sim(net,X1)>0)-1;

figure(fig_num), plot(X1(1,out_vec>0),X1(2,out_vec>0),'m.',X1(1,out_vec<0),X1(2,out_vec<0),'c.')