function [X,color_tot,patt_id]=spiral_3D(a,init_theta,fin_theta,step_theta,plot_req,fig_id)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [X,color_tot,patt_id]=spiral_3D(a,init_theta,fin_theta,step_theta,plot_req,fig_id)
%   Produces a 3-dimensional Archimedes spiral. In fact, the
%   Archimedes spiral is defined in the plane and it is decribed in polar
%   coordinates via the equation r=a*theta, where a is a parameter. Our
%   3-dimensional Archimedes spiral consists of a pack of 11 identical
%   two-dimensional spirals one above the other.
%
% INPUT ARGUMENTS:
%   a:          the spiral parameter.
%   init_theta: the initial value for the variable "theta".
%   fin_theta:  the final value fot the variable "theta".
%   step_theta: the step with which we move from the initial to the final
%               value of theta.
%   plot_req:   if it is equal to 1, the spiral is plotted. Otherwise the
%               spiral is not plotted.
%   fig_id:     the figure handle where the spiral will be
%               plotted (0 when plot_req is not equal to 1).
%
% OUTPUT ARGUMENTS:
%   X:          3xN matrix whose columns are the elements of the spiral.
%   color_tot:  3xN matrix whose i-th column contains the (3-dimensional
%               color code that will be used in the plot of the i-th
%               vector (all data vectors that have equal values in their first
%               two coordinates are plotted with the same color).
%   patt_id:    N-dimensional vector, whose i-th element is the symbol that
%               will be used for plotting the i-th data vector (the points of
%               each 2-dimensional spiral are plotted with the same symbol).
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

r_tot=[];
x_tot=[];
y_tot=[];
z_tot=[];
z_compl=-1:.2:1;
z_compl=z_compl';
zl=length(z_compl);

t=fix( (fin_theta-init_theta)/step_theta + 1);

t1=2^(ceil(log2(6*t)));

qw=colormap(hsv(t1));
color_tot=[];
count=0;
for theta=init_theta:step_theta:fin_theta
    count=count+1;
    r=a*theta;
    r_tot=[r_tot r];
    x_tot=[x_tot; r*cos(theta)*ones(zl,1)];
    y_tot=[y_tot; r*sin(theta)*ones(zl,1)];
    z_tot=[z_tot; z_compl];
    color_tot=[color_tot; ones(zl,1)*qw(6*count,:)];
end
X=[x_tot y_tot z_tot];
X=X';
[l,N]=size(X);
color_tot=color_tot';

temp=['.';'o';'x';'+';'*';'s';'d';'v';'>';'p';'h'];
patt_id=[];
for i=1:N
    t=int16((1+X(3,i))*5+1);
    patt_id=[patt_id temp(t)];
end

if(plot_req==1)
    figure(fig_id), hold on
    for i=1:N
        figure(fig_id), plot3(X(1,i),X(2,i),X(3,i),patt_id(i),'Color',color_tot(:,i))
    end
end
