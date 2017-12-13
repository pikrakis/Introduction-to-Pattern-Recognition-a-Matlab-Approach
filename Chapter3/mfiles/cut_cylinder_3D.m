function [X,color_tot,patt_id]=cut_cylinder_3D(r,center,N,plot_req,fig_id)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [X,color_tot,patt_id]=cut_cylinder_3D(r,center,N,plot_req,fig_id)
% Produces a cut cylinder in the three dimensional space.
% The cut cylinder is defined as a pack of 11 identical circles, such
% that for each one of them only its points in the range [0, 3*pi/2] are
% considered.
%
% INPUT ARGUMENTS:
%   r:          the radius of the base of the cylinder.
%   center:     the center of a two-dimensional circle.
%   N:          the number of points in a two-dimensional circle.
%   plot_req:   if it is equal to 1, the spiral is plotted. Otherwise the
%               spiral is not plotted.
%   fig_id:     The id number of the figure where the spiral will be plotted
%               (0 when plot_req is not equal to 1).
%
% OUTPUT ARGUMENTS:
%   X:          3xN matrix whose columns are the elements of the cylinder.
%   color_tot:  3xN matrix whose i-th column contains the (3-dimensional)
%               color code that will be used when plotting the i-th
%               vector (all data vectors that have equal values in their first
%               two coordinates are plotted with the same color).
%   patt_id:    N-dimensional vector, whose i-th element is the symbol that
%               will be used for plotting the i-th data vector (the points of
%               each 2-dimensional spiral are plotted with the same symbol).
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

b1=center(1)-r;
b2=center(1)+r;
step=(b2-b1)/(N-1);

r_tot=[];
x_tot=[];
y_tot=[];
z_tot=[];
z_compl=-1:.2:1;
z_compl=z_compl';
zl=length(z_compl);

t=fix( (b2-b1)/step + 1);

t1=2^(ceil(log2(6*t)));

qw=colormap(hsv(t1));
color_tot=[];
count=0;
for t=b1:step:b2
    count=count+1;
    x_tot=[x_tot; t*ones(zl,1)];
    y_tot=[y_tot; (center(2)+sqrt(r^2-(t-center(1))^2))*ones(zl,1)];
    z_tot=[z_tot; z_compl];
    color_tot=[color_tot; ones(zl,1)*qw(6*count,:)];
end

for t=b2:-step:b1/4
    count=count+1;
    x_tot=[x_tot; t*ones(zl,1)];
    y_tot=[y_tot; (center(2)-sqrt(r^2-(t-center(1))^2))*ones(zl,1)];
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